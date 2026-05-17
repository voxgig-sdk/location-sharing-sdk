package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/location-sharing-sdk/go"
	"github.com/voxgig-sdk/location-sharing-sdk/go/core"

	vs "github.com/voxgig-sdk/location-sharing-sdk/go/utility/struct"
)

func TestMarkerEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Marker(nil)
		if ent == nil {
			t.Fatal("expected non-nil MarkerEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := markerBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "marker." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_MARKER_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		markerRef01Ent := client.Marker(nil)
		markerRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "marker"}, setup.data), "marker_ref01"))

		markerRef01DataResult, err := markerRef01Ent.Create(markerRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		markerRef01Data = core.ToMapAny(markerRef01DataResult)
		if markerRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if markerRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		markerRef01Match := map[string]any{}

		markerRef01ListResult, err := markerRef01Ent.List(markerRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		markerRef01List, markerRef01ListOk := markerRef01ListResult.([]any)
		if !markerRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", markerRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(markerRef01List), map[string]any{"id": markerRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// REMOVE
		markerRef01MatchRm0 := map[string]any{
			"id": markerRef01Data["id"],
		}
		_, err = markerRef01Ent.Remove(markerRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		markerRef01MatchRt0 := map[string]any{}

		markerRef01ListRt0Result, err := markerRef01Ent.List(markerRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		markerRef01ListRt0, markerRef01ListRt0Ok := markerRef01ListRt0Result.([]any)
		if !markerRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", markerRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(markerRef01ListRt0), map[string]any{"id": markerRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func markerBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "marker", "MarkerTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read marker test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse marker test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"marker01", "marker02", "marker03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("LOCATIONSHARING_TEST_MARKER_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"LOCATIONSHARING_TEST_MARKER_ENTID": idmap,
		"LOCATIONSHARING_TEST_LIVE":      "FALSE",
		"LOCATIONSHARING_TEST_EXPLAIN":   "FALSE",
		"LOCATIONSHARING_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["LOCATIONSHARING_TEST_MARKER_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["LOCATIONSHARING_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["LOCATIONSHARING_APIKEY"],
			},
			extra,
		})
		client = sdk.NewLocationSharingSDK(core.ToMapAny(mergedOpts))
	}

	live := env["LOCATIONSHARING_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["LOCATIONSHARING_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
