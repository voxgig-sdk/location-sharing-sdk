# LocationSharing SDK feature factory

from feature.base_feature import LocationSharingBaseFeature
from feature.test_feature import LocationSharingTestFeature


def _make_feature(name):
    features = {
        "base": lambda: LocationSharingBaseFeature(),
        "test": lambda: LocationSharingTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
