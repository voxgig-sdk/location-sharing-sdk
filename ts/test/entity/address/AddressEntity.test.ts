

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


describe('AddressEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when LOCATION_SHARING_TEST_LIVE=TRUE.
  afterEach(liveDelay('LOCATION_SHARING_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = LocationSharingSDK.test()
    const ent = testsdk.Address()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.LOCATION_SHARING_TEST_LIVE
    for (const op of ['load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'address.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"address","req":true,"short":"Full formatted address","type":"`$STRING`","index$":0},{"active":true,"name":"city","req":false,"short":"City name","type":"`$STRING`","index$":1},{"active":true,"name":"country","req":false,"short":"Country name","type":"`$STRING`","index$":2},{"active":true,"name":"postalCode","req":false,"short":"Postal or ZIP code","type":"`$STRING`","index$":3},{"active":true,"name":"state","req":false,"short":"State or province","type":"`$STRING`","index$":4},{"active":true,"name":"street","req":false,"short":"Street name","type":"`$STRING`","index$":5}],"name":"address","op":{"load":{"input":"data","name":"load","points":[{"active":true,"args":{"query":[{"active":true,"kind":"query","name":"lat","orig":"lat","reqd":true,"type":"`$NUMBER`","index$":0},{"active":true,"kind":"query","name":"lon","orig":"lon","reqd":true,"type":"`$NUMBER`","index$":1}]},"contract":{"id":"GET /geocode/reverse","json":"{\"operationId\":\"reverseGeocode\",\"parameters\":[{\"description\":\"Latitude coordinate\",\"in\":\"query\",\"name\":\"lat\",\"required\":true,\"schema\":{\"format\":\"double\",\"maximum\":90,\"minimum\":-90,\"type\":\"number\"}},{\"description\":\"Longitude coordinate\",\"in\":\"query\",\"name\":\"lon\",\"required\":true,\"schema\":{\"format\":\"double\",\"maximum\":180,\"minimum\":-180,\"type\":\"number\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"address\":{\"description\":\"Full formatted address\",\"type\":\"string\"},\"city\":{\"description\":\"City name\",\"type\":\"string\"},\"country\":{\"description\":\"Country name\",\"type\":\"string\"},\"postalCode\":{\"description\":\"Postal or ZIP code\",\"type\":\"string\"},\"state\":{\"description\":\"State or province\",\"type\":\"string\"},\"street\":{\"description\":\"Street name\",\"type\":\"string\"}},\"required\":[\"address\"],\"type\":\"object\"}}},\"description\":\"Successful address retrieval\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"code\":{\"description\":\"Error code\",\"type\":\"string\"},\"details\":{\"description\":\"Additional error details\",\"type\":\"object\"},\"error\":{\"description\":\"Error message\",\"type\":\"string\"}},\"required\":[\"error\"],\"type\":\"object\"}}},\"description\":\"Invalid coordinates\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/geocode/reverse","segments":[{"lit":"geocode"},{"lit":"reverse"}],"select":{"exist":["lat","lon"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"address","name__orig":"address","Name":"Address","name_":"address","name-":"address","NAME":"ADDRESS","index$":0}, {"active":true,"entity":"address","key$":"BasicAddressFlow","kind":"basic","name":"BasicAddressFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"address_ref01","srcdatavar":"address_ref01_data","suffix":"_dt0"},"match":{},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-address_ref01"}}],"index$":0}]}, 'Address')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let address_ref01_data = Object.values(setup.data.existing.address)[0] as any

    // LOAD
    const address_ref01_ent = client.Address()
    const address_ref01_match_dt0: any = {}
    const address_ref01_data_dt0 = (await address_ref01_ent.load(address_ref01_match_dt0)).data()
    assert(null != address_ref01_data_dt0)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/address/AddressTestData.json')

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
    ['address01','address02','address03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'LOCATION_SHARING_TEST_ADDRESS_ENTID': idmap,
    'LOCATION_SHARING_TEST_LIVE': 'FALSE',
    'LOCATION_SHARING_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['LOCATION_SHARING_TEST_ADDRESS_ENTID']

  const live = 'TRUE' === env.LOCATION_SHARING_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['LOCATION_SHARING_TEST_ADDRESS_ENTID']
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
  
