import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { Share, ShareCreateData } from '../LocationSharingTypes';
declare class ShareEntity extends LocationSharingEntityBase<Share> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: ShareEntity): ShareEntity;
    create(this: any, reqdata?: ShareCreateData, ctrl?: Control): Promise<ShareEntity>;
}
export { ShareEntity };
