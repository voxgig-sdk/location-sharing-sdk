package = "voxgig-sdk-location-sharing"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/location-sharing-sdk.git"
}
description = {
  summary = "LocationSharing SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["location-sharing_sdk"] = "location-sharing_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
