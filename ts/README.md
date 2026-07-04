# LocationSharing TypeScript SDK



The TypeScript SDK for the LocationSharing API — a type-safe, entity-oriented client with full async/await support.

> Other languages, the CLI, and MCP server live alongside this one — see
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
  const address = await client.Address().load({ id: 'example_id' })
  console.log(address)
} catch (err) {
  console.error('load failed:', err)
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

const address = await client.Address().load({ id: 'test01' })
// address is a bare entity populated with mock response data
console.log(address)
```

You can also use the instance method:

```ts
const client = new LocationSharingSDK()
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Address()

// First call sets internal match
await entity.load({ id: 'example' })

// Subsequent calls reuse the stored match
const data = entity.data()
console.log(data.id) // 'example'
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
| `update` | `update(reqdata?, ctrl?): Promise<Entity>` | Update an existing entity. |
| `remove` | `remove(reqmatch?, ctrl?): Promise<void>` | Remove an entity. |
| `data` | `data(data?): any` | Get or set entity data. |
| `match` | `match(match?): any` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): LocationSharingSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load`, `create` and `update` resolve to a single entity object.
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
| `address` |  |
| `city` |  |
| `country` |  |
| `postal_code` |  |
| `state` |  |
| `street` |  |

Operations: load.

API path: `/geocode/reverse`

#### BuildingCheck

| Field | Description |
| --- | --- |
| `distance` |  |
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
| `accuracy` |  |
| `address` |  |
| `latitude` |  |
| `longitude` |  |
| `timestamp` |  |

Operations: load.

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

Operations: create, list, remove.

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

Operations: create.

API path: `/measurement/repeat`

#### Search

| Field | Description |
| --- | --- |
| `address` |  |
| `latitude` |  |
| `longitude` |  |
| `name` |  |
| `type` |  |

Operations: list.

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
| `address` | ``$STRING`` |  |
| `city` | ``$STRING`` |  |
| `country` | ``$STRING`` |  |
| `postal_code` | ``$STRING`` |  |
| `state` | ``$STRING`` |  |
| `street` | ``$STRING`` |  |

#### Example: Load

```ts
const address = await client.Address().load({ id: 'address_id' })
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
| `distance` | ``$NUMBER`` |  |
| `highlighted` | ``$BOOLEAN`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```ts
const building_checks = await client.BuildingCheck().list()
```


### Export

Create an instance: `const export = client.Export()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const export = await client.Export().load({ id: 'export_id' })
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
| `accuracy` | ``$NUMBER`` |  |
| `address` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |
| `timestamp` | ``$STRING`` |  |

#### Example: List

```ts
const historys = await client.History().list()
```

#### Example: Create

```ts
const history = await client.History().create({
  latitude: /* `$NUMBER` */,
  longitude: /* `$NUMBER` */,
  timestamp: /* `$STRING` */,
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
| `accuracy` | ``$NUMBER`` |  |
| `address` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `timestamp` | ``$STRING`` |  |

#### Example: Load

```ts
const location = await client.Location().load({ id: 'location_id' })
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
| `address` | ``$STRING`` |  |
| `created_at` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```ts
const markers = await client.Marker().list()
```

#### Example: Create

```ts
const marker = await client.Marker().create({
  latitude: /* `$NUMBER` */,
  longitude: /* `$NUMBER` */,
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
| `accuracy` | ``$NUMBER`` |  |
| `best_accuracy` | ``$NUMBER`` |  |
| `count` | ``$INTEGER`` |  |
| `interval` | ``$NUMBER`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `measurement` | ``$ARRAY`` |  |
| `result_type` | ``$STRING`` |  |

#### Example: Create

```ts
const repeat = await client.Repeat().create({
  count: /* `$INTEGER` */,
  interval: /* `$NUMBER` */,
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
| `address` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```ts
const searchs = await client.Search().list()
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
| `address` | ``$STRING`` |  |
| `expires_at` | ``$STRING`` |  |
| `latitude` | ``$NUMBER`` |  |
| `longitude` | ``$NUMBER`` |  |
| `name` | ``$STRING`` |  |
| `qr_code` | ``$STRING`` |  |
| `share_link` | ``$STRING`` |  |

#### Example: Create

```ts
const share = await client.Share().create({
  latitude: /* `$NUMBER` */,
  longitude: /* `$NUMBER` */,
  share_link: /* `$STRING` */,
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
error is returned to the caller.

An unexpected exception triggers the `PreUnexpected` hook before
propagating.

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
const address = client.Address()
await address.load({ id: "example_id" })

// address.data() now returns the loaded address data
// address.match() returns { id: "example_id" }
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
