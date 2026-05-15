<?php
declare(strict_types=1);

// LocationSharing SDK exists test

require_once __DIR__ . '/../locationsharing_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = LocationSharingSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
