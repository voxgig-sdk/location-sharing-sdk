<?php
declare(strict_types=1);

// LocationSharing SDK utility: prepare_body

class LocationSharingPrepareBody
{
    public static function call(LocationSharingContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
