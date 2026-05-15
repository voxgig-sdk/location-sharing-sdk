# LocationSharing SDK utility: feature_add
module LocationSharingUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
