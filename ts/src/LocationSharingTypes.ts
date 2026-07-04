// Typed models for the LocationSharing SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Address {
  address: string
  city?: string
  country?: string
  postal_code?: string
  state?: string
  street?: string
}

export type AddressLoadMatch = Partial<Address>

export interface BuildingCheck {
  distance?: number
  highlighted?: boolean
  id?: string
  name?: string
}

export type BuildingCheckListMatch = Partial<BuildingCheck>

export interface Export {
}

export type ExportLoadMatch = Partial<Export>

export interface History {
  accuracy?: number
  address?: string
  id: string
  latitude: number
  longitude: number
  name?: string
  timestamp: string
}

export type HistoryListMatch = Partial<History>

export type HistoryCreateData = Partial<History>

export type HistoryRemoveMatch = Partial<History>

export interface Location {
  accuracy: number
  address?: string
  latitude: number
  longitude: number
  timestamp?: string
}

export type LocationLoadMatch = Partial<Location>

export interface Marker {
  address?: string
  created_at?: string
  id: string
  latitude: number
  longitude: number
  name?: string
}

export type MarkerListMatch = Partial<Marker>

export type MarkerCreateData = Partial<Marker>

export type MarkerRemoveMatch = Partial<Marker>

export interface Repeat {
  accuracy?: number
  best_accuracy?: number
  count: number
  interval: number
  latitude?: number
  longitude?: number
  measurement?: any[]
  result_type?: string
}

export type RepeatCreateData = Partial<Repeat>

export interface Search {
  address?: string
  latitude: number
  longitude: number
  name: string
  type?: string
}

export type SearchListMatch = Partial<Search>

export interface Share {
  address?: string
  expires_at?: string
  latitude: number
  longitude: number
  name?: string
  qr_code?: string
  share_link: string
}

export type ShareCreateData = Partial<Share>

