package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "LocationSharing",
			"slug": "location-sharing",
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "base",
			},
		},
		"options": map[string]any{
			"base": "https://mcinenews.net/LAT",
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"address": map[string]any{},
				"building_check": map[string]any{},
				"export": map[string]any{},
				"history": map[string]any{},
				"location": map[string]any{},
				"marker": map[string]any{},
				"repeat": map[string]any{},
				"search": map[string]any{},
				"share": map[string]any{},
			},
		},
		"entity": map[string]any{
			"address": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "address",
						"req": true,
						"short": "Full formatted address",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "city",
						"short": "City name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "country",
						"short": "Country name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "postalCode",
						"short": "Postal or ZIP code",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "state",
						"short": "State or province",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "street",
						"short": "Street name",
						"type": "`$STRING`",
					},
				},
				"name": "address",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "lat",
											"orig": "lat",
											"reqd": true,
											"type": "`$NUMBER`",
										},
										map[string]any{
											"kind": "query",
											"name": "lon",
											"orig": "lon",
											"reqd": true,
											"type": "`$NUMBER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/geocode/reverse",
								"segments": []any{
									map[string]any{
										"lit": "geocode",
									},
									map[string]any{
										"lit": "reverse",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"lat",
										"lon",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"geocode",
									"reverse",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"building_check": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "float",
						"name": "distance",
						"short": "Distance to building edge in meters",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "highlighted",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "building_check",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "lat",
											"orig": "lat",
											"reqd": true,
											"type": "`$NUMBER`",
										},
										map[string]any{
											"kind": "query",
											"name": "lon",
											"orig": "lon",
											"reqd": true,
											"type": "`$NUMBER`",
										},
										map[string]any{
											"example": 40,
											"kind": "query",
											"name": "radius",
											"orig": "radius",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 3,
											"kind": "query",
											"name": "top",
											"orig": "top",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/buildings/check",
								"segments": []any{
									map[string]any{
										"lit": "buildings",
									},
									map[string]any{
										"lit": "check",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"lat",
										"lon",
										"radius",
										"top",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.buildings`",
								},
								"parts": []any{
									"buildings",
									"check",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"export": map[string]any{
				"fields": []any{},
				"name": "export",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/export/csv",
								"segments": []any{
									map[string]any{
										"lit": "export",
									},
									map[string]any{
										"lit": "csv",
									},
								},
								"select": map[string]any{
									"$action": "csv",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"export",
									"csv",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/export/geojson",
								"segments": []any{
									map[string]any{
										"lit": "export",
									},
									map[string]any{
										"lit": "geojson",
									},
								},
								"select": map[string]any{
									"$action": "geojson",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"export",
									"geojson",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/export/kml",
								"segments": []any{
									map[string]any{
										"lit": "export",
									},
									map[string]any{
										"lit": "kml",
									},
								},
								"select": map[string]any{
									"$action": "kml",
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"export",
									"kml",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"history": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "float",
						"name": "accuracy",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "address",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "double",
						"name": "latitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "longitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "name",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date-time",
						"name": "timestamp",
						"req": true,
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "history",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/history",
								"segments": []any{
									map[string]any{
										"lit": "history",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"history",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/history",
								"segments": []any{
									map[string]any{
										"lit": "history",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"history",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "DELETE",
								"orig": "/history",
								"segments": []any{
									map[string]any{
										"lit": "history",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"history",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"location": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "float",
						"name": "accuracy",
						"req": true,
						"short": "Accuracy in meters",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "address",
						"short": "Human-readable address",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "double",
						"name": "latitude",
						"req": true,
						"short": "Latitude coordinate",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "longitude",
						"req": true,
						"short": "Longitude coordinate",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "date-time",
						"name": "timestamp",
						"short": "Timestamp of the location fix",
						"type": "`$STRING`",
					},
				},
				"name": "location",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/location",
								"segments": []any{
									map[string]any{
										"lit": "location",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"location",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"marker": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "address",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date-time",
						"name": "createdAt",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"req": true,
						"short": "Unique marker identifier",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "double",
						"name": "latitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "longitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "name",
						"short": "Name or label for the marker",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "marker",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/markers",
								"segments": []any{
									map[string]any{
										"lit": "markers",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"markers",
								},
							},
						},
					},
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/markers",
								"segments": []any{
									map[string]any{
										"lit": "markers",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"markers",
								},
							},
						},
					},
					"remove": map[string]any{
						"input": "data",
						"name": "remove",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "DELETE",
								"orig": "/markers",
								"segments": []any{
									map[string]any{
										"lit": "markers",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"markers",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"repeat": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "float",
						"name": "accuracy",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "float",
						"name": "bestAccuracy",
						"short": "Best (lowest) accuracy value from all measurements",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "count",
						"req": true,
						"short": "Number of measurements to take (recommended 8-15)",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"format": "float",
						"name": "interval",
						"req": true,
						"short": "Interval between measurements in seconds (recommended 0.8-2.0)",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "latitude",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "longitude",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "measurements",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "resultType",
						"op": map[string]any{
							"create": map[string]any{
								"req": true,
								"type": "`$STRING`",
							},
						},
						"short": "Type of result to return",
						"type": "`$STRING`",
					},
				},
				"name": "repeat",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/measurement/repeat",
								"segments": []any{
									map[string]any{
										"lit": "measurement",
									},
									map[string]any{
										"lit": "repeat",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"measurement",
									"repeat",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"search": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "address",
						"short": "Full address",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "double",
						"name": "latitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "longitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "name",
						"req": true,
						"short": "Name of the location",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Type of location (e.g., building, park, street)",
						"type": "`$STRING`",
					},
				},
				"name": "search",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "q",
											"orig": "q",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/search",
								"segments": []any{
									map[string]any{
										"lit": "search",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"q",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"search",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"share": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "address",
						"short": "Address of the location",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date-time",
						"name": "expiresAt",
						"short": "Expiration time of the share link",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "double",
						"name": "latitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"format": "double",
						"name": "longitude",
						"req": true,
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "name",
						"short": "Optional name for the location",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uri",
						"name": "qrCode",
						"short": "URL to QR code image",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uri",
						"name": "shareLink",
						"req": true,
						"short": "Shareable URL for the location",
						"type": "`$STRING`",
					},
				},
				"name": "share",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/share",
								"segments": []any{
									map[string]any{
										"lit": "share",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"share",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
