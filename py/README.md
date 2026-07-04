# LocationSharing Python SDK



The Python SDK for the LocationSharing API — an entity-oriented client following Pythonic conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/location-sharing-sdk/releases)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```python
from locationsharing_sdk import LocationSharingSDK

client = LocationSharingSDK()
```

### 3. Load an address

`load()` returns the bare record (a `dict`) and raises on error.

```python
try:
    address = client.Address().load({"id": "example_id"})
    print(address)
except Exception as err:
    print(f"load failed: {err}")
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    print(result["err"])     # error value
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = LocationSharingSDK.test()

# Entity ops return the bare record and raise on error.
address = client.Address().load({"id": "test01"})
# address contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = LocationSharingSDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
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
cd py && pytest test/
```


## Reference

### LocationSharingSDK

```python
from locationsharing_sdk import LocationSharingSDK

client = LocationSharingSDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = LocationSharingSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### LocationSharingSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
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
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `update` | `(reqdata, ctrl) -> any` | Update an existing entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `dict` for single-entity
ops, a `list` for `list`) and raise on error. Wrap calls in
`try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `address = client.Address()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | ``$STRING`` |  |
| `city` | ``$STRING`` |  |
| `country` | ``$STRING`` |  |
| `postal_code` | ``$STRING`` |  |
| `state` | ``$STRING`` |  |
| `street` | ``$STRING`` |  |

#### Example: Load

```python
address = client.Address().load({"id": "address_id"})
```


### BuildingCheck

Create an instance: `building_check = client.BuildingCheck()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `distance` | ``$NUMBER`` |  |
| `highlighted` | ``$BOOLEAN`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```python
building_checks = client.BuildingCheck().list({})
```


### Export

Create an instance: `export = client.Export()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
export = client.Export().load({"id": "export_id"})
```


### History

Create an instance: `history = client.History()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | ``$NUMBER`` |  |
| `address` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |
| `timestamp` | ``$STRING`` |  |

#### Example: List

```python
historys = client.History().list({})
```

#### Example: Create

```python
history = client.History().create({
    "latitude": ...,  # `$NUMBER`
    "longitude": ...,  # `$NUMBER`
    "timestamp": ...,  # `$STRING`
})
```


### Location

Create an instance: `location = client.Location()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | ``$NUMBER`` |  |
| `address` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `timestamp` | ``$STRING`` |  |

#### Example: Load

```python
location = client.Location().load({"id": "location_id"})
```


### Marker

Create an instance: `marker = client.Marker()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | ``$STRING`` |  |
| `created_at` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```python
markers = client.Marker().list({})
```

#### Example: Create

```python
marker = client.Marker().create({
    "latitude": ...,  # `$NUMBER`
    "longitude": ...,  # `$NUMBER`
})
```


### Repeat

Create an instance: `repeat = client.Repeat()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | ``$NUMBER`` |  |
| `best_accuracy` | ``$NUMBER`` |  |
| `count` | ``$INTEGER`` |  |
| `interval` | ``$NUMBER`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `measurement` | ``$ARRAY`` |  |
| `result_type` | ``$STRING`` |  |

#### Example: Create

```python
repeat = client.Repeat().create({
    "count": ...,  # `$INTEGER`
    "interval": ...,  # `$NUMBER`
})
```


### Search

Create an instance: `search = client.Search()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```python
searchs = client.Search().list({})
```


### Share

Create an instance: `share = client.Share()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | ``$STRING`` |  |
| `expires_at` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |
| `qr_code` | ``$STRING`` |  |
| `share_link` | ``$STRING`` |  |

#### Example: Create

```python
share = client.Share().create({
    "latitude": ...,  # `$NUMBER`
    "longitude": ...,  # `$NUMBER`
    "share_link": ...,  # `$STRING`
})
```


## Explanation

### The operation pipeline

Every entity operation (load, list, create, update, remove) follows a
six-stage pipeline. Each stage fires a feature hook before executing:

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

If any stage returns an error, the pipeline short-circuits and the
error is returned to the caller as the second element in the return tuple.

### Features and hooks

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── locationsharing_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`locationsharing_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```python
address = client.Address()
address.load({"id": "example_id"})

# address.data_get() now returns the loaded address data
# address.match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
