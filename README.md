# LocationSharing SDK

Search for places, reverse-geocode coordinates, generate QR codes, and manage map layers from one endpoint

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About Location Sharing API

The Location Sharing API is a small location utility served from [mcinenews.net/LAT](https://mcinenews.net/LAT). It pairs a location-checker web tool with a single HTTP endpoint that lets you search for places and share their coordinates.

What you get from the API:

- Location search and reverse geocoding of latitude / longitude pairs
- Address lookup with accuracy (in metres) for a given coordinate
- Building detection backed by OpenStreetMap, including distance to building edges
- QR-code generation for a location, plus map-layer display and management
- Repeated-measurement helpers (best-accuracy or averaged values) and export to GeoJSON, KML, or CSV

Operational notes: the service exposes a single `GET` endpoint at `https://mcinenews.net/LAT/`. CORS is disabled, so calls are best made server-side. No authentication is documented, and no licence or rate-limit policy is published — treat the service as best-effort.

## Try it

**TypeScript**
```bash
npm install location-sharing
```

**Python**
```bash
pip install location-sharing-sdk
```

**PHP**
```bash
composer require voxgig/location-sharing-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/location-sharing-sdk/go
```

**Ruby**
```bash
gem install location-sharing-sdk
```

**Lua**
```bash
luarocks install location-sharing-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { LocationSharingSDK } from 'location-sharing'

const client = new LocationSharingSDK({})

```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o location-sharing-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "location-sharing": {
      "command": "/abs/path/to/location-sharing-mcp"
    }
  }
}
```

## Entities

The API exposes 9 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Address** | Address records returned for a coordinate via reverse geocoding. | `/geocode/reverse` |
| **BuildingCheck** | Building-detection results sourced from OpenStreetMap, including distance to the nearest building edge. | `/buildings/check` |
| **Export** | Export of collected locations / measurements as GeoJSON, KML, or CSV. | `/export/csv` |
| **History** | Locally stored history of past lookups and measurements. | `/history` |
| **Location** | A latitude / longitude point together with derived address and accuracy data. | `/location` |
| **Marker** | Map markers that can be placed and managed on the displayed map layers. | `/markers` |
| **Repeat** | Repeated-measurement helper that reduces GPS noise by taking the best or averaged value. | `/measurement/repeat` |
| **Search** | Free-text location search over place names and addresses. | `/search` |
| **Share** | Shareable representation of a location, including QR-code generation. | `/share` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from locationsharing_sdk import LocationSharingSDK

client = LocationSharingSDK({})


# Load a specific address
address, err = client.Address(None).load(
    {"id": "example_id"}, None
)
```

### PHP

```php
<?php
require_once 'locationsharing_sdk.php';

$client = new LocationSharingSDK([]);


// Load a specific address
[$address, $err] = $client->Address(null)->load(
    ["id" => "example_id"], null
);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/location-sharing-sdk/go"

client := sdk.NewLocationSharingSDK(map[string]any{})

```

### Ruby

```ruby
require_relative "LocationSharing_sdk"

client = LocationSharingSDK.new({})


# Load a specific address
address, err = client.Address(nil).load(
  { "id" => "example_id" }, nil
)
```

### Lua

```lua
local sdk = require("location-sharing_sdk")

local client = sdk.new({})


-- Load a specific address
local address, err = client:Address(nil):load(
  { id = "example_id" }, nil
)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = LocationSharingSDK.test()
const result = await client.Address().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = LocationSharingSDK.test(None, None)
result, err = client.Address(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = LocationSharingSDK::test(null, null);
[$result, $err] = $client->Address(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Address(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = LocationSharingSDK.test(nil, nil)
result, err = client.Address(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Address(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the Location Sharing API

- Upstream: [https://mcinenews.net/LAT](https://mcinenews.net/LAT)
- API docs: [https://freepublicapis.com/location-sharing-api](https://freepublicapis.com/location-sharing-api)

---

Generated from the Location Sharing API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
