package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewAddressEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewBuildingCheckEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewExportEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewHistoryEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewLocationEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewMarkerEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewRepeatEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewSearchEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

var NewShareEntityFunc func(client *LocationSharingSDK, entopts map[string]any) LocationSharingEntity

