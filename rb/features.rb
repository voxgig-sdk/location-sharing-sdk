# LocationSharing SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module LocationSharingFeatures
  def self.make_feature(name)
    case name
    when "base"
      LocationSharingBaseFeature.new
    when "ratelimit"
      LocationSharingRatelimitFeature.new
    when "retry"
      LocationSharingRetryFeature.new
    when "test"
      LocationSharingTestFeature.new
    when "timeout"
      LocationSharingTimeoutFeature.new
    else
      LocationSharingBaseFeature.new
    end
  end
end
