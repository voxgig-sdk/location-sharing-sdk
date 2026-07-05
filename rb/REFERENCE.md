# LocationSharing Ruby SDK Reference

Complete API reference for the LocationSharing Ruby SDK.


## LocationSharingSDK

### Constructor

```ruby
require_relative 'LocationSharing_sdk'

client = LocationSharingSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `LocationSharingSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = LocationSharingSDK.test
```


### Instance Methods

#### `Address(data = nil)`

Create a new `Address` entity instance. Pass `nil` for no initial data.

#### `BuildingCheck(data = nil)`

Create a new `BuildingCheck` entity instance. Pass `nil` for no initial data.

#### `Export(data = nil)`

Create a new `Export` entity instance. Pass `nil` for no initial data.

#### `History(data = nil)`

Create a new `History` entity instance. Pass `nil` for no initial data.

#### `Location(data = nil)`

Create a new `Location` entity instance. Pass `nil` for no initial data.

#### `Marker(data = nil)`

Create a new `Marker` entity instance. Pass `nil` for no initial data.

#### `Repeat(data = nil)`

Create a new `Repeat` entity instance. Pass `nil` for no initial data.

#### `Search(data = nil)`

Create a new `Search` entity instance. Pass `nil` for no initial data.

#### `Share(data = nil)`

Create a new `Share` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## AddressEntity

```ruby
address = client.Address
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `String` | Yes |  |
| `city` | `String` | No |  |
| `country` | `String` | No |  |
| `postal_code` | `String` | No |  |
| `state` | `String` | No |  |
| `street` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Address.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `AddressEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## BuildingCheckEntity

```ruby
building_check = client.BuildingCheck
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `distance` | `Float` | No |  |
| `highlighted` | `Boolean` | No |  |
| `id` | `String` | No |  |
| `name` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.BuildingCheck.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `BuildingCheckEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ExportEntity

```ruby
export = client.Export
```

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Export.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ExportEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## HistoryEntity

```ruby
history = client.History
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | `Float` | No |  |
| `address` | `String` | No |  |
| `id` | `String` | Yes |  |
| `latitude` | `Float` | Yes |  |
| `longitude` | `Float` | Yes |  |
| `name` | `String` | No |  |
| `timestamp` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.History.create({
  "latitude" => 1, # Float
  "longitude" => 1, # Float
  "timestamp" => "example", # String
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.History.list
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.History.remove()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `HistoryEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## LocationEntity

```ruby
location = client.Location
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | `Float` | Yes |  |
| `address` | `String` | No |  |
| `latitude` | `Float` | Yes |  |
| `longitude` | `Float` | Yes |  |
| `timestamp` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Location.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `LocationEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## MarkerEntity

```ruby
marker = client.Marker
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `String` | No |  |
| `created_at` | `String` | No |  |
| `id` | `String` | Yes |  |
| `latitude` | `Float` | Yes |  |
| `longitude` | `Float` | Yes |  |
| `name` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Marker.create({
  "latitude" => 1, # Float
  "longitude" => 1, # Float
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Marker.list
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Marker.remove()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `MarkerEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## RepeatEntity

```ruby
repeat = client.Repeat
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | `Float` | No |  |
| `best_accuracy` | `Float` | No |  |
| `count` | `Integer` | Yes |  |
| `interval` | `Float` | Yes |  |
| `latitude` | `Float` | No |  |
| `longitude` | `Float` | No |  |
| `measurement` | `Array` | No |  |
| `result_type` | `String` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Repeat.create({
  "count" => 1, # Integer
  "interval" => 1, # Float
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `RepeatEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SearchEntity

```ruby
search = client.Search
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `String` | No |  |
| `latitude` | `Float` | Yes |  |
| `longitude` | `Float` | Yes |  |
| `name` | `String` | Yes |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Search.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SearchEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ShareEntity

```ruby
share = client.Share
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `String` | No |  |
| `expires_at` | `String` | No |  |
| `latitude` | `Float` | Yes |  |
| `longitude` | `Float` | Yes |  |
| `name` | `String` | No |  |
| `qr_code` | `String` | No |  |
| `share_link` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Share.create({
  "latitude" => 1, # Float
  "longitude" => 1, # Float
  "share_link" => "example", # String
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ShareEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = LocationSharingSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

