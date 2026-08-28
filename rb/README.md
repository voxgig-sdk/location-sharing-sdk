# LocationSharing Ruby SDK



The Ruby SDK for the LocationSharing API — an entity-oriented client using idiomatic Ruby conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Address` — with named operations (`list`/`load`/`create`/`remove`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to RubyGems. Install it from the
GitHub release tag (`rb/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/location-sharing-sdk/releases](https://github.com/voxgig-sdk/location-sharing-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ruby
require_relative "LocationSharing_sdk"

client = LocationSharingSDK.new
```

### 3. Load an address

```ruby
begin
  # load returns the ENTITY — call data_get for the Address record (raises on error).
  address = client.Address.load({ "lat" => 1, "lon" => 1 })
  puts address
rescue => err
  warn "load failed: #{err}"
end
```


## Error handling

Entity operations raise on failure, so rescue them:

```ruby
begin
  location = client.Location.load()
rescue => err
  warn "load failed: #{err}"
end
```

`direct` does **not** raise — it returns the result hash. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example_id" },
})

warn "request failed: #{result["err"] || "HTTP #{result["status"]}"}" unless result["ok"]
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})

if result["ok"]
  puts result["status"]  # 200
  puts result["data"]    # response body
else
  # On an HTTP error status there is no err (only a transport failure sets
  # it), so fall back to the status code.
  warn(result["err"] || "HTTP #{result["status"]}")
end
```

### Prepare a request without sending it

```ruby
begin
  fetchdef = client.prepare({
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => { "id" => "example" },
  })
  puts fetchdef["url"]
  puts fetchdef["method"]
  puts fetchdef["headers"]
rescue => err
  warn "prepare failed: #{err}"
end
```

### Use test mode

Create a mock client for unit testing — no server required:

```ruby
client = LocationSharingSDK.test

# Entity ops return the ENTITY (raises on error);
# call data_get for the mock record.
location = client.Location.load()
puts location
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ruby
mock_fetch = ->(url, init) {
  return {
    "status" => 200,
    "statusText" => "OK",
    "headers" => {},
    "json" => ->() { { "id" => "mock01" } },
  }, nil
}

client = LocationSharingSDK.new({
  "base" => "http://localhost:8080",
  "system" => {
    "fetch" => mock_fetch,
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
cd rb && ruby -Itest -e "Dir['test/*_test.rb'].each { |f| require_relative f }"
```


## Reference

### LocationSharingSDK

```ruby
require_relative "LocationSharing_sdk"
client = LocationSharingSDK.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Hash` | Feature activation flags. |
| `extend` | `Hash` | Additional Feature instances to load. |
| `system` | `Hash` | System overrides (e.g. custom `fetch` lambda). |

### test

```ruby
client = LocationSharingSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### LocationSharingSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Hash` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Hash` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Hash` | Build and send an HTTP request. Returns a result hash (`result["ok"]`); does not raise. |
| `Address` | `(data) -> AddressEntity` | Create an Address entity instance. |
| `BuildingCheck` | `(data) -> BuildingCheckEntity` | Create a BuildingCheck entity instance. |
| `Export` | `(data) -> ExportEntity` | Create an Export entity instance. |
| `History` | `(data) -> HistoryEntity` | Create a History entity instance. |
| `Location` | `(data) -> LocationEntity` | Create a Location entity instance. |
| `Marker` | `(data) -> MarkerEntity` | Create a Marker entity instance. |
| `Repeat` | `(data) -> RepeatEntity` | Create a Repeat entity instance. |
| `Search` | `(data) -> SearchEntity` | Create a Search entity instance. |
| `Share` | `(data) -> ShareEntity` | Create a Share entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch = nil, ctrl) -> Array` | List entities matching the criteria (call with no argument to list all). Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> Hash` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> Hash` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the result data directly. On failure they
raise a `LocationSharingError` (a `StandardError` subclass), so wrap
calls in `begin`/`rescue` where you need to handle errors.

The `direct` escape hatch is the exception: it never raises and instead
returns a result `Hash` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Integer` | HTTP status code. |
| `headers` | `Hash` | Response headers. |
| `data` | `any` | Parsed JSON response body. |
| `err` | `Error` | Present when `ok` is `false`. |

### Entities

#### Address

| Field | Description |
| --- | --- |
| `address` | Full formatted address |
| `city` | City name |
| `country` | Country name |
| `postalCode` | Postal or ZIP code |
| `state` | State or province |
| `street` | Street name |

Operations: Load.

API path: `/geocode/reverse`

#### BuildingCheck

| Field | Description |
| --- | --- |
| `distance` | Distance to building edge in meters |
| `highlighted` |  |
| `id` |  |
| `name` |  |

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
| `accuracy` |  |
| `address` |  |
| `id` |  |
| `latitude` |  |
| `longitude` |  |
| `name` |  |
| `timestamp` |  |

Operations: Create, List, Remove.

API path: `/history`

#### Location

| Field | Description |
| --- | --- |
| `accuracy` | Accuracy in meters |
| `address` | Human-readable address |
| `latitude` | Latitude coordinate |
| `longitude` | Longitude coordinate |
| `timestamp` | Timestamp of the location fix |

Operations: Load.

API path: `/location`

#### Marker

| Field | Description |
| --- | --- |
| `address` |  |
| `createdAt` |  |
| `id` | Unique marker identifier |
| `latitude` |  |
| `longitude` |  |
| `name` | Name or label for the marker |

Operations: Create, List, Remove.

API path: `/markers`

#### Repeat

| Field | Description |
| --- | --- |
| `accuracy` |  |
| `bestAccuracy` | Best (lowest) accuracy value from all measurements |
| `count` | Number of measurements to take (recommended 8-15) |
| `interval` | Interval between measurements in seconds (recommended 0.8-2.0) |
| `latitude` |  |
| `longitude` |  |
| `measurements` |  |
| `resultType` | Type of result to return |

Operations: Create.

API path: `/measurement/repeat`

#### Search

| Field | Description |
| --- | --- |
| `address` | Full address |
| `latitude` |  |
| `longitude` |  |
| `name` | Name of the location |
| `type` | Type of location (e.g., building, park, street) |

Operations: List.

API path: `/search`

#### Share

| Field | Description |
| --- | --- |
| `address` | Address of the location |
| `expiresAt` | Expiration time of the share link |
| `latitude` |  |
| `longitude` |  |
| `name` | Optional name for the location |
| `qrCode` | URL to QR code image |
| `shareLink` | Shareable URL for the location |

Operations: Create.

API path: `/share`



## Entities


### Address

Create an instance: `address = client.Address`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `String` | Full formatted address |
| `city` | `String` | City name |
| `country` | `String` | Country name |
| `postalCode` | `String` | Postal or ZIP code |
| `state` | `String` | State or province |
| `street` | `String` | Street name |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Address record (raises on error).
address = client.Address.load({ "lat" => 1, "lon" => 1 })
```


### BuildingCheck

Create an instance: `building_check = client.BuildingCheck`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `distance` | `Float` | Distance to building edge in meters |
| `highlighted` | `Boolean` |  |
| `id` | `String` |  |
| `name` | `String` |  |

#### Example: List

```ruby
# list returns an Array of BuildingCheck records (raises on error).
building_checks = client.BuildingCheck.list
```


### Export

Create an instance: `export = client.Export`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Export record (raises on error).
export = client.Export.load()
```


### History

Create an instance: `history = client.History`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `Float` |  |
| `address` | `String` |  |
| `id` | `String` |  |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` |  |
| `timestamp` | `String` |  |

#### Example: List

```ruby
# list returns an Array of History records (raises on error).
historys = client.History.list
```

#### Example: Create

```ruby
history = client.History.create({
  "id" => "example_id", # String
  "latitude" => 1, # Float
  "longitude" => 1, # Float
  "timestamp" => "example_timestamp", # String
})
```


### Location

Create an instance: `location = client.Location`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `Float` | Accuracy in meters |
| `address` | `String` | Human-readable address |
| `latitude` | `Float` | Latitude coordinate |
| `longitude` | `Float` | Longitude coordinate |
| `timestamp` | `String` | Timestamp of the location fix |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Location record (raises on error).
location = client.Location.load()
```


### Marker

Create an instance: `marker = client.Marker`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `String` |  |
| `createdAt` | `String` |  |
| `id` | `String` | Unique marker identifier |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` | Name or label for the marker |

#### Example: List

```ruby
# list returns an Array of Marker records (raises on error).
markers = client.Marker.list
```

#### Example: Create

```ruby
marker = client.Marker.create({
  "id" => "example_id", # String
  "latitude" => 1, # Float
  "longitude" => 1, # Float
})
```


### Repeat

Create an instance: `repeat = client.Repeat`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `Float` |  |
| `bestAccuracy` | `Float` | Best (lowest) accuracy value from all measurements |
| `count` | `Integer` | Number of measurements to take (recommended 8-15) |
| `interval` | `Float` | Interval between measurements in seconds (recommended 0.8-2.0) |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `measurements` | `Array` |  |
| `resultType` | `String` | Type of result to return |

#### Example: Create

```ruby
repeat = client.Repeat.create({
  "count" => 1, # Integer
  "interval" => 1, # Float
})
```


### Search

Create an instance: `search = client.Search`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `String` | Full address |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` | Name of the location |
| `type` | `String` | Type of location (e.g., building, park, street) |

#### Example: List

```ruby
# list returns an Array of Search records (raises on error).
searchs = client.Search.list
```


### Share

Create an instance: `share = client.Share`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `String` | Address of the location |
| `expiresAt` | `String` | Expiration time of the share link |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` | Optional name for the location |
| `qrCode` | `String` | URL to QR code image |
| `shareLink` | `String` | Shareable URL for the location |

#### Example: Create

```ruby
share = client.Share.create({
  "latitude" => 1, # Float
  "longitude" => 1, # Float
  "shareLink" => "example_shareLink", # String
})
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

Features are the extension mechanism. A feature is a Ruby class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashes

The Ruby SDK uses plain Ruby hashes throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers.to_map()` to safely validate that a value is a hash.

### Module structure

```
rb/
├── LocationSharing_sdk.rb       -- Main SDK module
├── config.rb                  -- Configuration
├── features.rb                -- Feature factory
├── core/                      -- Core types and context
├── entity/                    -- Entity implementations
├── feature/                   -- Built-in features (Base, Test, Log)
├── utility/                   -- Utility functions and struct library
└── test/                      -- Test suites
```

The main module (`LocationSharing_sdk`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```ruby
location = client.Location
location.load()

# location.data_get now returns the location data from the last load
# location.match_get returns the last match criteria
```

Call `make` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
