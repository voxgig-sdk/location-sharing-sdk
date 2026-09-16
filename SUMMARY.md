# Location Sharing API

This API enables users to search for locations and share their coordinates easily. It includes features like reverse geocoding, QR code generation for locations, and the ability to display and manage map layers.

## Start here

This guide introduces the API, the client libraries, and the companion tools in this repository. Start with the API capabilities, choose a client for your application, and use the linked reference when you need exact request and response details.

The selected API surface contains 9 entities and 15 HTTP routes. There are 6 SDK targets and 2 companion tools.

An entity groups related API operations. An operation can have several routes with different inputs or authentication requirements. The SDK exposes the entity and its operations using the conventions of the selected language.

## What the API provides

### Address

Results: Successful address retrieval.

SDK operations: `load`.

Key fields to recognise:

- `address`: Full formatted address
- `city`: City name
- `country`: Country name
- `postalCode`: Postal or ZIP code
- `state`: State or province

### BuildingCheck

Results: Building check result.

SDK operations: `list`.

Key fields to recognise:

- `distance`: Distance to building edge in meters

### Export

Results: CSV export; GeoJSON export; KML export.

SDK operations: `load`.

### History

Results: History entry created; Location history; History cleared successfully.

SDK operations: `create`, `list`, `remove`.

### Location

Results: Successful location retrieval.

SDK operations: `load`.

Key fields to recognise:

- `accuracy`: Accuracy in meters
- `address`: Human-readable address
- `latitude`: Latitude coordinate
- `longitude`: Longitude coordinate
- `timestamp`: Timestamp of the location fix

### Marker

Results: Marker created successfully; List of markers; All markers cleared successfully.

SDK operations: `create`, `list`, `remove`.

Key fields to recognise:

- `id`: Unique marker identifier
- `name`: Name or label for the marker

### Repeat

Results: Measurement results.

SDK operations: `create`.

Key fields to recognise:

- `bestAccuracy`: Best (lowest) accuracy value from all measurements
- `count`: Number of measurements to take (recommended 8-15)
- `interval`: Interval between measurements in seconds (recommended 0.8-2.0)
- `resultType`: Type of result to return

### Search

Results: Search results.

SDK operations: `list`.

Key fields to recognise:

- `address`: Full address
- `name`: Name of the location
- `type`: Type of location (for example, building, park, street)

### Share

Results: Shareable link created.

SDK operations: `create`.

Key fields to recognise:

- `address`: Address of the location
- `expiresAt`: Expiration time of the share link
- `name`: Optional name for the location
- `qrCode`: URL to QR code image
- `shareLink`: Shareable URL for the location

### Route map

Use this map to locate a capability. Consult the entity reference before supplying request data; routes for the same operation can require different fields.

| Entity | SDK operation | HTTP route | Authentication |
| --- | --- | --- | --- |
| Address | `load` | `GET /geocode/reverse` | See reference |
| BuildingCheck | `list` | `GET /buildings/check` | See reference |
| Export | `load` | `GET /export/csv` | See reference |
| Export | `load` | `GET /export/geojson` | See reference |
| Export | `load` | `GET /export/kml` | See reference |
| History | `create` | `POST /history` | See reference |
| History | `list` | `GET /history` | See reference |
| History | `remove` | `DELETE /history` | See reference |
| Location | `load` | `GET /location` | See reference |
| Marker | `create` | `POST /markers` | See reference |
| Marker | `list` | `GET /markers` | See reference |
| Marker | `remove` | `DELETE /markers` | See reference |
| Repeat | `create` | `POST /measurement/repeat` | See reference |
| Search | `list` | `GET /search` | See reference |
| Share | `create` | `POST /share` | See reference |

## Connect to the API

- Production server: `https://mcinenews.net/LAT`

Check authentication for the route you plan to call. A route that declares no authentication can be used without credentials; this does not change the requirements of other routes. Keep credentials in environment variables or a configured secret provider, and keep them out of source control and logs.

## Make a first request

1. Choose the API server and an operation that matches your task.
2. Check the operation’s required input and authentication. Use values valid for your account and environment.
3. Send one request and inspect the returned data before adding retries, concurrency, or a larger batch.

For an SDK call, install or build the chosen client, create a client instance with its documented configuration, and call the required entity operation. Language references describe the argument shape, asynchronous behaviour, and returned values.

## Choose an SDK

Choose the language already used by your application or service. The clients represent the same API model, while package setup, naming, and return types follow each language. Check the selected client’s reference and tests before integrating it into an existing application.

| Client | Repository directory | Distribution |
| --- | --- | --- |
| Golang | `go/` | Build from source |
| Lua | `lua/` | Build from source |
| PHP | `php/` | Build from source |
| Python | `py/` | Build from source |
| Ruby | `rb/` | Build from source |
| TypeScript | `ts/` | Build from source |

Build-from-source entries are not marked as published in the project model. Follow the build instructions in that target’s README, then consume the resulting package using your language’s local dependency mechanism. Published entries give the installation command recorded for that client.

## Companion tools

These targets provide another way to use the API. Their available commands or tools can cover a smaller set of operations than the client libraries.

### Go CLI

Use the command-line interface for shell-based tasks and scripts.

Repository directory: `go-cli/`. Not published. Build from the go-cli directory.


### Go MCP server

Use the MCP server to expose supported API operations to an MCP client.

Repository directory: `go-mcp/`. Not published. Build from the go-mcp directory.

- `location-sharing_list`: List records for an entity. Supported entities: `building_check`, `history`, `marker`, `search`.
- `location-sharing_load`: Load one record for an entity. Supported entities: `address`, `export`, `location`.

## Operational features

Features supply behaviour around API calls, such as request handling, diagnostics, or local testing. Inclusion in this project does not mean a feature is enabled at runtime. Check the selected SDK’s supported features and configuration defaults, then enable the behaviour your application needs.

- `ratelimit`: Client-side rate limiting via a token bucket
- `retry`: Automatic retry of transient failures with exponential backoff
- `test`: In-memory mock transport for testing without a live server
- `timeout`: Per-request timeout with transport abort

Start with the default client configuration. Add request limits and diagnostics as needed, test error paths, and review retry behaviour before using operations that change data. A retry can repeat an operation unless the API provides a suitable guarantee.

## Continue with the documentation

- Follow the first-call guide for the setup sequence.
- Read the authentication guide before using protected routes.
- Use the API reference for request schemas, response formats, and status codes.
- Check the chosen SDK or companion tool reference for its configuration and supported operations.

