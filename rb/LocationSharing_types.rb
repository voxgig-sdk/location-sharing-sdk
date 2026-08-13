# frozen_string_literal: true

# Typed models for the LocationSharing SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Address entity data model.
#
# @!attribute [rw] address
#   @return [String]
#
# @!attribute [rw] city
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] postalCode
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [String, nil]
#
# @!attribute [rw] street
#   @return [String, nil]
Address = Struct.new(
  :address,
  :city,
  :country,
  :postalCode,
  :state,
  :street,
  keyword_init: true
)

# Request payload for Address#load.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] city
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] postalCode
#   @return [String, nil]
#
# @!attribute [rw] state
#   @return [String, nil]
#
# @!attribute [rw] street
#   @return [String, nil]
AddressLoadMatch = Struct.new(
  :address,
  :city,
  :country,
  :postalCode,
  :state,
  :street,
  keyword_init: true
)

# BuildingCheck entity data model.
#
# @!attribute [rw] distance
#   @return [Float, nil]
#
# @!attribute [rw] highlighted
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
BuildingCheck = Struct.new(
  :distance,
  :highlighted,
  :id,
  :name,
  keyword_init: true
)

# Request payload for BuildingCheck#list.
#
# @!attribute [rw] distance
#   @return [Float, nil]
#
# @!attribute [rw] highlighted
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
BuildingCheckListMatch = Struct.new(
  :distance,
  :highlighted,
  :id,
  :name,
  keyword_init: true
)

# Export entity data model.
class Export
end

# Request payload for Export#load.
class ExportLoadMatch
end

# History entity data model.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] timestamp
#   @return [String]
History = Struct.new(
  :accuracy,
  :address,
  :id,
  :latitude,
  :longitude,
  :name,
  :timestamp,
  keyword_init: true
)

# Request payload for History#list.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] timestamp
#   @return [String, nil]
HistoryListMatch = Struct.new(
  :accuracy,
  :address,
  :id,
  :latitude,
  :longitude,
  :name,
  :timestamp,
  keyword_init: true
)

# Request payload for History#create.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] timestamp
#   @return [String]
HistoryCreateData = Struct.new(
  :accuracy,
  :address,
  :id,
  :latitude,
  :longitude,
  :name,
  :timestamp,
  keyword_init: true
)

# Request payload for History#remove.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] timestamp
#   @return [String, nil]
HistoryRemoveMatch = Struct.new(
  :accuracy,
  :address,
  :id,
  :latitude,
  :longitude,
  :name,
  :timestamp,
  keyword_init: true
)

# Location entity data model.
#
# @!attribute [rw] accuracy
#   @return [Float]
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] timestamp
#   @return [String, nil]
Location = Struct.new(
  :accuracy,
  :address,
  :latitude,
  :longitude,
  :timestamp,
  keyword_init: true
)

# Request payload for Location#load.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] timestamp
#   @return [String, nil]
LocationLoadMatch = Struct.new(
  :accuracy,
  :address,
  :latitude,
  :longitude,
  :timestamp,
  keyword_init: true
)

# Marker entity data model.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String, nil]
Marker = Struct.new(
  :address,
  :createdAt,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Request payload for Marker#list.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
MarkerListMatch = Struct.new(
  :address,
  :createdAt,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Request payload for Marker#create.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String, nil]
MarkerCreateData = Struct.new(
  :address,
  :createdAt,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Request payload for Marker#remove.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] createdAt
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
MarkerRemoveMatch = Struct.new(
  :address,
  :createdAt,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Repeat entity data model.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] bestAccuracy
#   @return [Float, nil]
#
# @!attribute [rw] count
#   @return [Integer]
#
# @!attribute [rw] interval
#   @return [Float]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] measurements
#   @return [Array, nil]
#
# @!attribute [rw] resultType
#   @return [String, nil]
Repeat = Struct.new(
  :accuracy,
  :bestAccuracy,
  :count,
  :interval,
  :latitude,
  :longitude,
  :measurements,
  :resultType,
  keyword_init: true
)

# Request payload for Repeat#create.
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] bestAccuracy
#   @return [Float, nil]
#
# @!attribute [rw] count
#   @return [Integer]
#
# @!attribute [rw] interval
#   @return [Float]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] measurements
#   @return [Array, nil]
#
# @!attribute [rw] resultType
#   @return [String, nil]
RepeatCreateData = Struct.new(
  :accuracy,
  :bestAccuracy,
  :count,
  :interval,
  :latitude,
  :longitude,
  :measurements,
  :resultType,
  keyword_init: true
)

# Search entity data model.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] type
#   @return [String, nil]
Search = Struct.new(
  :address,
  :latitude,
  :longitude,
  :name,
  :type,
  keyword_init: true
)

# Request payload for Search#list.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
SearchListMatch = Struct.new(
  :address,
  :latitude,
  :longitude,
  :name,
  :type,
  keyword_init: true
)

# Share entity data model.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] expiresAt
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] qrCode
#   @return [String, nil]
#
# @!attribute [rw] shareLink
#   @return [String]
Share = Struct.new(
  :address,
  :expiresAt,
  :latitude,
  :longitude,
  :name,
  :qrCode,
  :shareLink,
  keyword_init: true
)

# Request payload for Share#create.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] expiresAt
#   @return [String, nil]
#
# @!attribute [rw] latitude
#   @return [Float]
#
# @!attribute [rw] longitude
#   @return [Float]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] qrCode
#   @return [String, nil]
#
# @!attribute [rw] shareLink
#   @return [String]
ShareCreateData = Struct.new(
  :address,
  :expiresAt,
  :latitude,
  :longitude,
  :name,
  :qrCode,
  :shareLink,
  keyword_init: true
)

