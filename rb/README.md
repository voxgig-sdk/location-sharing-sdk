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
  # load returns the bare Address record (raises on error).
  address = client.Address.load()
  puts address
rescue => err
  warn "load failed: #{err}"
end
```


## Error handling

Entity operations raise on failure, so rescue them:

```ruby
begin
  address = client.Address.load()
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

# Entity ops return the bare mock record (raises on error).
address = client.Address.load()
puts address
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
| `address` |  |
| `city` |  |
| `country` |  |
| `postal_code` |  |
| `state` |  |
| `street` |  |

Operations: Load.

API path: `/geocode/reverse`

#### BuildingCheck

| Field | Description |
| --- | --- |
| `distance` |  |
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
| `accuracy` |  |
| `address` |  |
| `latitude` |  |
| `longitude` |  |
| `timestamp` |  |

Operations: Load.

API path: `/location`

#### Marker

| Field | Description |
| --- | --- |
| `address` |  |
| `created_at` |  |
| `id` |  |
| `latitude` |  |
| `longitude` |  |
| `name` |  |

Operations: Create, List, Remove.

API path: `/markers`

#### Repeat

| Field | Description |
| --- | --- |
| `accuracy` |  |
| `best_accuracy` |  |
| `count` |  |
| `interval` |  |
| `latitude` |  |
| `longitude` |  |
| `measurement` |  |
| `result_type` |  |

Operations: Create.

API path: `/measurement/repeat`

#### Search

| Field | Description |
| --- | --- |
| `address` |  |
| `latitude` |  |
| `longitude` |  |
| `name` |  |
| `type` |  |

Operations: List.

API path: `/search`

#### Share

| Field | Description |
| --- | --- |
| `address` |  |
| `expires_at` |  |
| `latitude` |  |
| `longitude` |  |
| `name` |  |
| `qr_code` |  |
| `share_link` |  |

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
| `address` | `String` |  |
| `city` | `String` |  |
| `country` | `String` |  |
| `postal_code` | `String` |  |
| `state` | `String` |  |
| `street` | `String` |  |

#### Example: Load

```ruby
# load returns the bare Address record (raises on error).
address = client.Address.load()
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
| `distance` | `Float` |  |
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
# load returns the bare Export record (raises on error).
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
| `accuracy` | `Float` |  |
| `address` | `String` |  |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `timestamp` | `String` |  |

#### Example: Load

```ruby
# load returns the bare Location record (raises on error).
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
| `created_at` | `String` |  |
| `id` | `String` |  |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` |  |

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
| `best_accuracy` | `Float` |  |
| `count` | `Integer` |  |
| `interval` | `Float` |  |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `measurement` | `Array` |  |
| `result_type` | `String` |  |

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
| `address` | `String` |  |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` |  |
| `type` | `String` |  |

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
| `address` | `String` |  |
| `expires_at` | `String` |  |
| `latitude` | `Float` |  |
| `longitude` | `Float` |  |
| `name` | `String` |  |
| `qr_code` | `String` |  |
| `share_link` | `String` |  |

#### Example: Create

```ruby
share = client.Share.create({
  "latitude" => 1, # Float
  "longitude" => 1, # Float
  "share_link" => "example_share_link", # String
})
```


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
address = client.Address
address.load()

# address.data_get now returns the address data from the last load
# address.match_get returns the last match criteria
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
