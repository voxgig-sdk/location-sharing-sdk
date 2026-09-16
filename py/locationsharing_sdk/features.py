# LocationSharing SDK feature factory

from locationsharing_sdk.feature.base_feature import LocationSharingBaseFeature
from locationsharing_sdk.feature.ratelimit_feature import LocationSharingRatelimitFeature
from locationsharing_sdk.feature.retry_feature import LocationSharingRetryFeature
from locationsharing_sdk.feature.test_feature import LocationSharingTestFeature
from locationsharing_sdk.feature.timeout_feature import LocationSharingTimeoutFeature


_FEATURES = {
    "base": lambda: LocationSharingBaseFeature(),
    "ratelimit": lambda: LocationSharingRatelimitFeature(),
    "retry": lambda: LocationSharingRetryFeature(),
    "test": lambda: LocationSharingTestFeature(),
    "timeout": lambda: LocationSharingTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
