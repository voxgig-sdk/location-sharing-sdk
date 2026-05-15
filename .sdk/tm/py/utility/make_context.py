# LocationSharing SDK utility: make_context

from core.context import LocationSharingContext


def make_context_util(ctxmap, basectx):
    return LocationSharingContext(ctxmap, basectx)
