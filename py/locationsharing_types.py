# Typed models for the LocationSharing SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Address:
    address: str
    city: Optional[str] = None
    country: Optional[str] = None
    postal_code: Optional[str] = None
    state: Optional[str] = None
    street: Optional[str] = None


@dataclass
class AddressLoadMatch:
    address: Optional[str] = None
    city: Optional[str] = None
    country: Optional[str] = None
    postal_code: Optional[str] = None
    state: Optional[str] = None
    street: Optional[str] = None


@dataclass
class BuildingCheck:
    distance: Optional[float] = None
    highlighted: Optional[bool] = None
    id: Optional[str] = None
    name: Optional[str] = None


@dataclass
class BuildingCheckListMatch:
    distance: Optional[float] = None
    highlighted: Optional[bool] = None
    id: Optional[str] = None
    name: Optional[str] = None


@dataclass
class Export:
    pass


@dataclass
class ExportLoadMatch:
    pass


@dataclass
class History:
    id: str
    latitude: float
    longitude: float
    timestamp: str
    accuracy: Optional[float] = None
    address: Optional[str] = None
    name: Optional[str] = None


@dataclass
class HistoryListMatch:
    accuracy: Optional[float] = None
    address: Optional[str] = None
    id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None
    timestamp: Optional[str] = None


@dataclass
class HistoryCreateData:
    accuracy: Optional[float] = None
    address: Optional[str] = None
    id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None
    timestamp: Optional[str] = None


@dataclass
class HistoryRemoveMatch:
    accuracy: Optional[float] = None
    address: Optional[str] = None
    id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None
    timestamp: Optional[str] = None


@dataclass
class Location:
    accuracy: float
    latitude: float
    longitude: float
    address: Optional[str] = None
    timestamp: Optional[str] = None


@dataclass
class LocationLoadMatch:
    accuracy: Optional[float] = None
    address: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    timestamp: Optional[str] = None


@dataclass
class Marker:
    id: str
    latitude: float
    longitude: float
    address: Optional[str] = None
    created_at: Optional[str] = None
    name: Optional[str] = None


@dataclass
class MarkerListMatch:
    address: Optional[str] = None
    created_at: Optional[str] = None
    id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None


@dataclass
class MarkerCreateData:
    address: Optional[str] = None
    created_at: Optional[str] = None
    id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None


@dataclass
class MarkerRemoveMatch:
    address: Optional[str] = None
    created_at: Optional[str] = None
    id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None


@dataclass
class Repeat:
    count: int
    interval: float
    accuracy: Optional[float] = None
    best_accuracy: Optional[float] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    measurement: Optional[list] = None
    result_type: Optional[str] = None


@dataclass
class RepeatCreateData:
    accuracy: Optional[float] = None
    best_accuracy: Optional[float] = None
    count: Optional[int] = None
    interval: Optional[float] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    measurement: Optional[list] = None
    result_type: Optional[str] = None


@dataclass
class Search:
    latitude: float
    longitude: float
    name: str
    address: Optional[str] = None
    type: Optional[str] = None


@dataclass
class SearchListMatch:
    address: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Share:
    latitude: float
    longitude: float
    share_link: str
    address: Optional[str] = None
    expires_at: Optional[str] = None
    name: Optional[str] = None
    qr_code: Optional[str] = None


@dataclass
class ShareCreateData:
    address: Optional[str] = None
    expires_at: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    name: Optional[str] = None
    qr_code: Optional[str] = None
    share_link: Optional[str] = None

