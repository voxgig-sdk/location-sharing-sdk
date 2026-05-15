-- LocationSharing SDK error

local LocationSharingError = {}
LocationSharingError.__index = LocationSharingError


function LocationSharingError.new(code, msg, ctx)
  local self = setmetatable({}, LocationSharingError)
  self.is_sdk_error = true
  self.sdk = "LocationSharing"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function LocationSharingError:error()
  return self.msg
end


function LocationSharingError:__tostring()
  return self.msg
end


return LocationSharingError
