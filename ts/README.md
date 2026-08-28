# LocationSharing TypeScript SDK



The TypeScript SDK for the LocationSharing API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Address()` — each with a small set of operations (`list`, `load`, `create`, `remove`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Also generated from this model: `go`, `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb` — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/location-sharing-sdk/releases](https://github.com/voxgig-sdk/location-sharing-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { LocationSharingSDK } from '@voxgig-sdk/location-sharing'

const client = new LocationSharingSDK()
```

### 3. Load an address

`load()` returns the entity directly and throws on failure:

```ts
try {
  const address = await client.Address().load({ lat: 1, lon: 1 })
  console.log(address)
} catch (err) {
  console.error('load failed:', err)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const location = await client.Location().load()
  console.log(location)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result instanceof Error) {
  throw result
}
if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = LocationSharingSDK.test()

const location = await client.Location().load()
// location is the entity, populated with mock response data
// — call location.data() for the record itself
console.log(location)
```

You can also use the instance method:

```ts
const client = new LocationSharingSDK()
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Location()

// First call runs the operation and stores its result
await entity.load()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new LocationSharingSDK({
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
LOCATION_SHARING_TEST_LIVE=TRUE
```

Then run:

```bash
cd ts && npm test
```


## Reference

### LocationSharingSDK

#### Constructor

```ts
new LocationSharingSDK(options?: {
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Address(data?)` | `AddressEntity` | Create an Address entity instance. |
| `BuildingCheck(data?)` | `BuildingCheckEntity` | Create a BuildingCheck entity instance. |
| `Export(data?)` | `ExportEntity` | Create an Export entity instance. |
| `History(data?)` | `HistoryEntity` | Create a History entity instance. |
| `Location(data?)` | `LocationEntity` | Create a Location entity instance. |
| `Marker(data?)` | `MarkerEntity` | Create a Marker entity instance. |
| `Repeat(data?)` | `RepeatEntity` | Create a Repeat entity instance. |
| `Search(data?)` | `SearchEntity` | Create a Search entity instance. |
| `Share(data?)` | `ShareEntity` | Create a Share entity instance. |
| `tester(testopts?, sdkopts?)` | `LocationSharingSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `LocationSharingSDK.test(testopts?, sdkopts?)` | `LocationSharingSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Entity>` | Create a new entity. |
| `remove` | `remove(reqmatch?, ctrl?): Promise<void>` | Remove an entity. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): LocationSharingSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load` and `create` resolve to a single entity object.
- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).
- `remove` resolves to `void`.

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

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

Operations: load.

API path: `/geocode/reverse`

#### BuildingCheck

| Field | Description |
| --- | --- |
| `distance` | Distance to building edge in meters |
| `highlighted` |  |
| `id` |  |
| `name` |  |

Operations: list.

API path: `/buildings/check`

#### Export

| Field | Description |
| --- | --- |

Operations: load.

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

Operations: create, list, remove.

API path: `/history`

#### Location

| Field | Description |
| --- | --- |
| `accuracy` | Accuracy in meters |
| `address` | Human-readable address |
| `latitude` | Latitude coordinate |
| `longitude` | Longitude coordinate |
| `timestamp` | Timestamp of the location fix |

Operations: load.

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

Operations: create, list, remove.

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

Operations: create.

API path: `/measurement/repeat`

#### Search

| Field | Description |
| --- | --- |
| `address` | Full address |
| `latitude` |  |
| `longitude` |  |
| `name` | Name of the location |
| `type` | Type of location (e.g., building, park, street) |

Operations: list.

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

Operations: create.

API path: `/share`



## Entities


### Address

Create an instance: `const address = client.Address()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

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

```ts
const address = await client.Address().load({ lat: 1, lon: 1 })
```


### BuildingCheck

Create an instance: `const building_check = client.BuildingCheck()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `distance` | `number` | Distance to building edge in meters |
| `highlighted` | `boolean` |  |
| `id` | `string` |  |
| `name` | `string` |  |

#### Example: List

```ts
const building_checks = await client.BuildingCheck().list({ lat: 1, lon: 1 })
```


### Export

Create an instance: `const export_ = client.Export()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const export_ = await client.Export().load()
```


### History

Create an instance: `const history = client.History()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `number` |  |
| `address` | `string` |  |
| `id` | `string` |  |
| `latitude` | `number` |  |
| `longitude` | `number` |  |
| `name` | `string` |  |
| `timestamp` | `string` |  |

#### Example: List

```ts
const historys = await client.History().list()
```

#### Example: Create

```ts
const history = await client.History().create({
  id: 'example_id',
  latitude: 1,
  longitude: 1,
  timestamp: 'example_timestamp',
})
```


### Location

Create an instance: `const location = client.Location()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `number` | Accuracy in meters |
| `address` | `string` | Human-readable address |
| `latitude` | `number` | Latitude coordinate |
| `longitude` | `number` | Longitude coordinate |
| `timestamp` | `string` | Timestamp of the location fix |

#### Example: Load

```ts
const location = await client.Location().load()
```


### Marker

Create an instance: `const marker = client.Marker()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` |  |
| `createdAt` | `string` |  |
| `id` | `string` | Unique marker identifier |
| `latitude` | `number` |  |
| `longitude` | `number` |  |
| `name` | `string` | Name or label for the marker |

#### Example: List

```ts
const markers = await client.Marker().list()
```

#### Example: Create

```ts
const marker = await client.Marker().create({
  id: 'example_id',
  latitude: 1,
  longitude: 1,
})
```


### Repeat

Create an instance: `const repeat = client.Repeat()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `accuracy` | `number` |  |
| `bestAccuracy` | `number` | Best (lowest) accuracy value from all measurements |
| `count` | `number` | Number of measurements to take (recommended 8-15) |
| `interval` | `number` | Interval between measurements in seconds (recommended 0.8-2.0) |
| `latitude` | `number` |  |
| `longitude` | `number` |  |
| `measurements` | `any[]` |  |
| `resultType` | `string` | Type of result to return |

#### Example: Create

```ts
const repeat = await client.Repeat().create({
  count: 1,
  interval: 1,
})
```


### Search

Create an instance: `const search = client.Search()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Full address |
| `latitude` | `number` |  |
| `longitude` | `number` |  |
| `name` | `string` | Name of the location |
| `type` | `string` | Type of location (e.g., building, park, street) |

#### Example: List

```ts
const searchs = await client.Search().list({ q: "example" })
```


### Share

Create an instance: `const share = client.Share()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Address of the location |
| `expiresAt` | `string` | Expiration time of the share link |
| `latitude` | `number` |  |
| `longitude` | `number` |  |
| `name` | `string` | Optional name for the location |
| `qrCode` | `string` | URL to QR code image |
| `shareLink` | `string` | Shareable URL for the location |

#### Example: Create

```ts
const share = await client.Share().create({
  latitude: 1,
  longitude: 1,
  shareLink: 'example_shareLink',
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

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
location-sharing/
├── src/
│   ├── LocationSharingSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { LocationSharingSDK } from '@voxgig-sdk/location-sharing'
```

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const location = client.Location()
await location.load()

// location.data() now returns the location data from the last `load`
// location.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
