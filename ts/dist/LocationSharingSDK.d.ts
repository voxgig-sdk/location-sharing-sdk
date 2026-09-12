import { AddressEntity } from './entity/AddressEntity';
import { BuildingCheckEntity } from './entity/BuildingCheckEntity';
import { ExportEntity } from './entity/ExportEntity';
import { HistoryEntity } from './entity/HistoryEntity';
import { LocationEntity } from './entity/LocationEntity';
import { MarkerEntity } from './entity/MarkerEntity';
import { RepeatEntity } from './entity/RepeatEntity';
import { SearchEntity } from './entity/SearchEntity';
import { ShareEntity } from './entity/ShareEntity';
export type * from './LocationSharingTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { LocationSharingEntityBase } from './LocationSharingEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
declare class LocationSharingSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    _rawRequest(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Address(entopts?: Record<string, any>): AddressEntity;
    BuildingCheck(entopts?: Record<string, any>): BuildingCheckEntity;
    Export(entopts?: Record<string, any>): ExportEntity;
    History(entopts?: Record<string, any>): HistoryEntity;
    Location(entopts?: Record<string, any>): LocationEntity;
    Marker(entopts?: Record<string, any>): MarkerEntity;
    Repeat(entopts?: Record<string, any>): RepeatEntity;
    Search(entopts?: Record<string, any>): SearchEntity;
    Share(entopts?: Record<string, any>): ShareEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): LocationSharingSDK;
    tester(testopts?: any, sdkopts?: any): LocationSharingSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof LocationSharingSDK;
export { stdutil, config, BaseFeature, LocationSharingEntityBase, LocationSharingSDK, SDK, };
