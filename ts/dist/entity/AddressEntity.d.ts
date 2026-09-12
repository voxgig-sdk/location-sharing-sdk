import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { Address, AddressLoadMatch } from '../LocationSharingTypes';
declare class AddressEntity extends LocationSharingEntityBase<Address> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: AddressEntity): AddressEntity;
    load(this: any, reqmatch?: AddressLoadMatch, ctrl?: Control): Promise<AddressEntity>;
}
export { AddressEntity };
