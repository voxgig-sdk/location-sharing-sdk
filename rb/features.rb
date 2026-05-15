# LocationSharing SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module LocationSharingFeatures
  def self.make_feature(name)
    case name
    when "base"
      LocationSharingBaseFeature.new
    when "test"
      LocationSharingTestFeature.new
    else
      LocationSharingBaseFeature.new
    end
  end
end
