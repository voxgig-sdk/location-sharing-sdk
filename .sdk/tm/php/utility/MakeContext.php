<?php
declare(strict_types=1);

// LocationSharing SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class LocationSharingMakeContext
{
    public static function call(array $ctxmap, ?LocationSharingContext $basectx): LocationSharingContext
    {
        return new LocationSharingContext($ctxmap, $basectx);
    }
}
