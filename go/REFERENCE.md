# LocationSharing Golang SDK Reference

Complete API reference for the LocationSharing Golang SDK.


## LocationSharingSDK

### Constructor

```go
func NewLocationSharingSDK(options map[string]any) *LocationSharingSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *LocationSharingSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *LocationSharingSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Address(data map[string]any) LocationSharingEntity`

Create a new `Address` entity instance. Pass `nil` for no initial data.

#### `BuildingCheck(data map[string]any) LocationSharingEntity`

Create a new `BuildingCheck` entity instance. Pass `nil` for no initial data.

#### `Export(data map[string]any) LocationSharingEntity`

Create a new `Export` entity instance. Pass `nil` for no initial data.

#### `History(data map[string]any) LocationSharingEntity`

Create a new `History` entity instance. Pass `nil` for no initial data.

#### `Location(data map[string]any) LocationSharingEntity`

Create a new `Location` entity instance. Pass `nil` for no initial data.

#### `Marker(data map[string]any) LocationSharingEntity`

Create a new `Marker` entity instance. Pass `nil` for no initial data.

#### `Repeat(data map[string]any) LocationSharingEntity`

Create a new `Repeat` entity instance. Pass `nil` for no initial data.

#### `Search(data map[string]any) LocationSharingEntity`

Create a new `Search` entity instance. Pass `nil` for no initial data.

#### `Share(data map[string]any) LocationSharingEntity`

Create a new `Share` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## AddressEntity

```go
address := client.Address(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `string` | Yes |  |
| `city` | `string` | No |  |
| `country` | `string` | No |  |
| `postal_code` | `string` | No |  |
| `state` | `string` | No |  |
| `street` | `string` | No |  |

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Address(nil).Load(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `AddressEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## BuildingCheckEntity

```go
building_check := client.BuildingCheck(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `distance` | `float64` | No |  |
| `highlighted` | `bool` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.BuildingCheck(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `BuildingCheckEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ExportEntity

```go
export := client.Export(nil)
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Export(nil).Load(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ExportEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## HistoryEntity

```go
history := client.History(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | `float64` | No |  |
| `address` | `string` | No |  |
| `id` | `string` | Yes |  |
| `latitude` | `float64` | Yes |  |
| `longitude` | `float64` | Yes |  |
| `name` | `string` | No |  |
| `timestamp` | `string` | Yes |  |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.History(nil).Create(map[string]any{
    "latitude": /* float64 */,
    "longitude": /* float64 */,
    "timestamp": /* string */,
}, nil)
```

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.History(nil).List(nil, nil)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.History(nil).Remove(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `HistoryEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## LocationEntity

```go
location := client.Location(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | `float64` | Yes |  |
| `address` | `string` | No |  |
| `latitude` | `float64` | Yes |  |
| `longitude` | `float64` | Yes |  |
| `timestamp` | `string` | No |  |

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Location(nil).Load(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `LocationEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## MarkerEntity

```go
marker := client.Marker(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `string` | No |  |
| `created_at` | `string` | No |  |
| `id` | `string` | Yes |  |
| `latitude` | `float64` | Yes |  |
| `longitude` | `float64` | Yes |  |
| `name` | `string` | No |  |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Marker(nil).Create(map[string]any{
    "latitude": /* float64 */,
    "longitude": /* float64 */,
}, nil)
```

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Marker(nil).List(nil, nil)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.Marker(nil).Remove(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MarkerEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## RepeatEntity

```go
repeat := client.Repeat(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | `float64` | No |  |
| `best_accuracy` | `float64` | No |  |
| `count` | `int` | Yes |  |
| `interval` | `float64` | Yes |  |
| `latitude` | `float64` | No |  |
| `longitude` | `float64` | No |  |
| `measurement` | `[]any` | No |  |
| `result_type` | `string` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `accuracy` | - |
| `best_accuracy` | - |
| `count` | - |
| `interval` | - |
| `latitude` | - |
| `longitude` | - |
| `measurement` | - |
| `result_type` | Yes |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Repeat(nil).Create(map[string]any{
    "count": /* int */,
    "interval": /* float64 */,
}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `RepeatEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## SearchEntity

```go
search := client.Search(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `string` | No |  |
| `latitude` | `float64` | Yes |  |
| `longitude` | `float64` | Yes |  |
| `name` | `string` | Yes |  |
| `type` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Search(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `SearchEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ShareEntity

```go
share := client.Share(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `string` | No |  |
| `expires_at` | `string` | No |  |
| `latitude` | `float64` | Yes |  |
| `longitude` | `float64` | Yes |  |
| `name` | `string` | No |  |
| `qr_code` | `string` | No |  |
| `share_link` | `string` | Yes |  |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Share(nil).Create(map[string]any{
    "latitude": /* float64 */,
    "longitude": /* float64 */,
    "share_link": /* string */,
}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ShareEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewLocationSharingSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

