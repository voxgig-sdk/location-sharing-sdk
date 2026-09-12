import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { History, HistoryListMatch, HistoryCreateData, HistoryRemoveMatch } from '../LocationSharingTypes';
declare class HistoryEntity extends LocationSharingEntityBase<History> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: HistoryEntity): HistoryEntity;
    list(this: any, reqmatch?: HistoryListMatch, ctrl?: Control): Promise<HistoryEntity[]>;
    create(this: any, reqdata?: HistoryCreateData, ctrl?: Control): Promise<HistoryEntity>;
    remove(this: any, reqmatch?: HistoryRemoveMatch, ctrl?: Control): Promise<HistoryEntity>;
}
export { HistoryEntity };
