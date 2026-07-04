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


    def Address(self, data=None) -> "AddressEntity":
        """Entity factory: client.Address().list({}) / client.Address().load({"id": ...})."""
        from entity.address_entity import AddressEntity
        return AddressEntity(self, data)


    def BuildingCheck(self, data=None) -> "BuildingCheckEntity":
        """Entity factory: client.BuildingCheck().list({}) / client.BuildingCheck().load({"id": ...})."""
        from entity.building_check_entity import BuildingCheckEntity
        return BuildingCheckEntity(self, data)


    def Export(self, data=None) -> "ExportEntity":
        """Entity factory: client.Export().list({}) / client.Export().load({"id": ...})."""
        from entity.export_entity import ExportEntity
        return ExportEntity(self, data)


    def History(self, data=None) -> "HistoryEntity":
        """Entity factory: client.History().list({}) / client.History().load({"id": ...})."""
        from entity.history_entity import HistoryEntity
        return HistoryEntity(self, data)


    def Location(self, data=None) -> "LocationEntity":
        """Entity factory: client.Location().list({}) / client.Location().load({"id": ...})."""
        from entity.location_entity import LocationEntity
        return LocationEntity(self, data)


    def Marker(self, data=None) -> "MarkerEntity":
        """Entity factory: client.Marker().list({}) / client.Marker().load({"id": ...})."""
        from entity.marker_entity import MarkerEntity
        return MarkerEntity(self, data)


    def Repeat(self, data=None) -> "RepeatEntity":
        """Entity factory: client.Repeat().list({}) / client.Repeat().load({"id": ...})."""
        from entity.repeat_entity import RepeatEntity
        return RepeatEntity(self, data)


    def Search(self, data=None) -> "SearchEntity":
        """Entity factory: client.Search().list({}) / client.Search().load({"id": ...})."""
        from entity.search_entity import SearchEntity
        return SearchEntity(self, data)


    def Share(self, data=None) -> "ShareEntity":
        """Entity factory: client.Share().list({}) / client.Share().load({"id": ...})."""
        from entity.share_entity import ShareEntity
        return ShareEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None) -> "LocationSharingSDK":
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


from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from entity.address_entity import AddressEntity
    from entity.building_check_entity import BuildingCheckEntity
    from entity.export_entity import ExportEntity
    from entity.history_entity import HistoryEntity
    from entity.location_entity import LocationEntity
    from entity.marker_entity import MarkerEntity
    from entity.repeat_entity import RepeatEntity
    from entity.search_entity import SearchEntity
    from entity.share_entity import ShareEntity
