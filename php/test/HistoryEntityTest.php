<?php
declare(strict_types=1);

// History entity test

require_once __DIR__ . '/../locationsharing_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class HistoryEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = LocationSharingSDK::test(null, null);
        $ent = $testsdk->History(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = history_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create", "list", "remove"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "history." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_HISTORY_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $history_ref01_ent = $client->History(null);
        $history_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.history"), "history_ref01"));

        [$history_ref01_data_result, $err] = $history_ref01_ent->create($history_ref01_data, null);
        $this->assertNull($err);
        $history_ref01_data = Helpers::to_map($history_ref01_data_result);
        $this->assertNotNull($history_ref01_data);
        $this->assertNotNull($history_ref01_data["id"]);

        // LIST
        $history_ref01_match = [];

        [$history_ref01_list_result, $err] = $history_ref01_ent->list($history_ref01_match, null);
        $this->assertNull($err);
        $this->assertIsArray($history_ref01_list_result);

        $found_item = sdk_select(
            Runner::entity_list_to_data($history_ref01_list_result),
            ["id" => $history_ref01_data["id"]]);
        $this->assertNotEmpty($found_item);

        // REMOVE
        $history_ref01_match_rm0 = [
            "id" => $history_ref01_data["id"],
        ];
        [$_, $err] = $history_ref01_ent->remove($history_ref01_match_rm0, null);
        $this->assertNull($err);

        // LIST
        $history_ref01_match_rt0 = [];

        [$history_ref01_list_rt0_result, $err] = $history_ref01_ent->list($history_ref01_match_rt0, null);
        $this->assertNull($err);
        $this->assertIsArray($history_ref01_list_rt0_result);

        $not_found_item = sdk_select(
            Runner::entity_list_to_data($history_ref01_list_rt0_result),
            ["id" => $history_ref01_data["id"]]);
        $this->assertEmpty($not_found_item);

    }
}

function history_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/history/HistoryTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = LocationSharingSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["history01", "history02", "history03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("LOCATIONSHARING_TEST_HISTORY_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "LOCATIONSHARING_TEST_HISTORY_ENTID" => $idmap,
        "LOCATIONSHARING_TEST_LIVE" => "FALSE",
        "LOCATIONSHARING_TEST_EXPLAIN" => "FALSE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["LOCATIONSHARING_TEST_HISTORY_ENTID"]);
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
