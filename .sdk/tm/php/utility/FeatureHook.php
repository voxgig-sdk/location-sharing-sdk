<?php
declare(strict_types=1);

// LocationSharing SDK utility: feature_hook

class LocationSharingFeatureHook
{
    public static function call(LocationSharingContext $ctx, string $name): void
    {
        if (!$ctx->client) {
            return;
        }
        $features = $ctx->client->features ?? null;
        if (!$features) {
            return;
        }
        foreach ($features as $f) {
            if (method_exists($f, $name)) {
                $f->$name($ctx);
            }
        }
    }
}
