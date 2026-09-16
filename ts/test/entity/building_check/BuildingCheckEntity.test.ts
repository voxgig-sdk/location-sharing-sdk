

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


describe('BuildingCheckEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when LOCATION_SHARING_TEST_LIVE=TRUE.
  afterEach(liveDelay('LOCATION_SHARING_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = LocationSharingSDK.test()
    const ent = testsdk.BuildingCheck()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.LOCATION_SHARING_TEST_LIVE
    for (const op of ['list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'building_check.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"format":"float","name":"distance","req":false,"short":"Distance to building edge in meters","type":"`$NUMBER`","index$":0},{"active":true,"name":"highlighted","req":false,"type":"`$BOOLEAN`","index$":1},{"active":true,"name":"id","req":false,"type":"`$STRING`","index$":2},{"active":true,"name":"name","req":false,"type":"`$STRING`","index$":3}],"id":{"field":"id","name":"id"},"name":"building_check","op":{"list":{"input":"data","name":"list","points":[{"active":true,"args":{"query":[{"active":true,"kind":"query","name":"lat","orig":"lat","reqd":true,"type":"`$NUMBER`","index$":0},{"active":true,"kind":"query","name":"lon","orig":"lon","reqd":true,"type":"`$NUMBER`","index$":1},{"active":true,"example":40,"kind":"query","name":"radius","orig":"radius","reqd":false,"type":"`$INTEGER`","index$":2},{"active":true,"example":3,"kind":"query","name":"top","orig":"top","reqd":false,"type":"`$INTEGER`","index$":3}]},"contract":{"id":"GET /buildings/check","json":"{\"operationId\":\"checkBuilding\",\"parameters\":[{\"description\":\"Latitude coordinate\",\"in\":\"query\",\"name\":\"lat\",\"required\":true,\"schema\":{\"format\":\"double\",\"type\":\"number\"}},{\"description\":\"Longitude coordinate\",\"in\":\"query\",\"name\":\"lon\",\"required\":true,\"schema\":{\"format\":\"double\",\"type\":\"number\"}},{\"description\":\"Search radius in meters\",\"in\":\"query\",\"name\":\"radius\",\"required\":false,\"schema\":{\"default\":40,\"enum\":[40,60,80,120],\"type\":\"integer\"}},{\"description\":\"Maximum number of buildings to return\",\"in\":\"query\",\"name\":\"top\",\"required\":false,\"schema\":{\"default\":3,\"enum\":[3,5,8],\"type\":\"integer\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"buildings\":{\"items\":{\"properties\":{\"distance\":{\"description\":\"Distance to building edge in meters\",\"format\":\"float\",\"type\":\"number\"},\"highlighted\":{\"type\":\"boolean\"},\"id\":{\"type\":\"string\"},\"name\":{\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"},\"insideBuilding\":{\"description\":\"Whether the location is inside a building\",\"type\":\"boolean\"},\"nearestDistance\":{\"description\":\"Distance to nearest building edge in meters\",\"format\":\"float\",\"type\":\"number\"}},\"type\":\"object\"}}},\"description\":\"Building check result\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"code\":{\"description\":\"Error code\",\"type\":\"string\"},\"details\":{\"description\":\"Additional error details\",\"type\":\"object\"},\"error\":{\"description\":\"Error message\",\"type\":\"string\"}},\"required\":[\"error\"],\"type\":\"object\"}}},\"description\":\"Invalid parameters\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/buildings/check","segments":[{"lit":"buildings"},{"lit":"check"}],"select":{"exist":["lat","lon","radius","top"]},"transform":{"req":"`reqdata`","res":"`body.buildings`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"building_check","name__orig":"building_check","Name":"BuildingCheck","name_":"building_check","name-":"building-check","NAME":"BUILDING_CHECK","index$":1}, {"active":true,"entity":"building_check","key$":"BasicBuildingCheckFlow","kind":"basic","name":"BasicBuildingCheckFlow","param":{},"step":[{"active":true,"data":{},"input":{},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemExists","def":{"ref":"building_check_ref01"}}],"index$":0}]}, 'BuildingCheck')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let building_check_ref01_data = Object.values(setup.data.existing.building_check)[0] as any

    // LIST
    const building_check_ref01_ent = client.BuildingCheck()
    const building_check_ref01_match: any = {}

    const building_check_ref01_list = (await building_check_ref01_ent.list(building_check_ref01_match)).map((e: any) => e.data())


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/building_check/BuildingCheckTestData.json')

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
    ['building_check01','building_check02','building_check03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'LOCATION_SHARING_TEST_BUILDING_CHECK_ENTID': idmap,
    'LOCATION_SHARING_TEST_LIVE': 'FALSE',
    'LOCATION_SHARING_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['LOCATION_SHARING_TEST_BUILDING_CHECK_ENTID']

  const live = 'TRUE' === env.LOCATION_SHARING_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['LOCATION_SHARING_TEST_BUILDING_CHECK_ENTID']
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
  
