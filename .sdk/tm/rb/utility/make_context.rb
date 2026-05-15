# LocationSharing SDK utility: make_context
require_relative '../core/context'
module LocationSharingUtilities
  MakeContext = ->(ctxmap, basectx) {
    LocationSharingContext.new(ctxmap, basectx)
  }
end
