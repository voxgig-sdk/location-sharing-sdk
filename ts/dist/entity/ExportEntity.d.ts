import { LocationSharingEntityBase } from '../LocationSharingEntityBase';
import type { LocationSharingSDK } from '../LocationSharingSDK';
import type { Control } from '../types';
import type { Export, ExportLoadMatch } from '../LocationSharingTypes';
declare class ExportEntity extends LocationSharingEntityBase<Export> {
    constructor(client: LocationSharingSDK, entopts: any);
    make(this: ExportEntity): ExportEntity;
    load(this: any, reqmatch?: ExportLoadMatch, ctrl?: Control): Promise<ExportEntity>;
}
export { ExportEntity };
