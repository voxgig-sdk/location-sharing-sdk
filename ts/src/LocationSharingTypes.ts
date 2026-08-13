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
  postalCode?: string
  state?: string
  street?: string
}

export interface AddressLoadMatch {
  address?: string
  city?: string
  country?: string
  postalCode?: string
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

  // Selects a custom action instead of the plain load:
  //   'csv' | 'geojson' | 'kml'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
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
  createdAt?: string
  id: string
  latitude: number
  longitude: number
  name?: string
}

export interface MarkerListMatch {
  address?: string
  createdAt?: string
  id?: string
  latitude?: number
  longitude?: number
  name?: string
}

export interface MarkerCreateData {
  address?: string
  createdAt?: string
  id: string
  latitude: number
  longitude: number
  name?: string
}

export interface MarkerRemoveMatch {
  address?: string
  createdAt?: string
  id: string
  latitude?: number
  longitude?: number
  name?: string
}

export interface Repeat {
  accuracy?: number
  bestAccuracy?: number
  count: number
  interval: number
  latitude?: number
  longitude?: number
  measurements?: any[]
  resultType?: string
}

export interface RepeatCreateData {
  accuracy?: number
  bestAccuracy?: number
  count: number
  interval: number
  latitude?: number
  longitude?: number
  measurements?: any[]
  resultType?: string
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
  expiresAt?: string
  latitude: number
  longitude: number
  name?: string
  qrCode?: string
  shareLink: string
}

export interface ShareCreateData {
  address?: string
  expiresAt?: string
  latitude: number
  longitude: number
  name?: string
  qrCode?: string
  shareLink: string
}

