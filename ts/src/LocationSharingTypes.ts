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

export interface AddressLoadMatch {
  address?: string
  city?: string
  country?: string
  postal_code?: string
  state?: string
  street?: string
}

export interface BuildingCheck {
  distance?: number
  highlighted?: boolean
  id?: string
  name?: string
}

export interface BuildingCheckListMatch {
  distance?: number
  highlighted?: boolean
  id?: string
  name?: string
}

export interface Export {
}

export interface ExportLoadMatch {
}

export interface History {
  accuracy?: number
  address?: string
  id: string
  latitude: number
  longitude: number
  name?: string
  timestamp: string
}

export interface HistoryListMatch {
  accuracy?: number
  address?: string
  id?: string
  latitude?: number
  longitude?: number
  name?: string
  timestamp?: string
}

export interface HistoryCreateData {
  accuracy?: number
  address?: string
  id: string
  latitude: number
  longitude: number
  name?: string
  timestamp: string
}

export interface HistoryRemoveMatch {
  accuracy?: number
  address?: string
  id: string
  latitude?: number
  longitude?: number
  name?: string
  timestamp?: string
}

export interface Location {
  accuracy: number
  address?: string
  latitude: number
  longitude: number
  timestamp?: string
}

export interface LocationLoadMatch {
  accuracy?: number
  address?: string
  latitude?: number
  longitude?: number
  timestamp?: string
}

export interface Marker {
  address?: string
  created_at?: string
  id: string
  latitude: number
  longitude: number
  name?: string
}

export interface MarkerListMatch {
  address?: string
  created_at?: string
  id?: string
  latitude?: number
  longitude?: number
  name?: string
}

export interface MarkerCreateData {
  address?: string
  created_at?: string
  id: string
  latitude: number
  longitude: number
  name?: string
}

export interface MarkerRemoveMatch {
  address?: string
  created_at?: string
  id: string
  latitude?: number
  longitude?: number
  name?: string
}

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

export interface RepeatCreateData {
  accuracy?: number
  best_accuracy?: number
  count: number
  interval: number
  latitude?: number
  longitude?: number
  measurement?: any[]
  result_type?: string
}

export interface Search {
  address?: string
  latitude: number
  longitude: number
  name: string
  type?: string
}

export interface SearchListMatch {
  address?: string
  latitude?: number
  longitude?: number
  name?: string
  type?: string
}

export interface Share {
  address?: string
  expires_at?: string
  latitude: number
  longitude: number
  name?: string
  qr_code?: string
  share_link: string
}

export interface ShareCreateData {
  address?: string
  expires_at?: string
  latitude: number
  longitude: number
  name?: string
  qr_code?: string
  share_link: string
}

