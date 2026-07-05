# Typed models for the LocationSharing SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class AddressRequired(TypedDict):
    address: str


class Address(AddressRequired, total=False):
    city: str
    country: str
    postal_code: str
    state: str
    street: str


class AddressLoadMatch(TypedDict, total=False):
    address: str
    city: str
    country: str
    postal_code: str
    state: str
    street: str


class BuildingCheck(TypedDict, total=False):
    distance: float
    highlighted: bool
    id: str
    name: str


class BuildingCheckListMatch(TypedDict, total=False):
    distance: float
    highlighted: bool
    id: str
    name: str


class Export(TypedDict):
    pass


class ExportLoadMatch(TypedDict):
    pass


class HistoryRequired(TypedDict):
    id: str
    latitude: float
    longitude: float
    timestamp: str


class History(HistoryRequired, total=False):
    accuracy: float
    address: str
    name: str


class HistoryListMatch(TypedDict, total=False):
    accuracy: float
    address: str
    id: str
    latitude: float
    longitude: float
    name: str
    timestamp: str


class HistoryCreateDataRequired(TypedDict):
    id: str
    latitude: float
    longitude: float
    timestamp: str


class HistoryCreateData(HistoryCreateDataRequired, total=False):
    accuracy: float
    address: str
    name: str


class HistoryRemoveMatchRequired(TypedDict):
    id: str


class HistoryRemoveMatch(HistoryRemoveMatchRequired, total=False):
    accuracy: float
    address: str
    latitude: float
    longitude: float
    name: str
    timestamp: str


class LocationRequired(TypedDict):
    accuracy: float
    latitude: float
    longitude: float


class Location(LocationRequired, total=False):
    address: str
    timestamp: str


class LocationLoadMatch(TypedDict, total=False):
    accuracy: float
    address: str
    latitude: float
    longitude: float
    timestamp: str


class MarkerRequired(TypedDict):
    id: str
    latitude: float
    longitude: float


class Marker(MarkerRequired, total=False):
    address: str
    created_at: str
    name: str


class MarkerListMatch(TypedDict, total=False):
    address: str
    created_at: str
    id: str
    latitude: float
    longitude: float
    name: str


class MarkerCreateDataRequired(TypedDict):
    id: str
    latitude: float
    longitude: float


class MarkerCreateData(MarkerCreateDataRequired, total=False):
    address: str
    created_at: str
    name: str


class MarkerRemoveMatchRequired(TypedDict):
    id: str


class MarkerRemoveMatch(MarkerRemoveMatchRequired, total=False):
    address: str
    created_at: str
    latitude: float
    longitude: float
    name: str


class RepeatRequired(TypedDict):
    count: int
    interval: float


class Repeat(RepeatRequired, total=False):
    accuracy: float
    best_accuracy: float
    latitude: float
    longitude: float
    measurement: list
    result_type: str


class RepeatCreateDataRequired(TypedDict):
    count: int
    interval: float


class RepeatCreateData(RepeatCreateDataRequired, total=False):
    accuracy: float
    best_accuracy: float
    latitude: float
    longitude: float
    measurement: list
    result_type: str


class SearchRequired(TypedDict):
    latitude: float
    longitude: float
    name: str


class Search(SearchRequired, total=False):
    address: str
    type: str


class SearchListMatch(TypedDict, total=False):
    address: str
    latitude: float
    longitude: float
    name: str
    type: str


class ShareRequired(TypedDict):
    latitude: float
    longitude: float
    share_link: str


class Share(ShareRequired, total=False):
    address: str
    expires_at: str
    name: str
    qr_code: str


class ShareCreateDataRequired(TypedDict):
    latitude: float
    longitude: float
    share_link: str


class ShareCreateData(ShareCreateDataRequired, total=False):
    address: str
    expires_at: str
    name: str
    qr_code: str
