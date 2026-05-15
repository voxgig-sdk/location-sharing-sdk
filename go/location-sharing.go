package voxgiglocationsharingsdk

import (
	"github.com/voxgig-sdk/location-sharing-sdk/core"
	"github.com/voxgig-sdk/location-sharing-sdk/entity"
	"github.com/voxgig-sdk/location-sharing-sdk/feature"
	_ "github.com/voxgig-sdk/location-sharing-sdk/utility"
)

// Type aliases preserve external API.
type LocationSharingSDK = core.LocationSharingSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type LocationSharingEntity = core.LocationSharingEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type LocationSharingError = core.LocationSharingError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewAddressEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewAddressEntity(client, entopts)
	}
	core.NewBuildingCheckEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewBuildingCheckEntity(client, entopts)
	}
	core.NewExportEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewExportEntity(client, entopts)
	}
	core.NewHistoryEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewHistoryEntity(client, entopts)
	}
	core.NewLocationEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewLocationEntity(client, entopts)
	}
	core.NewMarkerEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewMarkerEntity(client, entopts)
	}
	core.NewRepeatEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewRepeatEntity(client, entopts)
	}
	core.NewSearchEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewSearchEntity(client, entopts)
	}
	core.NewShareEntityFunc = func(client *core.LocationSharingSDK, entopts map[string]any) core.LocationSharingEntity {
		return entity.NewShareEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewLocationSharingSDK = core.NewLocationSharingSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
