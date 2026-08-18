-- LocationSharing SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "LocationSharing",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
      },
    },
    options = {
      base = "https://mcinenews.net/LAT",
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["address"] = {},
        ["building_check"] = {},
        ["export"] = {},
        ["history"] = {},
        ["location"] = {},
        ["marker"] = {},
        ["repeat"] = {},
        ["search"] = {},
        ["share"] = {},
      },
    },
    entity = {
      ["address"] = {
        ["fields"] = {
          {
            ["name"] = "address",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "city",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "country",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "postalCode",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "state",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "street",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "address",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["args"] = {
                  ["query"] = {
                    {
                      ["kind"] = "query",
                      ["name"] = "lat",
                      ["orig"] = "lat",
                      ["reqd"] = true,
                      ["type"] = "`$NUMBER`",
                    },
                    {
                      ["kind"] = "query",
                      ["name"] = "lon",
                      ["orig"] = "lon",
                      ["reqd"] = true,
                      ["type"] = "`$NUMBER`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/geocode/reverse",
                ["parts"] = {
                  "geocode",
                  "reverse",
                },
                ["select"] = {
                  ["exist"] = {
                    "lat",
                    "lon",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["building_check"] = {
        ["fields"] = {
          {
            ["name"] = "distance",
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "highlighted",
            ["type"] = "`$BOOLEAN`",
          },
          {
            ["name"] = "id",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "name",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "building_check",
        ["op"] = {
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["args"] = {
                  ["query"] = {
                    {
                      ["kind"] = "query",
                      ["name"] = "lat",
                      ["orig"] = "lat",
                      ["reqd"] = true,
                      ["type"] = "`$NUMBER`",
                    },
                    {
                      ["kind"] = "query",
                      ["name"] = "lon",
                      ["orig"] = "lon",
                      ["reqd"] = true,
                      ["type"] = "`$NUMBER`",
                    },
                    {
                      ["example"] = 40,
                      ["kind"] = "query",
                      ["name"] = "radius",
                      ["orig"] = "radius",
                      ["type"] = "`$INTEGER`",
                    },
                    {
                      ["example"] = 3,
                      ["kind"] = "query",
                      ["name"] = "top",
                      ["orig"] = "top",
                      ["type"] = "`$INTEGER`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/buildings/check",
                ["parts"] = {
                  "buildings",
                  "check",
                },
                ["select"] = {
                  ["exist"] = {
                    "lat",
                    "lon",
                    "radius",
                    "top",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.buildings`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["export"] = {
        ["fields"] = {},
        ["name"] = "export",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/export/csv",
                ["parts"] = {
                  "export",
                  "csv",
                },
                ["select"] = {
                  ["$action"] = "csv",
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/export/geojson",
                ["parts"] = {
                  "export",
                  "geojson",
                },
                ["select"] = {
                  ["$action"] = "geojson",
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/export/kml",
                ["parts"] = {
                  "export",
                  "kml",
                },
                ["select"] = {
                  ["$action"] = "kml",
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["history"] = {
        ["fields"] = {
          {
            ["name"] = "accuracy",
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "address",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "id",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "latitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "longitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "name",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "timestamp",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "history",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/history",
                ["parts"] = {
                  "history",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/history",
                ["parts"] = {
                  "history",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
          ["remove"] = {
            ["input"] = "data",
            ["name"] = "remove",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "DELETE",
                ["orig"] = "/history",
                ["parts"] = {
                  "history",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["location"] = {
        ["fields"] = {
          {
            ["name"] = "accuracy",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "address",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "latitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "longitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "timestamp",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "location",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/location",
                ["parts"] = {
                  "location",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["marker"] = {
        ["fields"] = {
          {
            ["name"] = "address",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "createdAt",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "id",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "latitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "longitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "name",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "marker",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/markers",
                ["parts"] = {
                  "markers",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/markers",
                ["parts"] = {
                  "markers",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
          ["remove"] = {
            ["input"] = "data",
            ["name"] = "remove",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "DELETE",
                ["orig"] = "/markers",
                ["parts"] = {
                  "markers",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["repeat"] = {
        ["fields"] = {
          {
            ["name"] = "accuracy",
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "bestAccuracy",
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "count",
            ["req"] = true,
            ["type"] = "`$INTEGER`",
          },
          {
            ["name"] = "interval",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "latitude",
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "longitude",
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "measurements",
            ["type"] = "`$ARRAY`",
          },
          {
            ["name"] = "resultType",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "repeat",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/measurement/repeat",
                ["parts"] = {
                  "measurement",
                  "repeat",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["search"] = {
        ["fields"] = {
          {
            ["name"] = "address",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "latitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "longitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "name",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "type",
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "search",
        ["op"] = {
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["args"] = {
                  ["query"] = {
                    {
                      ["kind"] = "query",
                      ["name"] = "q",
                      ["orig"] = "q",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/search",
                ["parts"] = {
                  "search",
                },
                ["select"] = {
                  ["exist"] = {
                    "q",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["share"] = {
        ["fields"] = {
          {
            ["name"] = "address",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "expiresAt",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "latitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "longitude",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
          },
          {
            ["name"] = "name",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "qrCode",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "shareLink",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "share",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/share",
                ["parts"] = {
                  "share",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
