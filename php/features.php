<?php
declare(strict_types=1);

// LocationSharing SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class LocationSharingFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new LocationSharingBaseFeature();
            case "test":
                return new LocationSharingTestFeature();
            default:
                return new LocationSharingBaseFeature();
        }
    }
}
