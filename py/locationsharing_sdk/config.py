# LocationSharing SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "LocationSharing",
            "slug": "location-sharing",
            "version": "0.0.1",
            "target": "py",
        },
        "feature": {
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "retry": {
        "options": {
          "active": False,
          "factor": 2,
          "maxDelay": 2000,
          "minDelay": 50,
          "retries": 2,
          "statuses": [
            408,
            425,
            429,
            500,
            502,
            503,
            504,
          ],
        },
        "optspec": {
          "jitter": "`$BOOLEAN`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "test": {
        "options": {
          "active": False,
        },
        "optspec": {
          "entity": "`$MAP`",
          "net": "`$MAP`",
        },
        "strict": False,
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "optspec": {
          "clearTimer": "`$FUNCTION`",
          "setTimer": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
        },
        "options": {
            "base": "https://mcinenews.net/LAT",
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "address": {},
                "building_check": {},
                "export": {},
                "history": {},
                "location": {},
                "marker": {},
                "repeat": {},
                "search": {},
                "share": {},
            },
        },
        "entity": {
      "address": {
        "fields": [
          {
            "name": "address",
            "req": True,
            "short": "Full formatted address",
            "type": "`$STRING`",
          },
          {
            "name": "city",
            "short": "City name",
            "type": "`$STRING`",
          },
          {
            "name": "country",
            "short": "Country name",
            "type": "`$STRING`",
          },
          {
            "name": "postalCode",
            "short": "Postal or ZIP code",
            "type": "`$STRING`",
          },
          {
            "name": "state",
            "short": "State or province",
            "type": "`$STRING`",
          },
          {
            "name": "street",
            "short": "Street name",
            "type": "`$STRING`",
          },
        ],
        "name": "address",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "args": {
                  "query": [
                    {
                      "kind": "query",
                      "name": "lat",
                      "orig": "lat",
                      "reqd": True,
                      "type": "`$NUMBER`",
                    },
                    {
                      "kind": "query",
                      "name": "lon",
                      "orig": "lon",
                      "reqd": True,
                      "type": "`$NUMBER`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/geocode/reverse",
                "segments": [
                  {
                    "lit": "geocode",
                  },
                  {
                    "lit": "reverse",
                  },
                ],
                "select": {
                  "exist": [
                    "lat",
                    "lon",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "geocode",
                  "reverse",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "building_check": {
        "fields": [
          {
            "format": "float",
            "name": "distance",
            "short": "Distance to building edge in meters",
            "type": "`$NUMBER`",
          },
          {
            "name": "highlighted",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "id",
            "type": "`$STRING`",
          },
          {
            "name": "name",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
        },
        "name": "building_check",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "args": {
                  "query": [
                    {
                      "kind": "query",
                      "name": "lat",
                      "orig": "lat",
                      "reqd": True,
                      "type": "`$NUMBER`",
                    },
                    {
                      "kind": "query",
                      "name": "lon",
                      "orig": "lon",
                      "reqd": True,
                      "type": "`$NUMBER`",
                    },
                    {
                      "example": 40,
                      "kind": "query",
                      "name": "radius",
                      "orig": "radius",
                      "type": "`$INTEGER`",
                    },
                    {
                      "example": 3,
                      "kind": "query",
                      "name": "top",
                      "orig": "top",
                      "type": "`$INTEGER`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/buildings/check",
                "segments": [
                  {
                    "lit": "buildings",
                  },
                  {
                    "lit": "check",
                  },
                ],
                "select": {
                  "exist": [
                    "lat",
                    "lon",
                    "radius",
                    "top",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.buildings`",
                },
                "parts": [
                  "buildings",
                  "check",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "export": {
        "fields": [],
        "name": "export",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/export/csv",
                "segments": [
                  {
                    "lit": "export",
                  },
                  {
                    "lit": "csv",
                  },
                ],
                "select": {
                  "$action": "csv",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "export",
                  "csv",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/export/geojson",
                "segments": [
                  {
                    "lit": "export",
                  },
                  {
                    "lit": "geojson",
                  },
                ],
                "select": {
                  "$action": "geojson",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "export",
                  "geojson",
                ],
              },
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/export/kml",
                "segments": [
                  {
                    "lit": "export",
                  },
                  {
                    "lit": "kml",
                  },
                ],
                "select": {
                  "$action": "kml",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "export",
                  "kml",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "history": {
        "fields": [
          {
            "format": "float",
            "name": "accuracy",
            "type": "`$NUMBER`",
          },
          {
            "name": "address",
            "type": "`$STRING`",
          },
          {
            "name": "id",
            "req": True,
            "type": "`$STRING`",
          },
          {
            "format": "double",
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "name": "name",
            "type": "`$STRING`",
          },
          {
            "format": "date-time",
            "name": "timestamp",
            "req": True,
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
        },
        "name": "history",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/history",
                "segments": [
                  {
                    "lit": "history",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "history",
                ],
              },
            ],
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/history",
                "segments": [
                  {
                    "lit": "history",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "history",
                ],
              },
            ],
          },
          "remove": {
            "input": "data",
            "name": "remove",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "DELETE",
                "orig": "/history",
                "segments": [
                  {
                    "lit": "history",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "history",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "location": {
        "fields": [
          {
            "format": "float",
            "name": "accuracy",
            "req": True,
            "short": "Accuracy in meters",
            "type": "`$NUMBER`",
          },
          {
            "name": "address",
            "short": "Human-readable address",
            "type": "`$STRING`",
          },
          {
            "format": "double",
            "name": "latitude",
            "req": True,
            "short": "Latitude coordinate",
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "longitude",
            "req": True,
            "short": "Longitude coordinate",
            "type": "`$NUMBER`",
          },
          {
            "format": "date-time",
            "name": "timestamp",
            "short": "Timestamp of the location fix",
            "type": "`$STRING`",
          },
        ],
        "name": "location",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/location",
                "segments": [
                  {
                    "lit": "location",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "location",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "marker": {
        "fields": [
          {
            "name": "address",
            "type": "`$STRING`",
          },
          {
            "format": "date-time",
            "name": "createdAt",
            "type": "`$STRING`",
          },
          {
            "name": "id",
            "req": True,
            "short": "Unique marker identifier",
            "type": "`$STRING`",
          },
          {
            "format": "double",
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "name": "name",
            "short": "Name or label for the marker",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
        },
        "name": "marker",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/markers",
                "segments": [
                  {
                    "lit": "markers",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "markers",
                ],
              },
            ],
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "GET",
                "orig": "/markers",
                "segments": [
                  {
                    "lit": "markers",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "markers",
                ],
              },
            ],
          },
          "remove": {
            "input": "data",
            "name": "remove",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "DELETE",
                "orig": "/markers",
                "segments": [
                  {
                    "lit": "markers",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "markers",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "repeat": {
        "fields": [
          {
            "format": "float",
            "name": "accuracy",
            "type": "`$NUMBER`",
          },
          {
            "format": "float",
            "name": "bestAccuracy",
            "short": "Best (lowest) accuracy value from all measurements",
            "type": "`$NUMBER`",
          },
          {
            "name": "count",
            "req": True,
            "short": "Number of measurements to take (recommended 8-15)",
            "type": "`$INTEGER`",
          },
          {
            "format": "float",
            "name": "interval",
            "req": True,
            "short": "Interval between measurements in seconds (recommended 0.8-2.0)",
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "latitude",
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "longitude",
            "type": "`$NUMBER`",
          },
          {
            "name": "measurements",
            "type": "`$ARRAY`",
          },
          {
            "name": "resultType",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "short": "Type of result to return",
            "type": "`$STRING`",
          },
        ],
        "name": "repeat",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/measurement/repeat",
                "segments": [
                  {
                    "lit": "measurement",
                  },
                  {
                    "lit": "repeat",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "measurement",
                  "repeat",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "search": {
        "fields": [
          {
            "name": "address",
            "short": "Full address",
            "type": "`$STRING`",
          },
          {
            "format": "double",
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "name": "name",
            "req": True,
            "short": "Name of the location",
            "type": "`$STRING`",
          },
          {
            "name": "type",
            "short": "Type of location (e.g., building, park, street)",
            "type": "`$STRING`",
          },
        ],
        "name": "search",
        "op": {
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "args": {
                  "query": [
                    {
                      "kind": "query",
                      "name": "q",
                      "orig": "q",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/search",
                "segments": [
                  {
                    "lit": "search",
                  },
                ],
                "select": {
                  "exist": [
                    "q",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "search",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "share": {
        "fields": [
          {
            "name": "address",
            "short": "Address of the location",
            "type": "`$STRING`",
          },
          {
            "format": "date-time",
            "name": "expiresAt",
            "short": "Expiration time of the share link",
            "type": "`$STRING`",
          },
          {
            "format": "double",
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "format": "double",
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
          },
          {
            "name": "name",
            "short": "Optional name for the location",
            "type": "`$STRING`",
          },
          {
            "format": "uri",
            "name": "qrCode",
            "short": "URL to QR code image",
            "type": "`$STRING`",
          },
          {
            "format": "uri",
            "name": "shareLink",
            "req": True,
            "short": "Shareable URL for the location",
            "type": "`$STRING`",
          },
        ],
        "name": "share",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "args": {},
                "kind": "http",
                "method": "POST",
                "orig": "/share",
                "segments": [
                  {
                    "lit": "share",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "share",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
