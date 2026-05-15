# ProjectName SDK exists test

import pytest
from locationsharing_sdk import LocationSharingSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = LocationSharingSDK.test(None, None)
        assert testsdk is not None
