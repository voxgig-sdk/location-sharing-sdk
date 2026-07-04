# Repeat entity test

require "minitest/autorun"
require "json"
require_relative "../LocationSharing_sdk"
require_relative "runner"

class RepeatEntityTest < Minitest::Test
  def test_create_instance
    testsdk = LocationSharingSDK.test(nil, nil)
    ent = testsdk.Repeat(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = repeat_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "repeat." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set LOCATIONSHARING_TEST_REPEAT_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    repeat_ref01_ent = client.Repeat(nil)
    repeat_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.repeat"), "repeat_ref01"))

    repeat_ref01_data_result = repeat_ref01_ent.create(repeat_ref01_data, nil)
    repeat_ref01_data = Helpers.to_map(repeat_ref01_data_result)
    assert !repeat_ref01_data.nil?

  end
end

def repeat_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "repeat", "RepeatTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = LocationSharingSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["repeat01", "repeat02", "repeat03"],
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
  entid_env_raw = ENV["LOCATIONSHARING_TEST_REPEAT_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "LOCATIONSHARING_TEST_REPEAT_ENTID" => idmap,
    "LOCATIONSHARING_TEST_LIVE" => "FALSE",
    "LOCATIONSHARING_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["LOCATIONSHARING_TEST_REPEAT_ENTID"])
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
