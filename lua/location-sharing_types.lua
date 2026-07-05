-- Typed models for the LocationSharing SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Address
---@field address string
---@field city? string
---@field country? string
---@field postal_code? string
---@field state? string
---@field street? string

---@class AddressLoadMatch
---@field address? string
---@field city? string
---@field country? string
---@field postal_code? string
---@field state? string
---@field street? string

---@class BuildingCheck
---@field distance? number
---@field highlighted? boolean
---@field id? string
---@field name? string

---@class BuildingCheckListMatch
---@field distance? number
---@field highlighted? boolean
---@field id? string
---@field name? string

---@class Export

---@class ExportLoadMatch

---@class History
---@field accuracy? number
---@field address? string
---@field id string
---@field latitude number
---@field longitude number
---@field name? string
---@field timestamp string

---@class HistoryListMatch
---@field accuracy? number
---@field address? string
---@field id? string
---@field latitude? number
---@field longitude? number
---@field name? string
---@field timestamp? string

---@class HistoryCreateData
---@field accuracy? number
---@field address? string
---@field id string
---@field latitude number
---@field longitude number
---@field name? string
---@field timestamp string

---@class HistoryRemoveMatch
---@field accuracy? number
---@field address? string
---@field id string
---@field latitude? number
---@field longitude? number
---@field name? string
---@field timestamp? string

---@class Location
---@field accuracy number
---@field address? string
---@field latitude number
---@field longitude number
---@field timestamp? string

---@class LocationLoadMatch
---@field accuracy? number
---@field address? string
---@field latitude? number
---@field longitude? number
---@field timestamp? string

---@class Marker
---@field address? string
---@field created_at? string
---@field id string
---@field latitude number
---@field longitude number
---@field name? string

---@class MarkerListMatch
---@field address? string
---@field created_at? string
---@field id? string
---@field latitude? number
---@field longitude? number
---@field name? string

---@class MarkerCreateData
---@field address? string
---@field created_at? string
---@field id string
---@field latitude number
---@field longitude number
---@field name? string

---@class MarkerRemoveMatch
---@field address? string
---@field created_at? string
---@field id string
---@field latitude? number
---@field longitude? number
---@field name? string

---@class Repeat
---@field accuracy? number
---@field best_accuracy? number
---@field count number
---@field interval number
---@field latitude? number
---@field longitude? number
---@field measurement? table
---@field result_type? string

---@class RepeatCreateData
---@field accuracy? number
---@field best_accuracy? number
---@field count number
---@field interval number
---@field latitude? number
---@field longitude? number
---@field measurement? table
---@field result_type? string

---@class Search
---@field address? string
---@field latitude number
---@field longitude number
---@field name string
---@field type? string

---@class SearchListMatch
---@field address? string
---@field latitude? number
---@field longitude? number
---@field name? string
---@field type? string

---@class Share
---@field address? string
---@field expires_at? string
---@field latitude number
---@field longitude number
---@field name? string
---@field qr_code? string
---@field share_link string

---@class ShareCreateData
---@field address? string
---@field expires_at? string
---@field latitude number
---@field longitude number
---@field name? string
---@field qr_code? string
---@field share_link string

local M = {}

return M
