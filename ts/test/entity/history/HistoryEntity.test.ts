

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { LocationSharingSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


describe('HistoryEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when LOCATION_SHARING_TEST_LIVE=TRUE.
  afterEach(liveDelay('LOCATION_SHARING_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = LocationSharingSDK.test()
    const ent = testsdk.History()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.LOCATION_SHARING_TEST_LIVE
    for (const op of ['create', 'list', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'history.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"format":"float","name":"accuracy","req":false,"type":"`$NUMBER`","index$":0},{"active":true,"name":"address","req":false,"type":"`$STRING`","index$":1},{"active":true,"name":"id","req":true,"type":"`$STRING`","index$":2},{"active":true,"format":"double","name":"latitude","req":true,"type":"`$NUMBER`","index$":3},{"active":true,"format":"double","name":"longitude","req":true,"type":"`$NUMBER`","index$":4},{"active":true,"name":"name","req":false,"type":"`$STRING`","index$":5},{"active":true,"format":"date-time","name":"timestamp","req":true,"type":"`$STRING`","index$":6}],"id":{"field":"id","name":"id"},"name":"history","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /history","json":"{\"operationId\":\"saveHistory\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"accuracy\":{\"format\":\"float\",\"type\":\"number\"},\"address\":{\"type\":\"string\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"name\":{\"type\":\"string\"}},\"required\":[\"latitude\",\"longitude\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"accuracy\":{\"format\":\"float\",\"type\":\"number\"},\"address\":{\"type\":\"string\"},\"id\":{\"type\":\"string\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"name\":{\"type\":\"string\"},\"timestamp\":{\"format\":\"date-time\",\"type\":\"string\"}},\"required\":[\"id\",\"latitude\",\"longitude\",\"timestamp\"],\"type\":\"object\"}}},\"description\":\"History entry created\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/history","segments":[{"lit":"history"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"active":true,"args":{},"contract":{"id":"GET /history","json":"{\"operationId\":\"getHistory\",\"parameters\":[],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"items\":{\"properties\":{\"accuracy\":{\"format\":\"float\",\"type\":\"number\"},\"address\":{\"type\":\"string\"},\"id\":{\"type\":\"string\"},\"latitude\":{\"format\":\"double\",\"type\":\"number\"},\"longitude\":{\"format\":\"double\",\"type\":\"number\"},\"name\":{\"type\":\"string\"},\"timestamp\":{\"format\":\"date-time\",\"type\":\"string\"}},\"required\":[\"id\",\"latitude\",\"longitude\",\"timestamp\"],\"type\":\"object\"},\"type\":\"array\"}}},\"description\":\"Location history\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/history","segments":[{"lit":"history"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"list"},"remove":{"input":"data","name":"remove","points":[{"active":true,"args":{},"contract":{"id":"DELETE /history","json":"{\"operationId\":\"clearHistory\",\"parameters\":[],\"protocol\":\"http\",\"responses\":{\"204\":{\"description\":\"History cleared successfully\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"DELETE","orig":"/history","segments":[{"lit":"history"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"}},"relations":{"ancestors":[]},"key$":"history","name__orig":"history","Name":"History","name_":"history","name-":"history","NAME":"HISTORY","index$":3}, {"active":true,"entity":"history","key$":"BasicHistoryFlow","kind":"basic","name":"BasicHistoryFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"history_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0},{"active":true,"data":{},"input":{},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemExists","def":{"ref":"history_ref01"}}],"index$":1},{"active":true,"data":{},"input":{"ref":"history_ref01","suffix":"_rm0"},"match":{},"op":"remove","spec":[],"valid":[],"index$":2},{"active":true,"data":{},"input":{"suffix":"_rt0"},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemNotExists","def":{"ref":"history_ref01"}}],"index$":3}]}, 'History')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const history_ref01_ent = client.History()
    let history_ref01_data = setup.data.new.history['history_ref01']

    history_ref01_data = (await history_ref01_ent.create(history_ref01_data)).data()
    assert(null != history_ref01_data.id)


    // LIST
    const history_ref01_match: any = {}

    const history_ref01_list = (await history_ref01_ent.list(history_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(history_ref01_list, { id: history_ref01_data.id })))


    // REMOVE
    const history_ref01_match_rm0: any = { id: history_ref01_data.id }
    await history_ref01_ent.remove(history_ref01_match_rm0)
  

    // LIST
    const history_ref01_match_rt0: any = {}

    const history_ref01_list_rt0 = (await history_ref01_ent.list(history_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(history_ref01_list_rt0, { id: history_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/history/HistoryTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = LocationSharingSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['history01','history02','history03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'LOCATION_SHARING_TEST_HISTORY_ENTID': idmap,
    'LOCATION_SHARING_TEST_LIVE': 'FALSE',
    'LOCATION_SHARING_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['LOCATION_SHARING_TEST_HISTORY_ENTID']

  const live = 'TRUE' === env.LOCATION_SHARING_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['LOCATION_SHARING_TEST_HISTORY_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new LocationSharingSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
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
  }

  return setup
}
  
