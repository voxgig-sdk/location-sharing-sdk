-- LocationSharing SDK

local vs = require("utility.struct.struct")
local Utility = require("core.utility_type")
local Spec = require("core.spec")
local helpers = require("core.helpers")

-- Load utility registration (populates Utility._registrar)
require("utility.register")

-- Load features
local BaseFeature = require("feature.base_feature")
local features_factory = require("features")


local LocationSharingSDK = {}
LocationSharingSDK.__index = LocationSharingSDK


local function _make_feature(name)
  local factory = features_factory[name]
  if factory ~= nil then
    return factory()
  end
  return features_factory.base()
end

LocationSharingSDK._make_feature = _make_feature


function LocationSharingSDK.new(options)
  local self = setmetatable({}, LocationSharingSDK)
  self.mode = "live"
  self.features = {}
  self.options = nil

  local utility = Utility.new()
  self._utility = utility

  local config = require("config")()

  self._rootctx = utility.make_context({
    client = self,
    utility = utility,
    config = config,
    options = options or {},
    shared = {},
  }, nil)

  self.options = utility.make_options(self._rootctx)

  if vs.getpath(self.options, "feature.test.active") == true then
    self.mode = "test"
  end

  self._rootctx.options = self.options

  -- Add features from config.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local feature_items = vs.items(feature_opts)
    if feature_items ~= nil then
      for _, item in ipairs(feature_items) do
        local fname = item[1]
        local fopts = helpers.to_map(item[2])
        if fopts ~= nil and fopts["active"] == true then
          utility.feature_add(self._rootctx, _make_feature(fname))
        end
      end
    end
  end

  -- Add extension features.
  local extend = vs.getprop(self.options, "extend")
  if type(extend) == "table" then
    for _, f in ipairs(extend) do
      if type(f) == "table" and type(f.get_name) == "function" then
        utility.feature_add(self._rootctx, f)
      end
    end
  end

  -- Initialize features.
  for _, f in ipairs(self.features) do
    utility.feature_init(self._rootctx, f)
  end

  utility.feature_hook(self._rootctx, "PostConstruct")

  -- #BuildFeatures

  return self
end


function LocationSharingSDK:options_map()
  local out = vs.clone(self.options)
  if type(out) == "table" then
    return out
  end
  return {}
end


function LocationSharingSDK:get_utility()
  return Utility.copy(self._utility)
end


function LocationSharingSDK:get_root_ctx()
  return self._rootctx
end


function LocationSharingSDK:prepare(fetchargs)
  local utility = self._utility

  fetchargs = fetchargs or {}

  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "prepare",
    ctrl = ctrl,
  }, self._rootctx)

  local options = self.options

  local path = vs.getprop(fetchargs, "path") or ""
  if type(path) ~= "string" then path = "" end

  local method = vs.getprop(fetchargs, "method") or "GET"
  if type(method) ~= "string" then method = "GET" end

  local params = helpers.to_map(vs.getprop(fetchargs, "params")) or {}
  local query = helpers.to_map(vs.getprop(fetchargs, "query")) or {}

  local headers = utility.prepare_headers(ctx)

  local base = vs.getprop(options, "base") or ""
  if type(base) ~= "string" then base = "" end
  local prefix = vs.getprop(options, "prefix") or ""
  if type(prefix) ~= "string" then prefix = "" end
  local suffix = vs.getprop(options, "suffix") or ""
  if type(suffix) ~= "string" then suffix = "" end

  ctx.spec = Spec.new({
    base = base,
    prefix = prefix,
    suffix = suffix,
    path = path,
    method = method,
    params = params,
    query = query,
    headers = headers,
    body = vs.getprop(fetchargs, "body"),
    step = "start",
  })

  -- Merge user-provided headers.
  local uh = vs.getprop(fetchargs, "headers")
  if type(uh) == "table" then
    for k, v in pairs(uh) do
      ctx.spec.headers[k] = v
    end
  end

  local _, err = utility.prepare_auth(ctx)
  if err ~= nil then
    return nil, err
  end

  return utility.make_fetch_def(ctx)
end


function LocationSharingSDK:direct(fetchargs)
  local utility = self._utility

  local fetchdef, err = self:prepare(fetchargs)
  if err ~= nil then
    return { ok = false, err = err }, nil
  end

  fetchargs = fetchargs or {}
  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "direct",
    ctrl = ctrl,
  }, self._rootctx)

  local url = fetchdef["url"] or ""
  local fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

  if fetch_err ~= nil then
    return { ok = false, err = fetch_err }, nil
  end

  if fetched == nil then
    return {
      ok = false,
      err = ctx:make_error("direct_no_response", "response: undefined"),
    }, nil
  end

  if type(fetched) == "table" then
    local status = helpers.to_int(vs.getprop(fetched, "status"))
    local headers = vs.getprop(fetched, "headers") or {}

    -- No-body responses (204, 304) and explicit zero content-length
    -- must skip JSON parsing — calling json() on an empty body errors.
    local content_length = nil
    if type(headers) == "table" then
      content_length = headers["content-length"]
    end
    local no_body = status == 204 or status == 304 or tostring(content_length) == "0"

    local json_data = nil
    if not no_body then
      local jf = vs.getprop(fetched, "json")
      if type(jf) == "function" then
        local ok, result = pcall(jf)
        if ok then
          json_data = result
        end
        -- Non-JSON body: json_data stays nil, status/headers preserved.
      end
    end

    return {
      ok = status >= 200 and status < 300,
      status = status,
      headers = headers,
      data = json_data,
    }, nil
  end

  return {
    ok = false,
    err = ctx:make_error("direct_invalid", "invalid response type"),
  }, nil
end



-- Idiomatic facade: client:Address():list() / client:Address():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Address(data)
  local EntityMod = require("entity.address_entity")
  if data == nil then
    if self._address == nil then
      self._address = EntityMod.new(self, nil)
    end
    return self._address
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:BuildingCheck():list() / client:BuildingCheck():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:BuildingCheck(data)
  local EntityMod = require("entity.building_check_entity")
  if data == nil then
    if self._building_check == nil then
      self._building_check = EntityMod.new(self, nil)
    end
    return self._building_check
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Export():list() / client:Export():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Export(data)
  local EntityMod = require("entity.export_entity")
  if data == nil then
    if self._export == nil then
      self._export = EntityMod.new(self, nil)
    end
    return self._export
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:History():list() / client:History():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:History(data)
  local EntityMod = require("entity.history_entity")
  if data == nil then
    if self._history == nil then
      self._history = EntityMod.new(self, nil)
    end
    return self._history
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Location():list() / client:Location():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Location(data)
  local EntityMod = require("entity.location_entity")
  if data == nil then
    if self._location == nil then
      self._location = EntityMod.new(self, nil)
    end
    return self._location
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Marker():list() / client:Marker():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Marker(data)
  local EntityMod = require("entity.marker_entity")
  if data == nil then
    if self._marker == nil then
      self._marker = EntityMod.new(self, nil)
    end
    return self._marker
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Repeat():list() / client:Repeat():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Repeat(data)
  local EntityMod = require("entity.repeat_entity")
  if data == nil then
    if self._repeat == nil then
      self._repeat = EntityMod.new(self, nil)
    end
    return self._repeat
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Search():list() / client:Search():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Search(data)
  local EntityMod = require("entity.search_entity")
  if data == nil then
    if self._search == nil then
      self._search = EntityMod.new(self, nil)
    end
    return self._search
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Share():list() / client:Share():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function LocationSharingSDK:Share(data)
  local EntityMod = require("entity.share_entity")
  if data == nil then
    if self._share == nil then
      self._share = EntityMod.new(self, nil)
    end
    return self._share
  end
  return EntityMod.new(self, data)
end




function LocationSharingSDK.test(testopts, sdkopts)
  sdkopts = sdkopts or {}
  sdkopts = vs.clone(sdkopts)
  if type(sdkopts) ~= "table" then
    sdkopts = {}
  end

  testopts = testopts or {}
  testopts = vs.clone(testopts)
  if type(testopts) ~= "table" then
    testopts = {}
  end
  testopts["active"] = true

  vs.setpath(sdkopts, "feature.test", testopts)

  local sdk = LocationSharingSDK.new(sdkopts)
  sdk.mode = "test"

  return sdk
end


return LocationSharingSDK
