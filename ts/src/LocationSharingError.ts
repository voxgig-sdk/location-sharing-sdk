
import { Context } from './Context'


class LocationSharingError extends Error {

  isLocationSharingError = true

  sdk = 'LocationSharing'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  LocationSharingError
}

