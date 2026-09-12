import { Context } from './Context';
declare class LocationSharingError extends Error {
    isLocationSharingError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { LocationSharingError };
