# LocationSharing TypeScript SDK Reference

Complete API reference for the LocationSharing TypeScript SDK.


## LocationSharingSDK

### Constructor

```ts
new LocationSharingSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `LocationSharingSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = LocationSharingSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `LocationSharingSDK` instance in test mode.


### Instance Methods

#### `Address(data?: object)`

Create a new `Address` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `AddressEntity` instance.

#### `BuildingCheck(data?: object)`

Create a new `BuildingCheck` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `BuildingCheckEntity` instance.

#### `Export(data?: object)`

Create a new `Export` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ExportEntity` instance.

#### `History(data?: object)`

Create a new `History` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `HistoryEntity` instance.

#### `Location(data?: object)`

Create a new `Location` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `LocationEntity` instance.

#### `Marker(data?: object)`

Create a new `Marker` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `MarkerEntity` instance.

#### `Repeat(data?: object)`

Create a new `Repeat` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `RepeatEntity` instance.

#### `Search(data?: object)`

Create a new `Search` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SearchEntity` instance.

#### `Share(data?: object)`

Create a new `Share` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ShareEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `LocationSharingSDK.test()`.

**Returns:** `LocationSharingSDK` instance in test mode.


---

## AddressEntity

```ts
const address = client.address
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

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.address.load({ id: 'address_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `AddressEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## BuildingCheckEntity

```ts
const building_check = client.building_check
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `distance` | ``$NUMBER`` | No |  |
| `highlighted` | ``$BOOLEAN`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.building_check.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `BuildingCheckEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ExportEntity

```ts
const export = client.export
```

### Operations

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.export.load({ id: 'export_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ExportEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## HistoryEntity

```ts
const history = client.history
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.history.create({
  latitude: /* `$NUMBER` */,
  longitude: /* `$NUMBER` */,
  timestamp: /* `$STRING` */,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.history.list()
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.history.remove({ id: 'history_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `HistoryEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## LocationEntity

```ts
const location = client.location
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

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.location.load({ id: 'location_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `LocationEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## MarkerEntity

```ts
const marker = client.marker
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.marker.create({
  latitude: /* `$NUMBER` */,
  longitude: /* `$NUMBER` */,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.marker.list()
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.marker.remove({ id: 'marker_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `MarkerEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## RepeatEntity

```ts
const repeat = client.repeat
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.repeat.create({
  count: /* `$INTEGER` */,
  interval: /* `$NUMBER` */,
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `RepeatEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SearchEntity

```ts
const search = client.search
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.search.list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SearchEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ShareEntity

```ts
const share = client.share
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.share.create({
  latitude: /* `$NUMBER` */,
  longitude: /* `$NUMBER` */,
  share_link: /* `$STRING` */,
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ShareEntity` instance with the same client and
options.

#### `client()`

Return the parent `LocationSharingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new LocationSharingSDK({
  feature: {
    test: { active: true },
  }
})
```

