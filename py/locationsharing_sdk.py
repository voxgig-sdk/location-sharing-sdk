# LocationSharing SDK

from utility.voxgig_struct import voxgig_struct as vs
from core.utility_type import LocationSharingUtility
from core.spec import LocationSharingSpec
from core import helpers

# Load utility registration (populates Utility._registrar)
from utility import register

# Load features
from feature.base_feature import LocationSharingBaseFeature
from features import _make_feature


class LocationSharingSDK:

    def __init__(self, options=None):
        self.mode = "live"
        self.features = []
        self.options = None

        utility = LocationSharingUtility()
        self._utility = utility

        from config import make_config
        config = make_config()

        self._rootctx = utility.make_context({
            "client": self,
            "utility": utility,
            "config": config,
            "options": options if options is not None else {},
            "shared": {},
        }, None)

        self.options = utility.make_options(self._rootctx)

        if vs.getpath(self.options, "feature.test.active") is True:
            self.mode = "test"

        self._rootctx.options = self.options

        # Add features from config.
        feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
        if feature_opts is not None:
            feature_items = vs.items(feature_opts)
            if feature_items is not None:
                for item in feature_items:
                    fname = item[0]
                    fopts = helpers.to_map(item[1])
                    if fopts is not None and fopts.get("active") is True:
                        utility.feature_add(self._rootctx, _make_feature(fname))

        # Add extension features.
        extend = vs.getprop(self.options, "extend")
        if isinstance(extend, list):
            for f in extend:
                if isinstance(f, dict) or (hasattr(f, "get_name") and callable(f.get_name)):
                    utility.feature_add(self._rootctx, f)

        # Initialize features.
        for f in self.features:
            utility.feature_init(self._rootctx, f)

        utility.feature_hook(self._rootctx, "PostConstruct")

        # #BuildFeatures

    def options_map(self):
        out = vs.clone(self.options)
        if isinstance(out, dict):
            return out
        return {}

    def get_utility(self):
        return LocationSharingUtility.copy(self._utility)

    def get_root_ctx(self):
        return self._rootctx

    def prepare(self, fetchargs=None):
        utility = self._utility

        if fetchargs is None:
            fetchargs = {}

        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "prepare",
            "ctrl": ctrl,
        }, self._rootctx)

        options = self.options

        path = vs.getprop(fetchargs, "path") or ""
        if not isinstance(path, str):
            path = ""

        method = vs.getprop(fetchargs, "method") or "GET"
        if not isinstance(method, str):
            method = "GET"

        params = helpers.to_map(vs.getprop(fetchargs, "params"))
        if params is None:
            params = {}
        query = helpers.to_map(vs.getprop(fetchargs, "query"))
        if query is None:
            query = {}

        headers = utility.prepare_headers(ctx)

        base = vs.getprop(options, "base") or ""
        if not isinstance(base, str):
            base = ""
        prefix = vs.getprop(options, "prefix") or ""
        if not isinstance(prefix, str):
            prefix = ""
        suffix = vs.getprop(options, "suffix") or ""
        if not isinstance(suffix, str):
            suffix = ""

        ctx.spec = LocationSharingSpec({
            "base": base,
            "prefix": prefix,
            "suffix": suffix,
            "path": path,
            "method": method,
            "params": params,
            "query": query,
            "headers": headers,
            "body": vs.getprop(fetchargs, "body"),
            "step": "start",
        })

        # Merge user-provided headers.
        uh = vs.getprop(fetchargs, "headers")
        if isinstance(uh, dict):
            for k, v in uh.items():
                ctx.spec.headers[k] = v

        _, err = utility.prepare_auth(ctx)
        if err is not None:
            raise err

        fetchdef, err = utility.make_fetch_def(ctx)
        if err is not None:
            raise err

        return fetchdef

    def direct(self, fetchargs=None):
        utility = self._utility

        try:
            fetchdef = self.prepare(fetchargs)
        except Exception as err:
            # direct() is the raw-HTTP escape hatch: it never raises, it
            # returns a result object callers branch on via result["ok"].
            return {"ok": False, "err": err}

        if fetchargs is None:
            fetchargs = {}
        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "direct",
            "ctrl": ctrl,
        }, self._rootctx)

        url = fetchdef.get("url", "")
        fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

        if fetch_err is not None:
            return {"ok": False, "err": fetch_err}

        if fetched is None:
            return {
                "ok": False,
                "err": ctx.make_error("direct_no_response", "response: undefined"),
            }

        if isinstance(fetched, dict):
            status = helpers.to_int(vs.getprop(fetched, "status"))
            headers = vs.getprop(fetched, "headers") or {}

            # No-body responses (204, 304) and explicit zero content-length
            # must skip JSON parsing — calling json() on an empty body raises.
            content_length = None
            if isinstance(headers, dict):
                content_length = headers.get("content-length")
            no_body = status in (204, 304) or str(content_length) == "0"

            json_data = None
            if not no_body:
                jf = vs.getprop(fetched, "json")
                if callable(jf):
                    try:
                        json_data = jf()
                    except Exception:
                        # Non-JSON body (e.g. text/plain, text/html). Surface
                        # status + headers but leave data as None.
                        json_data = None

            return {
                "ok": status >= 200 and status < 300,
                "status": status,
                "headers": headers,
                "data": json_data,
            }

        return {
            "ok": False,
            "err": ctx.make_error("direct_invalid", "invalid response type"),
        }


    @property
    def address(self):
        """Idiomatic facade: client.address.list() / client.address.load({"id": ...})."""
        from entity.address_entity import AddressEntity
        cached = getattr(self, "_address", None)
        if cached is None:
            cached = AddressEntity(self, None)
            self._address = cached
        return cached

    def Address(self, data=None):
        # Deprecated: use client.address instead.
        from entity.address_entity import AddressEntity
        return AddressEntity(self, data)


    @property
    def building_check(self):
        """Idiomatic facade: client.building_check.list() / client.building_check.load({"id": ...})."""
        from entity.building_check_entity import BuildingCheckEntity
        cached = getattr(self, "_building_check", None)
        if cached is None:
            cached = BuildingCheckEntity(self, None)
            self._building_check = cached
        return cached

    def BuildingCheck(self, data=None):
        # Deprecated: use client.building_check instead.
        from entity.building_check_entity import BuildingCheckEntity
        return BuildingCheckEntity(self, data)


    @property
    def export(self):
        """Idiomatic facade: client.export.list() / client.export.load({"id": ...})."""
        from entity.export_entity import ExportEntity
        cached = getattr(self, "_export", None)
        if cached is None:
            cached = ExportEntity(self, None)
            self._export = cached
        return cached

    def Export(self, data=None):
        # Deprecated: use client.export instead.
        from entity.export_entity import ExportEntity
        return ExportEntity(self, data)


    @property
    def history(self):
        """Idiomatic facade: client.history.list() / client.history.load({"id": ...})."""
        from entity.history_entity import HistoryEntity
        cached = getattr(self, "_history", None)
        if cached is None:
            cached = HistoryEntity(self, None)
            self._history = cached
        return cached

    def History(self, data=None):
        # Deprecated: use client.history instead.
        from entity.history_entity import HistoryEntity
        return HistoryEntity(self, data)


    @property
    def location(self):
        """Idiomatic facade: client.location.list() / client.location.load({"id": ...})."""
        from entity.location_entity import LocationEntity
        cached = getattr(self, "_location", None)
        if cached is None:
            cached = LocationEntity(self, None)
            self._location = cached
        return cached

    def Location(self, data=None):
        # Deprecated: use client.location instead.
        from entity.location_entity import LocationEntity
        return LocationEntity(self, data)


    @property
    def marker(self):
        """Idiomatic facade: client.marker.list() / client.marker.load({"id": ...})."""
        from entity.marker_entity import MarkerEntity
        cached = getattr(self, "_marker", None)
        if cached is None:
            cached = MarkerEntity(self, None)
            self._marker = cached
        return cached

    def Marker(self, data=None):
        # Deprecated: use client.marker instead.
        from entity.marker_entity import MarkerEntity
        return MarkerEntity(self, data)


    @property
    def repeat(self):
        """Idiomatic facade: client.repeat.list() / client.repeat.load({"id": ...})."""
        from entity.repeat_entity import RepeatEntity
        cached = getattr(self, "_repeat", None)
        if cached is None:
            cached = RepeatEntity(self, None)
            self._repeat = cached
        return cached

    def Repeat(self, data=None):
        # Deprecated: use client.repeat instead.
        from entity.repeat_entity import RepeatEntity
        return RepeatEntity(self, data)


    @property
    def search(self):
        """Idiomatic facade: client.search.list() / client.search.load({"id": ...})."""
        from entity.search_entity import SearchEntity
        cached = getattr(self, "_search", None)
        if cached is None:
            cached = SearchEntity(self, None)
            self._search = cached
        return cached

    def Search(self, data=None):
        # Deprecated: use client.search instead.
        from entity.search_entity import SearchEntity
        return SearchEntity(self, data)


    @property
    def share(self):
        """Idiomatic facade: client.share.list() / client.share.load({"id": ...})."""
        from entity.share_entity import ShareEntity
        cached = getattr(self, "_share", None)
        if cached is None:
            cached = ShareEntity(self, None)
            self._share = cached
        return cached

    def Share(self, data=None):
        # Deprecated: use client.share instead.
        from entity.share_entity import ShareEntity
        return ShareEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None):
        if sdkopts is None:
            sdkopts = {}
        sdkopts = vs.clone(sdkopts)
        if not isinstance(sdkopts, dict):
            sdkopts = {}

        if testopts is None:
            testopts = {}
        testopts = vs.clone(testopts)
        if not isinstance(testopts, dict):
            testopts = {}
        testopts["active"] = True

        vs.setpath(sdkopts, "feature.test", testopts)

        sdk = cls(sdkopts)
        sdk.mode = "test"

        return sdk
