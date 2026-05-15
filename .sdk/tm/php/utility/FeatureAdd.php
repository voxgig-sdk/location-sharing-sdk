<?php
declare(strict_types=1);

// LocationSharing SDK utility: feature_add

class LocationSharingFeatureAdd
{
    public static function call(LocationSharingContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
