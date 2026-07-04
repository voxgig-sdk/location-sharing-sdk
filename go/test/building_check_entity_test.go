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

func TestBuildingCheckEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.BuildingCheck(nil)
		if ent == nil {
			t.Fatal("expected non-nil BuildingCheckEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := building_checkBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "building_check." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_BUILDING_CHECK_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		buildingCheckRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.building_check", setup.data)))
		var buildingCheckRef01Data map[string]any
		if len(buildingCheckRef01DataRaw) > 0 {
			buildingCheckRef01Data = core.ToMapAny(buildingCheckRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = buildingCheckRef01Data

		// LIST
		buildingCheckRef01Ent := client.BuildingCheck(nil)
		buildingCheckRef01Match := map[string]any{}

		buildingCheckRef01ListResult, err := buildingCheckRef01Ent.List(buildingCheckRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, buildingCheckRef01ListOk := buildingCheckRef01ListResult.([]any)
		if !buildingCheckRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", buildingCheckRef01ListResult)
		}

	})
}

func building_checkBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "building_check", "BuildingCheckTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read building_check test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse building_check test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"building_check01", "building_check02", "building_check03"},
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
	entidEnvRaw := os.Getenv("LOCATIONSHARING_TEST_BUILDING_CHECK_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"LOCATIONSHARING_TEST_BUILDING_CHECK_ENTID": idmap,
		"LOCATIONSHARING_TEST_LIVE":      "FALSE",
		"LOCATIONSHARING_TEST_EXPLAIN":   "FALSE",
	})

	idmapResolved := core.ToMapAny(env["LOCATIONSHARING_TEST_BUILDING_CHECK_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["LOCATIONSHARING_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
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
