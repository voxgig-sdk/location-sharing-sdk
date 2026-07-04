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
# @!attribute [rw] postal_code
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
  :postal_code,
  :state,
  :street,
  keyword_init: true
)

# Match filter for Address#load (any subset of Address fields).
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
# @!attribute [rw] postal_code
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
  :postal_code,
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

# Match filter for BuildingCheck#list (any subset of BuildingCheck fields).
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

# Match filter for Export#load (any subset of Export fields).
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

# Match filter for History#list (any subset of History fields).
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

# Match filter for History#create (any subset of History fields).
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

# Match filter for History#remove (any subset of History fields).
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

# Match filter for Location#load (any subset of Location fields).
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
# @!attribute [rw] created_at
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
  :created_at,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Match filter for Marker#list (any subset of Marker fields).
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] created_at
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
  :created_at,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Match filter for Marker#create (any subset of Marker fields).
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] created_at
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
MarkerCreateData = Struct.new(
  :address,
  :created_at,
  :id,
  :latitude,
  :longitude,
  :name,
  keyword_init: true
)

# Match filter for Marker#remove (any subset of Marker fields).
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] created_at
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
MarkerRemoveMatch = Struct.new(
  :address,
  :created_at,
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
# @!attribute [rw] best_accuracy
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
# @!attribute [rw] measurement
#   @return [Array, nil]
#
# @!attribute [rw] result_type
#   @return [String, nil]
Repeat = Struct.new(
  :accuracy,
  :best_accuracy,
  :count,
  :interval,
  :latitude,
  :longitude,
  :measurement,
  :result_type,
  keyword_init: true
)

# Match filter for Repeat#create (any subset of Repeat fields).
#
# @!attribute [rw] accuracy
#   @return [Float, nil]
#
# @!attribute [rw] best_accuracy
#   @return [Float, nil]
#
# @!attribute [rw] count
#   @return [Integer, nil]
#
# @!attribute [rw] interval
#   @return [Float, nil]
#
# @!attribute [rw] latitude
#   @return [Float, nil]
#
# @!attribute [rw] longitude
#   @return [Float, nil]
#
# @!attribute [rw] measurement
#   @return [Array, nil]
#
# @!attribute [rw] result_type
#   @return [String, nil]
RepeatCreateData = Struct.new(
  :accuracy,
  :best_accuracy,
  :count,
  :interval,
  :latitude,
  :longitude,
  :measurement,
  :result_type,
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

# Match filter for Search#list (any subset of Search fields).
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
# @!attribute [rw] expires_at
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
# @!attribute [rw] qr_code
#   @return [String, nil]
#
# @!attribute [rw] share_link
#   @return [String]
Share = Struct.new(
  :address,
  :expires_at,
  :latitude,
  :longitude,
  :name,
  :qr_code,
  :share_link,
  keyword_init: true
)

# Match filter for Share#create (any subset of Share fields).
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] expires_at
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
# @!attribute [rw] qr_code
#   @return [String, nil]
#
# @!attribute [rw] share_link
#   @return [String, nil]
ShareCreateData = Struct.new(
  :address,
  :expires_at,
  :latitude,
  :longitude,
  :name,
  :qr_code,
  :share_link,
  keyword_init: true
)

