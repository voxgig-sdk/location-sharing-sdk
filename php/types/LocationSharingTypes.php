<?php
declare(strict_types=1);

// Typed models for the LocationSharing SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Address entity data model. */
class Address
{
    public string $address;
    public ?string $city = null;
    public ?string $country = null;
    public ?string $postal_code = null;
    public ?string $state = null;
    public ?string $street = null;
}

/** Match filter for Address#load (any subset of Address fields). */
class AddressLoadMatch
{
    public ?string $address = null;
    public ?string $city = null;
    public ?string $country = null;
    public ?string $postal_code = null;
    public ?string $state = null;
    public ?string $street = null;
}

/** BuildingCheck entity data model. */
class BuildingCheck
{
    public ?float $distance = null;
    public ?bool $highlighted = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Match filter for BuildingCheck#list (any subset of BuildingCheck fields). */
class BuildingCheckListMatch
{
    public ?float $distance = null;
    public ?bool $highlighted = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Export entity data model. */
class Export
{
}

/** Match filter for Export#load (any subset of Export fields). */
class ExportLoadMatch
{
}

/** History entity data model. */
class History
{
    public ?float $accuracy = null;
    public ?string $address = null;
    public string $id;
    public float $latitude;
    public float $longitude;
    public ?string $name = null;
    public string $timestamp;
}

/** Match filter for History#list (any subset of History fields). */
class HistoryListMatch
{
    public ?float $accuracy = null;
    public ?string $address = null;
    public ?string $id = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
    public ?string $timestamp = null;
}

/** Match filter for History#create (any subset of History fields). */
class HistoryCreateData
{
    public ?float $accuracy = null;
    public ?string $address = null;
    public ?string $id = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
    public ?string $timestamp = null;
}

/** Match filter for History#remove (any subset of History fields). */
class HistoryRemoveMatch
{
    public ?float $accuracy = null;
    public ?string $address = null;
    public ?string $id = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
    public ?string $timestamp = null;
}

/** Location entity data model. */
class Location
{
    public float $accuracy;
    public ?string $address = null;
    public float $latitude;
    public float $longitude;
    public ?string $timestamp = null;
}

/** Match filter for Location#load (any subset of Location fields). */
class LocationLoadMatch
{
    public ?float $accuracy = null;
    public ?string $address = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $timestamp = null;
}

/** Marker entity data model. */
class Marker
{
    public ?string $address = null;
    public ?string $created_at = null;
    public string $id;
    public float $latitude;
    public float $longitude;
    public ?string $name = null;
}

/** Match filter for Marker#list (any subset of Marker fields). */
class MarkerListMatch
{
    public ?string $address = null;
    public ?string $created_at = null;
    public ?string $id = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
}

/** Match filter for Marker#create (any subset of Marker fields). */
class MarkerCreateData
{
    public ?string $address = null;
    public ?string $created_at = null;
    public ?string $id = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
}

/** Match filter for Marker#remove (any subset of Marker fields). */
class MarkerRemoveMatch
{
    public ?string $address = null;
    public ?string $created_at = null;
    public ?string $id = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
}

/** Repeat entity data model. */
class Repeat
{
    public ?float $accuracy = null;
    public ?float $best_accuracy = null;
    public int $count;
    public float $interval;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?array $measurement = null;
    public ?string $result_type = null;
}

/** Match filter for Repeat#create (any subset of Repeat fields). */
class RepeatCreateData
{
    public ?float $accuracy = null;
    public ?float $best_accuracy = null;
    public ?int $count = null;
    public ?float $interval = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?array $measurement = null;
    public ?string $result_type = null;
}

/** Search entity data model. */
class Search
{
    public ?string $address = null;
    public float $latitude;
    public float $longitude;
    public string $name;
    public ?string $type = null;
}

/** Match filter for Search#list (any subset of Search fields). */
class SearchListMatch
{
    public ?string $address = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Share entity data model. */
class Share
{
    public ?string $address = null;
    public ?string $expires_at = null;
    public float $latitude;
    public float $longitude;
    public ?string $name = null;
    public ?string $qr_code = null;
    public string $share_link;
}

/** Match filter for Share#create (any subset of Share fields). */
class ShareCreateData
{
    public ?string $address = null;
    public ?string $expires_at = null;
    public ?float $latitude = null;
    public ?float $longitude = null;
    public ?string $name = null;
    public ?string $qr_code = null;
    public ?string $share_link = null;
}

