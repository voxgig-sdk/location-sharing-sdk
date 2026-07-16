<?php
declare(strict_types=1);

// Marker entity test

require_once __DIR__ . '/../locationsharing_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class MarkerEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = LocationSharingSDK::test(null, null);
        $ent = $testsdk->Marker(null);
        $this->assertNotNull($ent);
    }

    // Feature #4: the entity stream(action, ...) method runs the op pipeline
    // and yields result items. With the streaming feature active it yields the
    // feature's incremental output; otherwise it falls back to the materialised
    // list so stream always yields.
    public function test_stream(): void
    {
        $seed = [
            "entity" => [
                "marker" => [
                    "s1" => ["id" => "s1"],
                    "s2" => ["id" => "s2"],
                    "s3" => ["id" => "s3"],
                ],
            ],
        ];

        // Fallback: streaming inactive -> yields the materialised list items.
        $base = LocationSharingSDK::test($seed, null);
        $seen = iterator_to_array($base->Marker(null)->stream("list", null, null), false);
        $this->assertCount(3, $seen);

        // Inbound: streaming active -> yields each item from the feature.
        $cfg = LocationSharingConfig::make_config();
        if (isset($cfg["feature"]) && is_array($cfg["feature"]) && isset($cfg["feature"]["streaming"])) {
            $sdk = LocationSharingSDK::test($seed, ["feature" => ["streaming" => ["active" => true]]]);
            $got = [];
            foreach ($sdk->Marker(null)->stream("list", null, null) as $item) {
                if (is_array($item) && array_is_list($item)) {
                    foreach ($item as $sub) {
                        $got[] = $sub;
                    }
                } else {
                    $got[] = $item;
                }
            }
            $this->assertCount(3, $got);
        }
    }

    public function test_basic_flow(): void
    {
        $setup = marker_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create", "list", "remove"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "marker." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_MARKER_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $marker_ref01_ent = $client->Marker(null);
        $marker_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.marker"), "marker_ref01"));

        $marker_ref01_data_result = $marker_ref01_ent->create($marker_ref01_data, null);
        $marker_ref01_data = Helpers::to_map($marker_ref01_data_result);
        $this->assertNotNull($marker_ref01_data);
        $this->assertNotNull($marker_ref01_data["id"]);

        // LIST
        $marker_ref01_match = [];

        $marker_ref01_list_result = $marker_ref01_ent->list($marker_ref01_match, null);
        $this->assertIsArray($marker_ref01_list_result);

        $found_item = sdk_select(
            Runner::entity_list_to_data($marker_ref01_list_result),
            ["id" => $marker_ref01_data["id"]]);
        $this->assertNotEmpty($found_item);

        // REMOVE
        $marker_ref01_match_rm0 = [
            "id" => $marker_ref01_data["id"],
        ];
        $marker_ref01_ent->remove($marker_ref01_match_rm0, null);

        // LIST
        $marker_ref01_match_rt0 = [];

        $marker_ref01_list_rt0_result = $marker_ref01_ent->list($marker_ref01_match_rt0, null);
        $this->assertIsArray($marker_ref01_list_rt0_result);

        $not_found_item = sdk_select(
            Runner::entity_list_to_data($marker_ref01_list_rt0_result),
            ["id" => $marker_ref01_data["id"]]);
        $this->assertEmpty($not_found_item);

    }
}

function marker_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/marker/MarkerTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = LocationSharingSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["marker01", "marker02", "marker03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("LOCATIONSHARING_TEST_MARKER_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "LOCATIONSHARING_TEST_MARKER_ENTID" => $idmap,
        "LOCATIONSHARING_TEST_LIVE" => "FALSE",
        "LOCATIONSHARING_TEST_EXPLAIN" => "FALSE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["LOCATIONSHARING_TEST_MARKER_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["LOCATIONSHARING_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
            ],
            $extra ?? [],
        ]);
        $client = new LocationSharingSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["LOCATIONSHARING_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["LOCATIONSHARING_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
