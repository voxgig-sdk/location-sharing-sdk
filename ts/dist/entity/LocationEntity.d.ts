import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { Location, LocationLoadMatch } from '../LocationSharingTypes';
declare class LocationEntity extends LocationSharingEntityBase<Location> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: LocationEntity): LocationEntity;
    load(this: any, reqmatch?: LocationLoadMatch, ctrl?: Control): Promise<LocationEntity>;
}
export { LocationEntity };
