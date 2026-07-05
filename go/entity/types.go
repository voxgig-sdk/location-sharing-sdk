// Typed models for the LocationSharing SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Address is the typed data model for the address entity.
type Address struct {
	Address string `json:"address"`
	City *string `json:"city,omitempty"`
	Country *string `json:"country,omitempty"`
	PostalCode *string `json:"postal_code,omitempty"`
	State *string `json:"state,omitempty"`
	Street *string `json:"street,omitempty"`
}

// AddressLoadMatch is the typed request payload for Address.LoadTyped.
type AddressLoadMatch struct {
	Address *string `json:"address,omitempty"`
	City *string `json:"city,omitempty"`
	Country *string `json:"country,omitempty"`
	PostalCode *string `json:"postal_code,omitempty"`
	State *string `json:"state,omitempty"`
	Street *string `json:"street,omitempty"`
}

// BuildingCheck is the typed data model for the building_check entity.
type BuildingCheck struct {
	Distance *float64 `json:"distance,omitempty"`
	Highlighted *bool `json:"highlighted,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// BuildingCheckListMatch is the typed request payload for BuildingCheck.ListTyped.
type BuildingCheckListMatch struct {
	Distance *float64 `json:"distance,omitempty"`
	Highlighted *bool `json:"highlighted,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// Export is the typed data model for the export entity.
type Export struct {
}

// ExportLoadMatch is the typed request payload for Export.LoadTyped.
type ExportLoadMatch struct {
}

// History is the typed data model for the history entity.
type History struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	Address *string `json:"address,omitempty"`
	Id string `json:"id"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name *string `json:"name,omitempty"`
	Timestamp string `json:"timestamp"`
}

// HistoryListMatch is the typed request payload for History.ListTyped.
type HistoryListMatch struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	Address *string `json:"address,omitempty"`
	Id *string `json:"id,omitempty"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Name *string `json:"name,omitempty"`
	Timestamp *string `json:"timestamp,omitempty"`
}

// HistoryCreateData is the typed request payload for History.CreateTyped.
type HistoryCreateData struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	Address *string `json:"address,omitempty"`
	Id string `json:"id"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name *string `json:"name,omitempty"`
	Timestamp string `json:"timestamp"`
}

// HistoryRemoveMatch is the typed request payload for History.RemoveTyped.
type HistoryRemoveMatch struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	Address *string `json:"address,omitempty"`
	Id string `json:"id"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Name *string `json:"name,omitempty"`
	Timestamp *string `json:"timestamp,omitempty"`
}

// Location is the typed data model for the location entity.
type Location struct {
	Accuracy float64 `json:"accuracy"`
	Address *string `json:"address,omitempty"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Timestamp *string `json:"timestamp,omitempty"`
}

// LocationLoadMatch is the typed request payload for Location.LoadTyped.
type LocationLoadMatch struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	Address *string `json:"address,omitempty"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Timestamp *string `json:"timestamp,omitempty"`
}

// Marker is the typed data model for the marker entity.
type Marker struct {
	Address *string `json:"address,omitempty"`
	CreatedAt *string `json:"created_at,omitempty"`
	Id string `json:"id"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name *string `json:"name,omitempty"`
}

// MarkerListMatch is the typed request payload for Marker.ListTyped.
type MarkerListMatch struct {
	Address *string `json:"address,omitempty"`
	CreatedAt *string `json:"created_at,omitempty"`
	Id *string `json:"id,omitempty"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Name *string `json:"name,omitempty"`
}

// MarkerCreateData is the typed request payload for Marker.CreateTyped.
type MarkerCreateData struct {
	Address *string `json:"address,omitempty"`
	CreatedAt *string `json:"created_at,omitempty"`
	Id string `json:"id"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name *string `json:"name,omitempty"`
}

// MarkerRemoveMatch is the typed request payload for Marker.RemoveTyped.
type MarkerRemoveMatch struct {
	Address *string `json:"address,omitempty"`
	CreatedAt *string `json:"created_at,omitempty"`
	Id string `json:"id"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Name *string `json:"name,omitempty"`
}

// Repeat is the typed data model for the repeat entity.
type Repeat struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	BestAccuracy *float64 `json:"best_accuracy,omitempty"`
	Count int `json:"count"`
	Interval float64 `json:"interval"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Measurement *[]any `json:"measurement,omitempty"`
	ResultType *string `json:"result_type,omitempty"`
}

// RepeatCreateData is the typed request payload for Repeat.CreateTyped.
type RepeatCreateData struct {
	Accuracy *float64 `json:"accuracy,omitempty"`
	BestAccuracy *float64 `json:"best_accuracy,omitempty"`
	Count int `json:"count"`
	Interval float64 `json:"interval"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Measurement *[]any `json:"measurement,omitempty"`
	ResultType *string `json:"result_type,omitempty"`
}

// Search is the typed data model for the search entity.
type Search struct {
	Address *string `json:"address,omitempty"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name string `json:"name"`
	Type *string `json:"type,omitempty"`
}

// SearchListMatch is the typed request payload for Search.ListTyped.
type SearchListMatch struct {
	Address *string `json:"address,omitempty"`
	Latitude *float64 `json:"latitude,omitempty"`
	Longitude *float64 `json:"longitude,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Share is the typed data model for the share entity.
type Share struct {
	Address *string `json:"address,omitempty"`
	ExpiresAt *string `json:"expires_at,omitempty"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name *string `json:"name,omitempty"`
	QrCode *string `json:"qr_code,omitempty"`
	ShareLink string `json:"share_link"`
}

// ShareCreateData is the typed request payload for Share.CreateTyped.
type ShareCreateData struct {
	Address *string `json:"address,omitempty"`
	ExpiresAt *string `json:"expires_at,omitempty"`
	Latitude float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Name *string `json:"name,omitempty"`
	QrCode *string `json:"qr_code,omitempty"`
	ShareLink string `json:"share_link"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
