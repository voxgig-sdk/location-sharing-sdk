
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { LocationSharingSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await LocationSharingSDK.test()
    equal(null !== testsdk, true)
  })

})
