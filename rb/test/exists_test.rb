# LocationSharing SDK exists test

require "minitest/autorun"
require_relative "../LocationSharing_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = LocationSharingSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
