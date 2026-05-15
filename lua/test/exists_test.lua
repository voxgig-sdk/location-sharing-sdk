-- ProjectName SDK exists test

local sdk = require("location-sharing_sdk")

describe("LocationSharingSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
