# LocationSharing SDK configuration

module LocationSharingConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "LocationSharing",
        "slug" => "location-sharing",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "ratelimit" => {
          "options" => {
            "active" => false,
            "burst" => 5,
            "rate" => 5,
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "retry" => {
          "options" => {
            "active" => false,
            "factor" => 2,
            "maxDelay" => 2000,
            "minDelay" => 50,
            "retries" => 2,
            "statuses" => [
              408,
              425,
              429,
              500,
              502,
              503,
              504,
            ],
          },
          "optspec" => {
            "jitter" => "`$BOOLEAN`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "test" => {
          "options" => {
            "active" => false,
          },
          "optspec" => {
            "entity" => "`$MAP`",
            "net" => "`$MAP`",
          },
          "strict" => false,
          "transport" => "base",
        },
        "timeout" => {
          "options" => {
            "active" => false,
            "ms" => 30000,
          },
          "optspec" => {
            "clearTimer" => "`$FUNCTION`",
            "setTimer" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
      },
      "options" => {
        "base" => "https://mcinenews.net/LAT",
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "address" => {},
          "building_check" => {},
          "export" => {},
          "history" => {},
          "location" => {},
          "marker" => {},
          "repeat" => {},
          "search" => {},
          "share" => {},
        },
      },
      "entity" => {
        "address" => {
          "fields" => [
            {
              "name" => "address",
              "req" => true,
              "short" => "Full formatted address",
              "type" => "`$STRING`",
            },
            {
              "name" => "city",
              "short" => "City name",
              "type" => "`$STRING`",
            },
            {
              "name" => "country",
              "short" => "Country name",
              "type" => "`$STRING`",
            },
            {
              "name" => "postalCode",
              "short" => "Postal or ZIP code",
              "type" => "`$STRING`",
            },
            {
              "name" => "state",
              "short" => "State or province",
              "type" => "`$STRING`",
            },
            {
              "name" => "street",
              "short" => "Street name",
              "type" => "`$STRING`",
            },
          ],
          "name" => "address",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "lat",
                        "orig" => "lat",
                        "reqd" => true,
                        "type" => "`$NUMBER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "lon",
                        "orig" => "lon",
                        "reqd" => true,
                        "type" => "`$NUMBER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/geocode/reverse",
                  "segments" => [
                    {
                      "lit" => "geocode",
                    },
                    {
                      "lit" => "reverse",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "lat",
                      "lon",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "geocode",
                    "reverse",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "building_check" => {
          "fields" => [
            {
              "format" => "float",
              "name" => "distance",
              "short" => "Distance to building edge in meters",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "highlighted",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "type" => "`$STRING`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "building_check",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "lat",
                        "orig" => "lat",
                        "reqd" => true,
                        "type" => "`$NUMBER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "lon",
                        "orig" => "lon",
                        "reqd" => true,
                        "type" => "`$NUMBER`",
                      },
                      {
                        "example" => 40,
                        "kind" => "query",
                        "name" => "radius",
                        "orig" => "radius",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 3,
                        "kind" => "query",
                        "name" => "top",
                        "orig" => "top",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/buildings/check",
                  "segments" => [
                    {
                      "lit" => "buildings",
                    },
                    {
                      "lit" => "check",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "lat",
                      "lon",
                      "radius",
                      "top",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.buildings`",
                  },
                  "parts" => [
                    "buildings",
                    "check",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "export" => {
          "fields" => [],
          "name" => "export",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/export/csv",
                  "segments" => [
                    {
                      "lit" => "export",
                    },
                    {
                      "lit" => "csv",
                    },
                  ],
                  "select" => {
                    "$action" => "csv",
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "export",
                    "csv",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/export/geojson",
                  "segments" => [
                    {
                      "lit" => "export",
                    },
                    {
                      "lit" => "geojson",
                    },
                  ],
                  "select" => {
                    "$action" => "geojson",
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "export",
                    "geojson",
                  ],
                },
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/export/kml",
                  "segments" => [
                    {
                      "lit" => "export",
                    },
                    {
                      "lit" => "kml",
                    },
                  ],
                  "select" => {
                    "$action" => "kml",
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "export",
                    "kml",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "history" => {
          "fields" => [
            {
              "format" => "float",
              "name" => "accuracy",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "address",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "format" => "double",
              "name" => "latitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "longitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "name" => "name",
              "type" => "`$STRING`",
            },
            {
              "format" => "date-time",
              "name" => "timestamp",
              "req" => true,
              "type" => "`$STRING`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "history",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/history",
                  "segments" => [
                    {
                      "lit" => "history",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "history",
                  ],
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/history",
                  "segments" => [
                    {
                      "lit" => "history",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "history",
                  ],
                },
              ],
            },
            "remove" => {
              "input" => "data",
              "name" => "remove",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "DELETE",
                  "orig" => "/history",
                  "segments" => [
                    {
                      "lit" => "history",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "history",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "location" => {
          "fields" => [
            {
              "format" => "float",
              "name" => "accuracy",
              "req" => true,
              "short" => "Accuracy in meters",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "address",
              "short" => "Human-readable address",
              "type" => "`$STRING`",
            },
            {
              "format" => "double",
              "name" => "latitude",
              "req" => true,
              "short" => "Latitude coordinate",
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "longitude",
              "req" => true,
              "short" => "Longitude coordinate",
              "type" => "`$NUMBER`",
            },
            {
              "format" => "date-time",
              "name" => "timestamp",
              "short" => "Timestamp of the location fix",
              "type" => "`$STRING`",
            },
          ],
          "name" => "location",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/location",
                  "segments" => [
                    {
                      "lit" => "location",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "location",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "marker" => {
          "fields" => [
            {
              "name" => "address",
              "type" => "`$STRING`",
            },
            {
              "format" => "date-time",
              "name" => "createdAt",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "req" => true,
              "short" => "Unique marker identifier",
              "type" => "`$STRING`",
            },
            {
              "format" => "double",
              "name" => "latitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "longitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "name" => "name",
              "short" => "Name or label for the marker",
              "type" => "`$STRING`",
            },
          ],
          "id" => {
            "field" => "id",
            "name" => "id",
          },
          "name" => "marker",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/markers",
                  "segments" => [
                    {
                      "lit" => "markers",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "markers",
                  ],
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/markers",
                  "segments" => [
                    {
                      "lit" => "markers",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "markers",
                  ],
                },
              ],
            },
            "remove" => {
              "input" => "data",
              "name" => "remove",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "DELETE",
                  "orig" => "/markers",
                  "segments" => [
                    {
                      "lit" => "markers",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "markers",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "repeat" => {
          "fields" => [
            {
              "format" => "float",
              "name" => "accuracy",
              "type" => "`$NUMBER`",
            },
            {
              "format" => "float",
              "name" => "bestAccuracy",
              "short" => "Best (lowest) accuracy value from all measurements",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "count",
              "req" => true,
              "short" => "Number of measurements to take (recommended 8-15)",
              "type" => "`$INTEGER`",
            },
            {
              "format" => "float",
              "name" => "interval",
              "req" => true,
              "short" => "Interval between measurements in seconds (recommended 0.8-2.0)",
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "latitude",
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "longitude",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "measurements",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "resultType",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "short" => "Type of result to return",
              "type" => "`$STRING`",
            },
          ],
          "name" => "repeat",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/measurement/repeat",
                  "segments" => [
                    {
                      "lit" => "measurement",
                    },
                    {
                      "lit" => "repeat",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "measurement",
                    "repeat",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "search" => {
          "fields" => [
            {
              "name" => "address",
              "short" => "Full address",
              "type" => "`$STRING`",
            },
            {
              "format" => "double",
              "name" => "latitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "longitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "name" => "name",
              "req" => true,
              "short" => "Name of the location",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Type of location (e.g., building, park, street)",
              "type" => "`$STRING`",
            },
          ],
          "name" => "search",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "q",
                        "orig" => "q",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/search",
                  "segments" => [
                    {
                      "lit" => "search",
                    },
                  ],
                  "select" => {
                    "exist" => [
                      "q",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "search",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "share" => {
          "fields" => [
            {
              "name" => "address",
              "short" => "Address of the location",
              "type" => "`$STRING`",
            },
            {
              "format" => "date-time",
              "name" => "expiresAt",
              "short" => "Expiration time of the share link",
              "type" => "`$STRING`",
            },
            {
              "format" => "double",
              "name" => "latitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "format" => "double",
              "name" => "longitude",
              "req" => true,
              "type" => "`$NUMBER`",
            },
            {
              "name" => "name",
              "short" => "Optional name for the location",
              "type" => "`$STRING`",
            },
            {
              "format" => "uri",
              "name" => "qrCode",
              "short" => "URL to QR code image",
              "type" => "`$STRING`",
            },
            {
              "format" => "uri",
              "name" => "shareLink",
              "req" => true,
              "short" => "Shareable URL for the location",
              "type" => "`$STRING`",
            },
          ],
          "name" => "share",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/share",
                  "segments" => [
                    {
                      "lit" => "share",
                    },
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "parts" => [
                    "share",
                  ],
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    LocationSharingFeatures.make_feature(name)
  end
end
