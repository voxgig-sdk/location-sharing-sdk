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
(0, node_test_1.describe)('RepeatEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when LOCATION_SHARING_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('LOCATION_SHARING_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.LocationSharingSDK.test();
        const ent = testsdk.Repeat();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.LOCATION_SHARING_TEST_LIVE;
        for (const op of ['create']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'repeat.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": [{ "active": true, "format": "float", "name": "accuracy", "req": false, "type": "`$NUMBER`", "index$": 0 }, { "active": true, "format": "float", "name": "bestAccuracy", "req": false, "short": "Best (lowest) accuracy value from all measurements", "type": "`$NUMBER`", "index$": 1 }, { "active": true, "name": "count", "req": true, "short": "Number of measurements to take (recommended 8-15)", "type": "`$INTEGER`", "index$": 2 }, { "active": true, "format": "float", "name": "interval", "req": true, "short": "Interval between measurements in seconds (recommended 0.8-2.0)", "type": "`$NUMBER`", "index$": 3 }, { "active": true, "format": "double", "name": "latitude", "req": false, "type": "`$NUMBER`", "index$": 4 }, { "active": true, "format": "double", "name": "longitude", "req": false, "type": "`$NUMBER`", "index$": 5 }, { "active": true, "name": "measurements", "req": false, "type": "`$ARRAY`", "index$": 6 }, { "active": true, "name": "resultType", "op": { "create": { "req": true, "type": "`$STRING`" } }, "req": false, "short": "Type of result to return", "type": "`$STRING`", "index$": 7 }], "name": "repeat", "op": { "create": { "input": "data", "name": "create", "points": [{ "active": true, "args": {}, "contract": { "id": "POST /measurement/repeat", "json": "{\"operationId\":\"repeatMeasurement\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"count\":{\"description\":\"Number of measurements to take (recommended 8-15)\",\"maximum\":30,\"minimum\":1,\"type\":\"integer\"},\"interval\":{\"description\":\"Interval between measurements in seconds (recommended 0.8-2.0)\",\"format\":\"float\",\"maximum\":10,\"minimum\":0.5,\"type\":\"number\"},\"resultType\":{\"description\":\"Type of result to return\",\"enum\":[\"best\",\"average\"],\"type\":\"string\"}},\"required\":[\"count\",\"interval\",\"resultType\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"accuracy\":{\"format\":\"float\",\"type\":\"number\"},\"bestAccuracy\":{\"description\":\"Best (lowest) accuracy value from all measurements\",\"format\":\"float\",\"type\":\"number\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"measurements\":{\"items\":{\"properties\":{\"accuracy\":{\"format\":\"float\",\"type\":\"number\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"timestamp\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"},\"resultType\":{\"enum\":[\"best\",\"average\"],\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Measurement results\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"code\":{\"description\":\"Error code\",\"type\":\"string\"},\"details\":{\"description\":\"Additional error details\",\"type\":\"object\"},\"error\":{\"description\":\"Error message\",\"type\":\"string\"}},\"required\":[\"error\"],\"type\":\"object\"}}},\"description\":\"Invalid measurement parameters\"}},\"securitySource\":\"unspecified\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/measurement/repeat", "segments": [{ "lit": "measurement" }, { "lit": "repeat" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "create" } }, "relations": { "ancestors": [] }, "key$": "repeat", "name__orig": "repeat", "Name": "Repeat", "name_": "repeat", "name-": "repeat", "NAME": "REPEAT", "index$": 6 }, { "active": true, "entity": "repeat", "key$": "BasicRepeatFlow", "kind": "basic", "name": "BasicRepeatFlow", "param": {}, "step": [{ "active": true, "data": {}, "input": { "ref": "repeat_ref01" }, "match": {}, "op": "create", "spec": [], "valid": [], "index$": 0 }] }, 'Repeat');
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const repeat_ref01_ent = client.Repeat();
        let repeat_ref01_data = setup.data.new.repeat['repeat_ref01'];
        repeat_ref01_data = (await repeat_ref01_ent.create(repeat_ref01_data)).data();
        (0, node_assert_1.default)(null != repeat_ref01_data);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/repeat/RepeatTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.LocationSharingSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['repeat01', 'repeat02', 'repeat03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'LOCATION_SHARING_TEST_REPEAT_ENTID': idmap,
        'LOCATION_SHARING_TEST_LIVE': 'FALSE',
        'LOCATION_SHARING_TEST_EXPLAIN': 'FALSE',
    });
    idmap = env['LOCATION_SHARING_TEST_REPEAT_ENTID'];
    const live = 'TRUE' === env.LOCATION_SHARING_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['LOCATION_SHARING_TEST_REPEAT_ENTID'];
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
//# sourceMappingURL=RepeatEntity.test.js.map