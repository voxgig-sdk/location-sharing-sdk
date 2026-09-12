import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { BuildingCheck, BuildingCheckListMatch } from '../LocationSharingTypes';
declare class BuildingCheckEntity extends LocationSharingEntityBase<BuildingCheck> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: BuildingCheckEntity): BuildingCheckEntity;
    list(this: any, reqmatch?: BuildingCheckListMatch, ctrl?: Control): Promise<BuildingCheckEntity[]>;
}
export { BuildingCheckEntity };
