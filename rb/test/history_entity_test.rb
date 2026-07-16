# History entity test

require "minitest/autorun"
require "json"
require_relative "../LocationSharing_sdk"
require_relative "runner"

class HistoryEntityTest < Minitest::Test
  def test_create_instance
    testsdk = LocationSharingSDK.test(nil, nil)
    ent = testsdk.History(nil)
    assert !ent.nil?
  end

  # Feature #4: the entity stream(action, ...) method runs the op pipeline and
  # returns an Enumerator over result items. With the streaming feature active
  # it yields the feature's incremental output; otherwise it falls back to the
  # materialised list so stream always yields.
  def test_stream
    seed = {
      "entity" => {
        "history" => {
          "s1" => { "id" => "s1" },
          "s2" => { "id" => "s2" },
          "s3" => { "id" => "s3" },
        },
      },
    }

    # Fallback: streaming inactive -> yields the materialised list items.
    base = LocationSharingSDK.test(seed, nil)
    seen = base.History(nil).stream("list", nil, nil).to_a
    assert_equal 3, seen.length

    # Inbound: streaming active -> yields each item from the feature.
    cfg = LocationSharingConfig.make_config
    if cfg["feature"].is_a?(Hash) && cfg["feature"].key?("streaming")
      sdk = LocationSharingSDK.test(seed, { "feature" => { "streaming" => { "active" => true } } })
      got = []
      sdk.History(nil).stream("list", nil, nil).each do |item|
        if item.is_a?(Array)
          got.concat(item)
        else
          got << item
        end
      end
      assert_equal 3, got.length
    end
  end

  def test_basic_flow
    setup = history_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "list", "remove"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "history." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_HISTORY_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    history_ref01_ent = client.History(nil)
    history_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.history"), "history_ref01"))

    history_ref01_data_result = history_ref01_ent.create(history_ref01_data, nil)
    history_ref01_data = Helpers.to_map(history_ref01_data_result)
    assert !history_ref01_data.nil?
    assert !history_ref01_data["id"].nil?

    # LIST
    history_ref01_match = {}

    history_ref01_list_result = history_ref01_ent.list(history_ref01_match, nil)
    assert history_ref01_list_result.is_a?(Array)

    found_item = Vs.select(
      Runner.entity_list_to_data(history_ref01_list_result),
      { "id" => history_ref01_data["id"] })
    assert !Vs.isempty(found_item)

    # REMOVE
    history_ref01_match_rm0 = {
      "id" => history_ref01_data["id"],
    }
    history_ref01_ent.remove(history_ref01_match_rm0, nil)

    # LIST
    history_ref01_match_rt0 = {}

    history_ref01_list_rt0_result = history_ref01_ent.list(history_ref01_match_rt0, nil)
    assert history_ref01_list_rt0_result.is_a?(Array)

    not_found_item = Vs.select(
      Runner.entity_list_to_data(history_ref01_list_rt0_result),
      { "id" => history_ref01_data["id"] })
    assert Vs.isempty(not_found_item)

  end
end

def history_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "history", "HistoryTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = LocationSharingSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["history01", "history02", "history03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["LOCATIONSHARING_TEST_HISTORY_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "LOCATIONSHARING_TEST_HISTORY_ENTID" => idmap,
    "LOCATIONSHARING_TEST_LIVE" => "FALSE",
    "LOCATIONSHARING_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["LOCATIONSHARING_TEST_HISTORY_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["LOCATIONSHARING_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
      },
      extra || {},
    ])
    client = LocationSharingSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["LOCATIONSHARING_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["LOCATIONSHARING_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
