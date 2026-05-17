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

func TestHistoryEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.History(nil)
		if ent == nil {
			t.Fatal("expected non-nil HistoryEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := historyBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "history." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_HISTORY_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		historyRef01Ent := client.History(nil)
		historyRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "history"}, setup.data), "history_ref01"))

		historyRef01DataResult, err := historyRef01Ent.Create(historyRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		historyRef01Data = core.ToMapAny(historyRef01DataResult)
		if historyRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if historyRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		historyRef01Match := map[string]any{}

		historyRef01ListResult, err := historyRef01Ent.List(historyRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		historyRef01List, historyRef01ListOk := historyRef01ListResult.([]any)
		if !historyRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", historyRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(historyRef01List), map[string]any{"id": historyRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// REMOVE
		historyRef01MatchRm0 := map[string]any{
			"id": historyRef01Data["id"],
		}
		_, err = historyRef01Ent.Remove(historyRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		historyRef01MatchRt0 := map[string]any{}

		historyRef01ListRt0Result, err := historyRef01Ent.List(historyRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		historyRef01ListRt0, historyRef01ListRt0Ok := historyRef01ListRt0Result.([]any)
		if !historyRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", historyRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(historyRef01ListRt0), map[string]any{"id": historyRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func historyBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "history", "HistoryTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read history test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse history test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"history01", "history02", "history03"},
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
	entidEnvRaw := os.Getenv("LOCATIONSHARING_TEST_HISTORY_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"LOCATIONSHARING_TEST_HISTORY_ENTID": idmap,
		"LOCATIONSHARING_TEST_LIVE":      "FALSE",
		"LOCATIONSHARING_TEST_EXPLAIN":   "FALSE",
		"LOCATIONSHARING_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["LOCATIONSHARING_TEST_HISTORY_ENTID"])
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
