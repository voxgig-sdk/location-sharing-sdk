# LocationSharing Python SDK Reference

Complete API reference for the LocationSharing Python SDK.


## LocationSharingSDK

### Constructor

```python
from location-sharing_sdk import LocationSharingSDK

client = LocationSharingSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `LocationSharingSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = LocationSharingSDK.test()
```


### Instance Methods

#### `Address(data=None)`

Create a new `AddressEntity` instance. Pass `None` for no initial data.

#### `BuildingCheck(data=None)`

Create a new `BuildingCheckEntity` instance. Pass `None` for no initial data.

#### `Export(data=None)`

Create a new `ExportEntity` instance. Pass `None` for no initial data.

#### `History(data=None)`

Create a new `HistoryEntity` instance. Pass `None` for no initial data.

#### `Location(data=None)`

Create a new `LocationEntity` instance. Pass `None` for no initial data.

#### `Marker(data=None)`

Create a new `MarkerEntity` instance. Pass `None` for no initial data.

#### `Repeat(data=None)`

Create a new `RepeatEntity` instance. Pass `None` for no initial data.

#### `Search(data=None)`

Create a new `SearchEntity` instance. Pass `None` for no initial data.

#### `Share(data=None)`

Create a new `ShareEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> tuple`

Make a direct HTTP request to any API endpoint. Returns `(result, err)`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `(result_dict, err)`

#### `prepare(fetchargs=None) -> tuple`

Prepare a fetch definition without sending. Returns `(fetchdef, err)`.


---

## AddressEntity

```python
address = client.Address()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | ``$STRING`` | Yes |  |
| `city` | ``$STRING`` | No |  |
| `country` | ``$STRING`` | No |  |
| `postal_code` | ``$STRING`` | No |  |
| `state` | ``$STRING`` | No |  |
| `street` | ``$STRING`` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Address().load({"id": "address_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AddressEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## BuildingCheckEntity

```python
building_check = client.BuildingCheck()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `distance` | ``$NUMBER`` | No |  |
| `highlighted` | ``$BOOLEAN`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.BuildingCheck().list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BuildingCheckEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ExportEntity

```python
export = client.Export()
```

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Export().load({"id": "export_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ExportEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## HistoryEntity

```python
history = client.History()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | ``$NUMBER`` | No |  |
| `address` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | Yes |  |
| `latitude` | ``$NUMBER`` | Yes |  |
| `longitude` | ``$NUMBER`` | Yes |  |
| `name` | ``$STRING`` | No |  |
| `timestamp` | ``$STRING`` | Yes |  |

### Operations

#### `create(reqdata, ctrl=None) -> tuple`

Create a new entity with the given data.

```python
result, err = client.History().create({
    "latitude": # `$NUMBER`,
    "longitude": # `$NUMBER`,
    "timestamp": # `$STRING`,
})
```

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.History().list({})
```

#### `remove(reqmatch, ctrl=None) -> tuple`

Remove the entity matching the given criteria.

```python
result, err = client.History().remove({"id": "history_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `HistoryEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## LocationEntity

```python
location = client.Location()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | ``$NUMBER`` | Yes |  |
| `address` | ``$STRING`` | No |  |
| `latitude` | ``$NUMBER`` | Yes |  |
| `longitude` | ``$NUMBER`` | Yes |  |
| `timestamp` | ``$STRING`` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Location().load({"id": "location_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `LocationEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MarkerEntity

```python
marker = client.Marker()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | ``$STRING`` | No |  |
| `created_at` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | Yes |  |
| `latitude` | ``$NUMBER`` | Yes |  |
| `longitude` | ``$NUMBER`` | Yes |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `create(reqdata, ctrl=None) -> tuple`

Create a new entity with the given data.

```python
result, err = client.Marker().create({
    "latitude": # `$NUMBER`,
    "longitude": # `$NUMBER`,
})
```

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Marker().list({})
```

#### `remove(reqmatch, ctrl=None) -> tuple`

Remove the entity matching the given criteria.

```python
result, err = client.Marker().remove({"id": "marker_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MarkerEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## RepeatEntity

```python
repeat = client.Repeat()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `accuracy` | ``$NUMBER`` | No |  |
| `best_accuracy` | ``$NUMBER`` | No |  |
| `count` | ``$INTEGER`` | Yes |  |
| `interval` | ``$NUMBER`` | Yes |  |
| `latitude` | ``$NUMBER`` | No |  |
| `longitude` | ``$NUMBER`` | No |  |
| `measurement` | ``$ARRAY`` | No |  |
| `result_type` | ``$STRING`` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `accuracy` | - | - | - | - | - |
| `best_accuracy` | - | - | - | - | - |
| `count` | - | - | - | - | - |
| `interval` | - | - | - | - | - |
| `latitude` | - | - | - | - | - |
| `longitude` | - | - | - | - | - |
| `measurement` | - | - | - | - | - |
| `result_type` | - | - | Yes | - | - |

### Operations

#### `create(reqdata, ctrl=None) -> tuple`

Create a new entity with the given data.

```python
result, err = client.Repeat().create({
    "count": # `$INTEGER`,
    "interval": # `$NUMBER`,
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `RepeatEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SearchEntity

```python
search = client.Search()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | ``$STRING`` | No |  |
| `latitude` | ``$NUMBER`` | Yes |  |
| `longitude` | ``$NUMBER`` | Yes |  |
| `name` | ``$STRING`` | Yes |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Search().list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SearchEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ShareEntity

```python
share = client.Share()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | ``$STRING`` | No |  |
| `expires_at` | ``$STRING`` | No |  |
| `latitude` | ``$NUMBER`` | Yes |  |
| `longitude` | ``$NUMBER`` | Yes |  |
| `name` | ``$STRING`` | No |  |
| `qr_code` | ``$STRING`` | No |  |
| `share_link` | ``$STRING`` | Yes |  |

### Operations

#### `create(reqdata, ctrl=None) -> tuple`

Create a new entity with the given data.

```python
result, err = client.Share().create({
    "latitude": # `$NUMBER`,
    "longitude": # `$NUMBER`,
    "share_link": # `$STRING`,
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShareEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = LocationSharingSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

