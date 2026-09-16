"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('MarkerEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when LOCATION_SHARING_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('LOCATION_SHARING_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.LocationSharingSDK.test();
        const ent = testsdk.Marker();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.LOCATION_SHARING_TEST_LIVE;
        for (const op of ['create', 'list', 'remove']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'marker.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": [{ "active": true, "name": "address", "req": false, "type": "`$STRING`", "index$": 0 }, { "active": true, "format": "date-time", "name": "createdAt", "req": false, "type": "`$STRING`", "index$": 1 }, { "active": true, "name": "id", "req": true, "short": "Unique marker identifier", "type": "`$STRING`", "index$": 2 }, { "active": true, "format": "double", "name": "latitude", "req": true, "type": "`$NUMBER`", "index$": 3 }, { "active": true, "format": "double", "name": "longitude", "req": true, "type": "`$NUMBER`", "index$": 4 }, { "active": true, "name": "name", "req": false, "short": "Name or label for the marker", "type": "`$STRING`", "index$": 5 }], "id": { "field": "id", "name": "id" }, "name": "marker", "op": { "create": { "input": "data", "name": "create", "points": [{ "active": true, "args": {}, "contract": { "id": "POST /markers", "json": "{\"operationId\":\"addMarker\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"address\":{\"type\":\"string\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"name\":{\"type\":\"string\"}},\"required\":[\"latitude\",\"longitude\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"address\":{\"type\":\"string\"},\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"id\":{\"description\":\"Unique marker identifier\",\"type\":\"string\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"name\":{\"description\":\"Name or label for the marker\",\"type\":\"string\"}},\"required\":[\"id\",\"latitude\",\"longitude\"],\"type\":\"object\"}}},\"description\":\"Marker created successfully\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"code\":{\"description\":\"Error code\",\"type\":\"string\"},\"details\":{\"description\":\"Additional error details\",\"type\":\"object\"},\"error\":{\"description\":\"Error message\",\"type\":\"string\"}},\"required\":[\"error\"],\"type\":\"object\"}}},\"description\":\"Invalid marker data\"}},\"securitySource\":\"unspecified\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/markers", "segments": [{ "lit": "markers" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "create" }, "list": { "input": "data", "name": "list", "points": [{ "active": true, "args": {}, "contract": { "id": "GET /markers", "json": "{\"operationId\":\"listMarkers\",\"parameters\":[],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"items\":{\"properties\":{\"address\":{\"type\":\"string\"},\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"id\":{\"description\":\"Unique marker identifier\",\"type\":\"string\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"name\":{\"description\":\"Name or label for the marker\",\"type\":\"string\"}},\"required\":[\"id\",\"latitude\",\"longitude\"],\"type\":\"object\"},\"type\":\"array\"}}},\"description\":\"List of markers\"}},\"securitySource\":\"unspecified\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "GET", "orig": "/markers", "segments": [{ "lit": "markers" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "list" }, "remove": { "input": "data", "name": "remove", "points": [{ "active": true, "args": {}, "contract": { "id": "DELETE /markers", "json": "{\"operationId\":\"clearMarkers\",\"parameters\":[],\"protocol\":\"http\",\"responses\":{\"204\":{\"description\":\"All markers cleared successfully\"}},\"securitySource\":\"unspecified\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "DELETE", "orig": "/markers", "segments": [{ "lit": "markers" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "remove" } }, "relations": { "ancestors": [] }, "key$": "marker", "name__orig": "marker", "Name": "Marker", "name_": "marker", "name-": "marker", "NAME": "MARKER", "index$": 5 }, { "active": true, "entity": "marker", "key$": "BasicMarkerFlow", "kind": "basic", "name": "BasicMarkerFlow", "param": {}, "step": [{ "active": true, "data": {}, "input": { "ref": "marker_ref01" }, "match": {}, "op": "create", "spec": [], "valid": [], "index$": 0 }, { "active": true, "data": {}, "input": {}, "match": {}, "op": "list", "spec": [], "valid": [{ "apply": "ItemExists", "def": { "ref": "marker_ref01" } }], "index$": 1 }, { "active": true, "data": {}, "input": { "ref": "marker_ref01", "suffix": "_rm0" }, "match": {}, "op": "remove", "spec": [], "valid": [], "index$": 2 }, { "active": true, "data": {}, "input": { "suffix": "_rt0" }, "match": {}, "op": "list", "spec": [], "valid": [{ "apply": "ItemNotExists", "def": { "ref": "marker_ref01" } }], "index$": 3 }] }, 'Marker');
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const marker_ref01_ent = client.Marker();
        let marker_ref01_data = setup.data.new.marker['marker_ref01'];
        marker_ref01_data = (await marker_ref01_ent.create(marker_ref01_data)).data();
        (0, node_assert_1.default)(null != marker_ref01_data.id);
        // LIST
        const marker_ref01_match = {};
        const marker_ref01_list = (await marker_ref01_ent.list(marker_ref01_match)).map((e) => e.data());
        (0, node_assert_1.default)(!isempty(select(marker_ref01_list, { id: marker_ref01_data.id })));
        // REMOVE
        const marker_ref01_match_rm0 = { id: marker_ref01_data.id };
        await marker_ref01_ent.remove(marker_ref01_match_rm0);
        // LIST
        const marker_ref01_match_rt0 = {};
        const marker_ref01_list_rt0 = (await marker_ref01_ent.list(marker_ref01_match_rt0)).map((e) => e.data());
        (0, node_assert_1.default)(isempty(select(marker_ref01_list_rt0, { id: marker_ref01_data.id })));
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/marker/MarkerTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.LocationSharingSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['marker01', 'marker02', 'marker03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'LOCATION_SHARING_TEST_MARKER_ENTID': idmap,
        'LOCATION_SHARING_TEST_LIVE': 'FALSE',
        'LOCATION_SHARING_TEST_EXPLAIN': 'FALSE',
    });
    idmap = env['LOCATION_SHARING_TEST_MARKER_ENTID'];
    const live = 'TRUE' === env.LOCATION_SHARING_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['LOCATION_SHARING_TEST_MARKER_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.LocationSharingSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {},
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.LOCATION_SHARING_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=MarkerEntity.test.js.map