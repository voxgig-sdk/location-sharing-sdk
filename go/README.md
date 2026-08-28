# LocationSharing Golang SDK



The Golang SDK for the LocationSharing API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Address(nil)` — each with the same small set of operations (`List`, `Load`, `Create`, `Remove`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Also generated from this model: `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb`, `ts` — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/location-sharing-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/location-sharing-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/location-sharing-sdk/go=../location-sharing-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    sdk "github.com/voxgig-sdk/location-sharing-sdk/go"
)

func main() {
    client := sdk.New()

    // Load a single address — the value is the loaded record.
    address, err := client.Address(nil).Load(map[string]any{"lat": 1, "lon": 1}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(address)
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
location, err := client.Location(nil).Load(nil, nil)
if err != nil {
    // handle err
    return
}
_ = location
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

location, err := client.Location(nil).Load(
    nil, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(location) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewLocationSharingSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
    },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
LOCATION_SHARING_TEST_LIVE=TRUE
```

Then run:

```bash
cd go && go test ./test/...
```


## Reference

### NewLocationSharingSDK

```go
func NewLocationSharingSDK(options map[string]any) *LocationSharingSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *LocationSharingSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### LocationSharingSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Address` | `(data map[string]any) LocationSharingEntity` | Create an Address entity instance. |
| `BuildingCheck` | `(data map[string]any) LocationSharingEntity` | Create a BuildingCheck entity instance. |
| `Export` | `(data map[string]any) LocationSharingEntity` | Create an Export entity instance. |
| `History` | `(data map[string]any) LocationSharingEntity` | Create a History entity instance. |
| `Location` | `(data map[string]any) LocationSharingEntity` | Create a Location entity instance. |
| `Marker` | `(data map[string]any) LocationSharingEntity` | Create a Marker entity instance. |
| `Repeat` | `(data map[string]any) LocationSharingEntity` | Create a Repeat entity instance. |
| `Search` | `(data map[string]any) LocationSharingEntity` | Create a Search entity instance. |
| `Share` | `(data map[string]any) LocationSharingEntity` | Create a Share entity instance. |

### Entity interface (LocationSharingEntity)

All entities implement the `LocationSharingEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` / `Remove` | the entity record (`map[string]any`) |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    address, err := client.Address(nil).Load(nil, nil)
    if err != nil { /* handle */ }
    // address is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Address

| Field | Description |
| --- | --- |
| `"address"` | Full formatted address |
| `"city"` | City name |
| `"country"` | Country name |
| `"postalCode"` | Postal or ZIP code |
| `"state"` | State or province |
| `"street"` | Street name |

Operations: Load.

API path: `/geocode/reverse`

#### BuildingCheck

| Field | Description |
| --- | --- |
| `"distance"` | Distance to building edge in meters |
| `"highlighted"` |  |
| `"id"` |  |
| `"name"` |  |

Operations: List.

API path: `/buildings/check`

#### Export

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/export/csv`

#### History

| Field | Description |
| --- | --- |
| `"accuracy"` |  |
| `"address"` |  |
| `"id"` |  |
| `"latitude"` |  |
| `"longitude"` |  |
| `"name"` |  |
| `"timestamp"` |  |

Operations: Create, List, Remove.

API path: `/history`

#### Location

| Field | Description |
| --- | --- |
| `"accuracy"` | Accuracy in meters |
| `"address"` | Human-readable address |
| `"latitude"` | Latitude coordinate |
| `"longitude"` | Longitude coordinate |
| `"timestamp"` | Timestamp of the location fix |

Operations: Load.

API path: `/location`

#### Marker

| Field | Description |
| --- | --- |
| `"address"` |  |
| `"createdAt"` |  |
| `"id"` | Unique marker identifier |
| `"latitude"` |  |
| `"longitude"` |  |
| `"name"` | Name or label for the marker |

Operations: Create, List, Remove.

API path: `/markers`

#### Repeat

| Field | Description |
| --- | --- |
| `"accuracy"` |  |
| `"bestAccuracy"` | Best (lowest) accuracy value from all measurements |
| `"count"` | Number of measurements to take (recommended 8-15) |
| `"interval"` | Interval between measurements in seconds (recommended 0.8-2.0) |
| `"latitude"` |  |
| `"longitude"` |  |
| `"measurements"` |  |
| `"resultType"` | Type of result to return |

Operations: Create.

API path: `/measurement/repeat`

#### Search

| Field | Description |
| --- | --- |
| `"address"` | Full address |
| `"latitude"` |  |
| `"longitude"` |  |
| `"name"` | Name of the location |
| `"type"` | Type of location (e.g., building, park, street) |

Operations: List.

API path: `/search`

#### Share

| Field | Description |
| --- | --- |
| `"address"` | Address of the location |
| `"expiresAt"` | Expiration time of the share link |
| `"latitude"` |  |
| `"longitude"` |  |
| `"name"` | Optional name for the location |
| `"qrCode"` | URL to QR code image |
| `"shareLink"` | Shareable URL for the location |

Operations: Create.

API path: `/share`



## Entities


### Address

Create an instance: `address := client.Address(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Full formatted address |
| `city` | `string` | City name |
| `country` | `string` | Country name |
| `postalCode` | `string` | Postal or ZIP code |
| `state` | `string` | State or province |
| `street` | `string` | Street name |

#### Example: Load

```go
address, err := client.Address(nil).Load(map[string]any{"lat": 1, "lon": 1}, nil)
if err != nil {
    panic(err)
}
fmt.Println(address) // the loaded record
```


### BuildingCheck

Create an instance: `buildingCheck := client.BuildingCheck(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `distance` | `float64` | Distance to building edge in meters |
| `highlighted` | `bool` |  |
| `id` | `string` |  |
| `name` | `string` |  |

#### Example: List

```go
buildingChecks, err := client.BuildingCheck(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(buildingChecks) // the array of records
```


### Export

Create an instance: `export := client.Export(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
export, err := client.Export(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(export) // the loaded record
```


### History

Create an instance: `history := client.History(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `float64` |  |
| `address` | `string` |  |
| `id` | `string` |  |
| `latitude` | `float64` |  |
| `longitude` | `float64` |  |
| `name` | `string` |  |
| `timestamp` | `string` |  |

#### Example: List

```go
historys, err := client.History(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(historys) // the array of records
```

#### Example: Create

```go
result, err := client.History(nil).Create(map[string]any{
    "id": "example_id",
    "latitude": 1,
    "longitude": 1,
    "timestamp": "example_timestamp",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Location

Create an instance: `location := client.Location(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `float64` | Accuracy in meters |
| `address` | `string` | Human-readable address |
| `latitude` | `float64` | Latitude coordinate |
| `longitude` | `float64` | Longitude coordinate |
| `timestamp` | `string` | Timestamp of the location fix |

#### Example: Load

```go
location, err := client.Location(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(location) // the loaded record
```


### Marker

Create an instance: `marker := client.Marker(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` |  |
| `createdAt` | `string` |  |
| `id` | `string` | Unique marker identifier |
| `latitude` | `float64` |  |
| `longitude` | `float64` |  |
| `name` | `string` | Name or label for the marker |

#### Example: List

```go
markers, err := client.Marker(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(markers) // the array of records
```

#### Example: Create

```go
result, err := client.Marker(nil).Create(map[string]any{
    "id": "example_id",
    "latitude": 1,
    "longitude": 1,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Repeat

Create an instance: `repeat := client.Repeat(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `float64` |  |
| `bestAccuracy` | `float64` | Best (lowest) accuracy value from all measurements |
| `count` | `int` | Number of measurements to take (recommended 8-15) |
| `interval` | `float64` | Interval between measurements in seconds (recommended 0.8-2.0) |
| `latitude` | `float64` |  |
| `longitude` | `float64` |  |
| `measurements` | `[]any` |  |
| `resultType` | `string` | Type of result to return |

#### Example: Create

```go
result, err := client.Repeat(nil).Create(map[string]any{
    "count": 1,
    "interval": 1,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Search

Create an instance: `search := client.Search(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Full address |
| `latitude` | `float64` |  |
| `longitude` | `float64` |  |
| `name` | `string` | Name of the location |
| `type` | `string` | Type of location (e.g., building, park, street) |

#### Example: List

```go
searchs, err := client.Search(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(searchs) // the array of records
```


### Share

Create an instance: `share := client.Share(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Address of the location |
| `expiresAt` | `string` | Expiration time of the share link |
| `latitude` | `float64` |  |
| `longitude` | `float64` |  |
| `name` | `string` | Optional name for the location |
| `qrCode` | `string` | URL to QR code image |
| `shareLink` | `string` | Shareable URL for the location |

#### Example: Create

```go
result, err := client.Share(nil).Create(map[string]any{
    "latitude": 1,
    "longitude": 1,
    "shareLink": "example_shareLink",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

## Features

This SDK ships 1 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`test`](#test) | In-memory mock transport for testing without a live server |

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/location-sharing-sdk/go/
├── location-sharing.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/location-sharing-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
location := client.Location(nil)
location.Load(nil, nil)

// location.Data() now returns the location data from the last load
// location.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
