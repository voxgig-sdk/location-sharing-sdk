import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { Marker, MarkerListMatch, MarkerCreateData, MarkerRemoveMatch } from '../LocationSharingTypes';
declare class MarkerEntity extends LocationSharingEntityBase<Marker> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: MarkerEntity): MarkerEntity;
    list(this: any, reqmatch?: MarkerListMatch, ctrl?: Control): Promise<MarkerEntity[]>;
    create(this: any, reqdata?: MarkerCreateData, ctrl?: Control): Promise<MarkerEntity>;
    remove(this: any, reqmatch?: MarkerRemoveMatch, ctrl?: Control): Promise<MarkerEntity>;
}
export { MarkerEntity };
