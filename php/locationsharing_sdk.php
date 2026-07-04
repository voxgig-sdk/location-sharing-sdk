<?php
declare(strict_types=1);

// LocationSharing SDK

require_once __DIR__ . '/utility/struct/Struct.php';
require_once __DIR__ . '/core/UtilityType.php';
require_once __DIR__ . '/core/Spec.php';
require_once __DIR__ . '/core/Helpers.php';

// Load utility registration
require_once __DIR__ . '/utility/Register.php';

// Load config and features
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/features.php';

use Voxgig\Struct\Struct;

class LocationSharingSDK
{
    public string $mode;
    public array $features;
    public ?array $options;

    private $_utility;
    private $_rootctx;

    public function __construct(array $options = [])
    {
        $this->mode = "live";
        $this->features = [];
        $this->options = null;

        $utility = new LocationSharingUtility();
        $this->_utility = $utility;

        $config = LocationSharingConfig::make_config();

        $this->_rootctx = ($utility->make_context)([
            "client" => $this,
            "utility" => $utility,
            "config" => $config,
            "options" => $options ?? [],
            "shared" => [],
        ], null);

        $this->options = ($utility->make_options)($this->_rootctx);

        if (Struct::getpath($this->options, "feature.test.active") === true) {
            $this->mode = "test";
        }

        $this->_rootctx->options = $this->options;

        // Add features from config.
        $feature_opts = LocationSharingHelpers::to_map(Struct::getprop($this->options, "feature"));
        if ($feature_opts) {
            $items = Struct::items($feature_opts);
            if ($items) {
                foreach ($items as $item) {
                    $fname = $item[0];
                    $fopts = LocationSharingHelpers::to_map($item[1]);
                    if ($fopts && isset($fopts["active"]) && $fopts["active"] === true) {
                        ($utility->feature_add)($this->_rootctx, LocationSharingFeatures::make_feature($fname));
                    }
                }
            }
        }

        // Add extension features.
        $extend_val = Struct::getprop($this->options, "extend");
        if (is_array($extend_val)) {
            foreach ($extend_val as $f) {
                if (is_object($f) && method_exists($f, 'get_name')) {
                    ($utility->feature_add)($this->_rootctx, $f);
                }
            }
        }

        // Initialize features.
        foreach ($this->features as $f) {
            ($utility->feature_init)($this->_rootctx, $f);
        }

        ($utility->feature_hook)($this->_rootctx, "PostConstruct");
    }

    public function options_map(): array
    {
        $out = Struct::clone($this->options);
        return is_array($out) ? $out : [];
    }

    public function get_utility()
    {
        return LocationSharingUtility::copy($this->_utility);
    }

    public function get_root_ctx()
    {
        return $this->_rootctx;
    }

    public function prepare(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;
        $fetchargs = $fetchargs ?? [];

        $ctrl = LocationSharingHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "prepare",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $opts = $this->options;
        $path = Struct::getprop($fetchargs, "path") ?? "";
        $path = is_string($path) ? $path : "";
        $method_val = Struct::getprop($fetchargs, "method") ?? "GET";
        $method_val = is_string($method_val) ? $method_val : "GET";
        $params = LocationSharingHelpers::to_map(Struct::getprop($fetchargs, "params")) ?? [];
        $query = LocationSharingHelpers::to_map(Struct::getprop($fetchargs, "query")) ?? [];
        $headers = ($utility->prepare_headers)($ctx);

        $base = Struct::getprop($opts, "base") ?? "";
        $base = is_string($base) ? $base : "";
        $prefix = Struct::getprop($opts, "prefix") ?? "";
        $prefix = is_string($prefix) ? $prefix : "";
        $suffix = Struct::getprop($opts, "suffix") ?? "";
        $suffix = is_string($suffix) ? $suffix : "";

        $ctx->spec = new LocationSharingSpec([
            "base" => $base, "prefix" => $prefix, "suffix" => $suffix,
            "path" => $path, "method" => $method_val,
            "params" => $params, "query" => $query, "headers" => $headers,
            "body" => Struct::getprop($fetchargs, "body"),
            "step" => "start",
        ]);

        // Merge user-provided headers.
        $uh = Struct::getprop($fetchargs, "headers");
        if (is_array($uh)) {
            foreach ($uh as $k => $v) {
                $ctx->spec->headers[$k] = $v;
            }
        }

        [$_, $err] = ($utility->prepare_auth)($ctx);
        if ($err) {
            return ($utility->make_error)($ctx, $err);
        }

        [$fetchdef, $fd_err] = ($utility->make_fetch_def)($ctx);
        if ($fd_err) {
            return ($utility->make_error)($ctx, $fd_err);
        }
        return $fetchdef;
    }

    public function direct(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;

        // direct() is the raw-HTTP escape hatch: it never throws, it returns
        // an {ok, err, ...} dict. prepare() now raises on error, so catch it
        // and surface the failure through the dict instead.
        try {
            $fetchdef = $this->prepare($fetchargs);
        } catch (\Throwable $err) {
            return ["ok" => false, "err" => $err];
        }

        $fetchargs = $fetchargs ?? [];
        $ctrl = LocationSharingHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "direct",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $url = $fetchdef["url"] ?? "";
        [$fetched, $fetch_err] = ($utility->fetcher)($ctx, $url, $fetchdef);

        if ($fetch_err) {
            return ["ok" => false, "err" => $fetch_err];
        }

        if ($fetched === null) {
            return [
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ];
        }

        if (is_array($fetched)) {
            $status = LocationSharingHelpers::to_int(Struct::getprop($fetched, "status"));
            $headers = Struct::getprop($fetched, "headers") ?? [];

            // No-body responses (204, 304) and explicit zero content-length
            // must skip JSON parsing — calling json() on an empty body errors.
            $content_length = is_array($headers) ? ($headers["content-length"] ?? null) : null;
            $no_body = $status === 204 || $status === 304 || (string)$content_length === "0";

            $json_data = null;
            if (!$no_body) {
                $jf = Struct::getprop($fetched, "json");
                if (is_callable($jf)) {
                    try {
                        $json_data = $jf();
                    } catch (\Throwable $e) {
                        // Non-JSON body — leave data null but keep status/ok.
                        $json_data = null;
                    }
                }
            }

            return [
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ];
        }

        return [
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ];
    }


    private $_address = null;

    // Canonical facade: $client->Address()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->address()
    // resolves here too.
    public function Address($data = null)
    {
        require_once __DIR__ . '/entity/address_entity.php';
        if ($data === null) {
            if ($this->_address === null) {
                $this->_address = new AddressEntity($this, null);
            }
            return $this->_address;
        }
        return new AddressEntity($this, $data);
    }


    private $_building_check = null;

    // Canonical facade: $client->BuildingCheck()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->building_check()
    // resolves here too.
    public function BuildingCheck($data = null)
    {
        require_once __DIR__ . '/entity/building_check_entity.php';
        if ($data === null) {
            if ($this->_building_check === null) {
                $this->_building_check = new BuildingCheckEntity($this, null);
            }
            return $this->_building_check;
        }
        return new BuildingCheckEntity($this, $data);
    }


    private $_export = null;

    // Canonical facade: $client->Export()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->export()
    // resolves here too.
    public function Export($data = null)
    {
        require_once __DIR__ . '/entity/export_entity.php';
        if ($data === null) {
            if ($this->_export === null) {
                $this->_export = new ExportEntity($this, null);
            }
            return $this->_export;
        }
        return new ExportEntity($this, $data);
    }


    private $_history = null;

    // Canonical facade: $client->History()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->history()
    // resolves here too.
    public function History($data = null)
    {
        require_once __DIR__ . '/entity/history_entity.php';
        if ($data === null) {
            if ($this->_history === null) {
                $this->_history = new HistoryEntity($this, null);
            }
            return $this->_history;
        }
        return new HistoryEntity($this, $data);
    }


    private $_location = null;

    // Canonical facade: $client->Location()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->location()
    // resolves here too.
    public function Location($data = null)
    {
        require_once __DIR__ . '/entity/location_entity.php';
        if ($data === null) {
            if ($this->_location === null) {
                $this->_location = new LocationEntity($this, null);
            }
            return $this->_location;
        }
        return new LocationEntity($this, $data);
    }


    private $_marker = null;

    // Canonical facade: $client->Marker()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->marker()
    // resolves here too.
    public function Marker($data = null)
    {
        require_once __DIR__ . '/entity/marker_entity.php';
        if ($data === null) {
            if ($this->_marker === null) {
                $this->_marker = new MarkerEntity($this, null);
            }
            return $this->_marker;
        }
        return new MarkerEntity($this, $data);
    }


    private $_repeat = null;

    // Canonical facade: $client->Repeat()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->repeat()
    // resolves here too.
    public function Repeat($data = null)
    {
        require_once __DIR__ . '/entity/repeat_entity.php';
        if ($data === null) {
            if ($this->_repeat === null) {
                $this->_repeat = new RepeatEntity($this, null);
            }
            return $this->_repeat;
        }
        return new RepeatEntity($this, $data);
    }


    private $_search = null;

    // Canonical facade: $client->Search()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->search()
    // resolves here too.
    public function Search($data = null)
    {
        require_once __DIR__ . '/entity/search_entity.php';
        if ($data === null) {
            if ($this->_search === null) {
                $this->_search = new SearchEntity($this, null);
            }
            return $this->_search;
        }
        return new SearchEntity($this, $data);
    }


    private $_share = null;

    // Canonical facade: $client->Share()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->share()
    // resolves here too.
    public function Share($data = null)
    {
        require_once __DIR__ . '/entity/share_entity.php';
        if ($data === null) {
            if ($this->_share === null) {
                $this->_share = new ShareEntity($this, null);
            }
            return $this->_share;
        }
        return new ShareEntity($this, $data);
    }



    public static function test(?array $testopts = null, ?array $sdkopts = null): self
    {
        $sdkopts = $sdkopts ?? [];
        $sdkopts = Struct::clone($sdkopts);
        $sdkopts = is_array($sdkopts) ? $sdkopts : [];

        $testopts = $testopts ?? [];
        $testopts = Struct::clone($testopts);
        $testopts = is_array($testopts) ? $testopts : [];
        $testopts["active"] = true;

        if (!isset($sdkopts["feature"])) {
            $sdkopts["feature"] = [];
        }
        $sdkopts["feature"]["test"] = $testopts;

        $sdk = new LocationSharingSDK($sdkopts);
        $sdk->mode = "test";
        return $sdk;
    }
}
