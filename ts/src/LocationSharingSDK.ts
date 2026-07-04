// LocationSharing Ts SDK

import { AddressEntity } from './entity/AddressEntity'
import { BuildingCheckEntity } from './entity/BuildingCheckEntity'
import { ExportEntity } from './entity/ExportEntity'
import { HistoryEntity } from './entity/HistoryEntity'
import { LocationEntity } from './entity/LocationEntity'
import { MarkerEntity } from './entity/MarkerEntity'
import { RepeatEntity } from './entity/RepeatEntity'
import { SearchEntity } from './entity/SearchEntity'
import { ShareEntity } from './entity/ShareEntity'

export type * from './LocationSharingTypes'


import { inspect } from 'node:util'

import type { Context, Feature } from './types'

import { config } from './Config'
import { LocationSharingEntityBase } from './LocationSharingEntityBase'
import { Utility } from './utility/Utility'


import { BaseFeature } from './feature/base/BaseFeature'


const stdutil = new Utility()


class LocationSharingSDK {
  _mode: string = 'live'
  _options: any
  _utility = new Utility()
  _features: Feature[]
  _rootctx: Context

  constructor(options?: any) {

    this._rootctx = this._utility.makeContext({
      client: this,
      utility: this._utility,
      config,
      options,
      shared: new WeakMap()
    })

    this._options = this._utility.makeOptions(this._rootctx)

    const struct = this._utility.struct
    const getpath = struct.getpath
    const items = struct.items

    if (true === getpath(this._options.feature, 'test.active')) {
      this._mode = 'test'
    }

    this._rootctx.options = this._options

    this._features = []

    const featureAdd = this._utility.featureAdd
    const featureInit = this._utility.featureInit

    items(this._options.feature, (fitem: [string, any]) => {
      const fname = fitem[0]
      const fopts = fitem[1]
      if (fopts.active) {
        featureAdd(this._rootctx, this._rootctx.config.makeFeature(fname))
      }
    })

    if (null != this._options.extend) {
      for (let f of this._options.extend) {
        featureAdd(this._rootctx, f)
      }
    }

    for (let f of this._features) {
      featureInit(this._rootctx, f)
    }

    const featureHook = this._utility.featureHook
    featureHook(this._rootctx, 'PostConstruct')
  }


  options() {
    return this._utility.struct.clone(this._options)
  }


  utility() {
    return this._utility.struct.clone(this._utility)
  }


  async prepare(fetchargs?: any) {
    const utility = this._utility
    const struct = utility.struct
    const clone = struct.clone

    const {
      makeContext,
      makeFetchDef,
      prepareHeaders,
      prepareAuth,
    } = utility

    fetchargs = fetchargs || {}

    let ctx: Context = makeContext({
      opname: 'prepare',
      ctrl: fetchargs.ctrl || {},
    }, this._rootctx)

    const options = this._options

    // Build spec directly from SDK options + user-provided fetch args.
    const spec: any = {
      base: options.base,
      prefix: options.prefix,
      suffix: options.suffix,
      path: fetchargs.path || '',
      method: fetchargs.method || 'GET',
      params: fetchargs.params || {},
      query: fetchargs.query || {},
      headers: prepareHeaders(ctx),
      body: fetchargs.body,
      step: 'start',
    }

    ctx.spec = spec

    // Merge user-provided headers over SDK defaults.
    if (fetchargs.headers) {
      const uheaders = fetchargs.headers
      for (let key in uheaders) {
        spec.headers[key] = uheaders[key]
      }
    }

    // Apply SDK auth (apikey, auth prefix, etc.)
    const authResult = prepareAuth(ctx)
    if (authResult instanceof Error) {
      return authResult
    }

    return makeFetchDef(ctx)
  }


  async direct(fetchargs?: any) {
    const utility = this._utility
    const fetcher = utility.fetcher
    const makeContext = utility.makeContext

    const fetchdef = await this.prepare(fetchargs)
    if (fetchdef instanceof Error) {
      return fetchdef
    }

    let ctx: Context = makeContext({
      opname: 'direct',
      ctrl: (fetchargs || {}).ctrl || {},
    }, this._rootctx)

    try {
      const fetched = await fetcher(ctx, fetchdef.url, fetchdef)

      if (null == fetched) {
        return { ok: false, err: ctx.error('direct_no_response', 'response: undefined') }
      }
      else if (fetched instanceof Error) {
        return { ok: false, err: fetched }
      }

      const status = fetched.status

      // No body responses (204 No Content, 304 Not Modified) and explicit
      // zero content-length must skip JSON parsing — fetched.json() would
      // throw `Unexpected end of JSON input` on an empty body.
      const headers = fetched.headers
      const contentLength = headers && 'function' === typeof headers.get
        ? headers.get('content-length')
        : (headers || {})['content-length']
      const noBody = 204 === status || 304 === status || '0' === String(contentLength)

      let json: any = undefined
      if (!noBody) {
        try {
          json = 'function' === typeof fetched.json ? await fetched.json() : fetched.json
        }
        catch (parseErr) {
          // Body wasn't valid JSON — surface the raw response rather than
          // throwing. data stays undefined; callers can inspect status/headers.
          json = undefined
        }
      }

      return {
        ok: status >= 200 && status < 300,
        status,
        headers: fetched.headers,
        data: json,
      }
    }
    catch (err: any) {
      return { ok: false, err }
    }
  }



  _address?: AddressEntity

  // Idiomatic facade: `client.address.list()` / `client.address.load({ id })`.
  get address(): AddressEntity {
    return (this._address ??= new AddressEntity(this, undefined))
  }

  /** @deprecated Use `client.address` instead. */
  Address(data?: any) {
    const self = this
    return new AddressEntity(self,data)
  }


  _building_check?: BuildingCheckEntity

  // Idiomatic facade: `client.building_check.list()` / `client.building_check.load({ id })`.
  get building_check(): BuildingCheckEntity {
    return (this._building_check ??= new BuildingCheckEntity(this, undefined))
  }

  /** @deprecated Use `client.building_check` instead. */
  BuildingCheck(data?: any) {
    const self = this
    return new BuildingCheckEntity(self,data)
  }


  _export?: ExportEntity

  // Idiomatic facade: `client.export.list()` / `client.export.load({ id })`.
  get export(): ExportEntity {
    return (this._export ??= new ExportEntity(this, undefined))
  }

  /** @deprecated Use `client.export` instead. */
  Export(data?: any) {
    const self = this
    return new ExportEntity(self,data)
  }


  _history?: HistoryEntity

  // Idiomatic facade: `client.history.list()` / `client.history.load({ id })`.
  get history(): HistoryEntity {
    return (this._history ??= new HistoryEntity(this, undefined))
  }

  /** @deprecated Use `client.history` instead. */
  History(data?: any) {
    const self = this
    return new HistoryEntity(self,data)
  }


  _location?: LocationEntity

  // Idiomatic facade: `client.location.list()` / `client.location.load({ id })`.
  get location(): LocationEntity {
    return (this._location ??= new LocationEntity(this, undefined))
  }

  /** @deprecated Use `client.location` instead. */
  Location(data?: any) {
    const self = this
    return new LocationEntity(self,data)
  }


  _marker?: MarkerEntity

  // Idiomatic facade: `client.marker.list()` / `client.marker.load({ id })`.
  get marker(): MarkerEntity {
    return (this._marker ??= new MarkerEntity(this, undefined))
  }

  /** @deprecated Use `client.marker` instead. */
  Marker(data?: any) {
    const self = this
    return new MarkerEntity(self,data)
  }


  _repeat?: RepeatEntity

  // Idiomatic facade: `client.repeat.list()` / `client.repeat.load({ id })`.
  get repeat(): RepeatEntity {
    return (this._repeat ??= new RepeatEntity(this, undefined))
  }

  /** @deprecated Use `client.repeat` instead. */
  Repeat(data?: any) {
    const self = this
    return new RepeatEntity(self,data)
  }


  _search?: SearchEntity

  // Idiomatic facade: `client.search.list()` / `client.search.load({ id })`.
  get search(): SearchEntity {
    return (this._search ??= new SearchEntity(this, undefined))
  }

  /** @deprecated Use `client.search` instead. */
  Search(data?: any) {
    const self = this
    return new SearchEntity(self,data)
  }


  _share?: ShareEntity

  // Idiomatic facade: `client.share.list()` / `client.share.load({ id })`.
  get share(): ShareEntity {
    return (this._share ??= new ShareEntity(this, undefined))
  }

  /** @deprecated Use `client.share` instead. */
  Share(data?: any) {
    const self = this
    return new ShareEntity(self,data)
  }




  static test(testoptsarg?: any, sdkoptsarg?: any) {
    const struct = stdutil.struct
    const setpath = struct.setpath
    const getdef = struct.getdef
    const clone = struct.clone
    const setprop = struct.setprop

    const sdkopts = getdef(clone(sdkoptsarg), {})
    const testopts = getdef(clone(testoptsarg), {})
    setprop(testopts, 'active', true)
    setpath(sdkopts, 'feature.test', testopts)

    const testsdk = new LocationSharingSDK(sdkopts)
    testsdk._mode = 'test'

    return testsdk
  }


  tester(testopts?: any, sdkopts?: any) {
    return LocationSharingSDK.test(testopts, sdkopts)
  }


  toJSON() {
    return { name: 'LocationSharing' }
  }

  toString() {
    return 'LocationSharing ' + this._utility.struct.jsonify(this.toJSON())
  }

  [inspect.custom]() {
    return this.toString()
  }

}




const SDK = LocationSharingSDK


export {
  stdutil,

  BaseFeature,
  LocationSharingEntityBase,

  LocationSharingSDK,
  SDK,
}


