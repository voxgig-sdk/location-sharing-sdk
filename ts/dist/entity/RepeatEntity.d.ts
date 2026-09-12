import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { Repeat, RepeatCreateData } from '../LocationSharingTypes';
declare class RepeatEntity extends LocationSharingEntityBase<Repeat> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: RepeatEntity): RepeatEntity;
    create(this: any, reqdata?: RepeatCreateData, ctrl?: Control): Promise<RepeatEntity>;
}
export { RepeatEntity };
