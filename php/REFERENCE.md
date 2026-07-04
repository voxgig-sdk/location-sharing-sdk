# LocationSharing PHP SDK Reference

Complete API reference for the LocationSharing PHP SDK.


## LocationSharingSDK

### Constructor

```php
require_once __DIR__ . '/location-sharing_sdk.php';

$client = new LocationSharingSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `LocationSharingSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = LocationSharingSDK::test();
```


### Instance Methods

#### `Address($data = null)`

Create a new `AddressEntity` instance. Pass `null` for no initial data.

#### `BuildingCheck($data = null)`

Create a new `BuildingCheckEntity` instance. Pass `null` for no initial data.

#### `Export($data = null)`

Create a new `ExportEntity` instance. Pass `null` for no initial data.

#### `History($data = null)`

Create a new `HistoryEntity` instance. Pass `null` for no initial data.

#### `Location($data = null)`

Create a new `LocationEntity` instance. Pass `null` for no initial data.

#### `Marker($data = null)`

Create a new `MarkerEntity` instance. Pass `null` for no initial data.

#### `Repeat($data = null)`

Create a new `RepeatEntity` instance. Pass `null` for no initial data.

#### `Search($data = null)`

Create a new `SearchEntity` instance. Pass `null` for no initial data.

#### `Share($data = null)`

Create a new `ShareEntity` instance. Pass `null` for no initial data.

#### `optionsMap(): array`

Return a deep copy of the current SDK options.

#### `getUtility(): ProjectNameUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## AddressEntity

```php
$address = $client->address();
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

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->address()->load(["id" => "address_id"]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): AddressEntity`

Create a new `AddressEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## BuildingCheckEntity

```php
$building_check = $client->building_check();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `distance` | ``$NUMBER`` | No |  |
| `highlighted` | ``$BOOLEAN`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(array $reqmatch, ?array $ctrl = null): mixed`

List entities matching the given criteria. Returns an array. Throws on error.

```php
$results = $client->building_check()->list([]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): BuildingCheckEntity`

Create a new `BuildingCheckEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## ExportEntity

```php
$export = $client->export();
```

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->export()->load(["id" => "export_id"]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): ExportEntity`

Create a new `ExportEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## HistoryEntity

```php
$history = $client->history();
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->history()->create([
  "latitude" => /* `$NUMBER` */,
  "longitude" => /* `$NUMBER` */,
  "timestamp" => /* `$STRING` */,
]);
```

#### `list(array $reqmatch, ?array $ctrl = null): mixed`

List entities matching the given criteria. Returns an array. Throws on error.

```php
$results = $client->history()->list([]);
```

#### `remove(array $reqmatch, ?array $ctrl = null): mixed`

Remove the entity matching the given criteria. Throws on error.

```php
$result = $client->history()->remove(["id" => "history_id"]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): HistoryEntity`

Create a new `HistoryEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## LocationEntity

```php
$location = $client->location();
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

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->location()->load(["id" => "location_id"]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): LocationEntity`

Create a new `LocationEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## MarkerEntity

```php
$marker = $client->marker();
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->marker()->create([
  "latitude" => /* `$NUMBER` */,
  "longitude" => /* `$NUMBER` */,
]);
```

#### `list(array $reqmatch, ?array $ctrl = null): mixed`

List entities matching the given criteria. Returns an array. Throws on error.

```php
$results = $client->marker()->list([]);
```

#### `remove(array $reqmatch, ?array $ctrl = null): mixed`

Remove the entity matching the given criteria. Throws on error.

```php
$result = $client->marker()->remove(["id" => "marker_id"]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): MarkerEntity`

Create a new `MarkerEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## RepeatEntity

```php
$repeat = $client->repeat();
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->repeat()->create([
  "count" => /* `$INTEGER` */,
  "interval" => /* `$NUMBER` */,
]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): RepeatEntity`

Create a new `RepeatEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## SearchEntity

```php
$search = $client->search();
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

#### `list(array $reqmatch, ?array $ctrl = null): mixed`

List entities matching the given criteria. Returns an array. Throws on error.

```php
$results = $client->search()->list([]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): SearchEntity`

Create a new `SearchEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## ShareEntity

```php
$share = $client->share();
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->share()->create([
  "latitude" => /* `$NUMBER` */,
  "longitude" => /* `$NUMBER` */,
  "share_link" => /* `$STRING` */,
]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): ShareEntity`

Create a new `ShareEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new LocationSharingSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

