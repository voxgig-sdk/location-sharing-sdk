# LocationSharing SDK configuration


def make_config():
    return {
        "main": {
            "name": "LocationSharing",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
      },
        },
        "options": {
            "base": "https://mcinenews.net/LAT",
            "auth": {
                "prefix": "Bearer",
            },
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
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "city",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "country",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "postal_code",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "state",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 4,
          },
          {
            "name": "street",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 5,
          },
        ],
        "name": "address",
        "op": {
          "load": {
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
                      "active": True,
                    },
                    {
                      "kind": "query",
                      "name": "lon",
                      "orig": "lon",
                      "reqd": True,
                      "type": "`$NUMBER`",
                      "active": True,
                    },
                  ],
                },
                "method": "GET",
                "orig": "/geocode/reverse",
                "parts": [
                  "geocode",
                  "reverse",
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
                "active": True,
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "building_check": {
        "fields": [
          {
            "name": "distance",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "highlighted",
            "req": False,
            "type": "`$BOOLEAN`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "id",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 3,
          },
        ],
        "name": "building_check",
        "op": {
          "list": {
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
                      "active": True,
                    },
                    {
                      "kind": "query",
                      "name": "lon",
                      "orig": "lon",
                      "reqd": True,
                      "type": "`$NUMBER`",
                      "active": True,
                    },
                    {
                      "example": 40,
                      "kind": "query",
                      "name": "radius",
                      "orig": "radius",
                      "reqd": False,
                      "type": "`$INTEGER`",
                      "active": True,
                    },
                    {
                      "example": 3,
                      "kind": "query",
                      "name": "top",
                      "orig": "top",
                      "reqd": False,
                      "type": "`$INTEGER`",
                      "active": True,
                    },
                  ],
                },
                "method": "GET",
                "orig": "/buildings/check",
                "parts": [
                  "buildings",
                  "check",
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
                  "res": "`body`",
                },
                "active": True,
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "list",
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
            "name": "load",
            "points": [
              {
                "method": "GET",
                "orig": "/export/csv",
                "parts": [
                  "export",
                  "csv",
                ],
                "select": {
                  "$action": "csv",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "index$": 0,
              },
              {
                "method": "GET",
                "orig": "/export/geojson",
                "parts": [
                  "export",
                  "geojson",
                ],
                "select": {
                  "$action": "geojson",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "index$": 1,
              },
              {
                "method": "GET",
                "orig": "/export/kml",
                "parts": [
                  "export",
                  "kml",
                ],
                "select": {
                  "$action": "kml",
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "index$": 2,
              },
            ],
            "input": "data",
            "key$": "load",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "history": {
        "fields": [
          {
            "name": "accuracy",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "address",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "id",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 4,
          },
          {
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 5,
          },
          {
            "name": "timestamp",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 6,
          },
        ],
        "name": "history",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/history",
                "parts": [
                  "history",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
          },
          "list": {
            "name": "list",
            "points": [
              {
                "method": "GET",
                "orig": "/history",
                "parts": [
                  "history",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "list",
          },
          "remove": {
            "name": "remove",
            "points": [
              {
                "method": "DELETE",
                "orig": "/history",
                "parts": [
                  "history",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "remove",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "location": {
        "fields": [
          {
            "name": "accuracy",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "address",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "timestamp",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 4,
          },
        ],
        "name": "location",
        "op": {
          "load": {
            "name": "load",
            "points": [
              {
                "method": "GET",
                "orig": "/location",
                "parts": [
                  "location",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "load",
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
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "created_at",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "id",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 4,
          },
          {
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 5,
          },
        ],
        "name": "marker",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/markers",
                "parts": [
                  "markers",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
          },
          "list": {
            "name": "list",
            "points": [
              {
                "method": "GET",
                "orig": "/markers",
                "parts": [
                  "markers",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "list",
          },
          "remove": {
            "name": "remove",
            "points": [
              {
                "method": "DELETE",
                "orig": "/markers",
                "parts": [
                  "markers",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "remove",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "repeat": {
        "fields": [
          {
            "name": "accuracy",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "best_accuracy",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "count",
            "req": True,
            "type": "`$INTEGER`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "interval",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "latitude",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 4,
          },
          {
            "name": "longitude",
            "req": False,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 5,
          },
          {
            "name": "measurement",
            "req": False,
            "type": "`$ARRAY`",
            "active": True,
            "index$": 6,
          },
          {
            "name": "result_type",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 7,
          },
        ],
        "name": "repeat",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/measurement/repeat",
                "parts": [
                  "measurement",
                  "repeat",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
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
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "name",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "type",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 4,
          },
        ],
        "name": "search",
        "op": {
          "list": {
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
                      "active": True,
                    },
                  ],
                },
                "method": "GET",
                "orig": "/search",
                "parts": [
                  "search",
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
                "active": True,
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "list",
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
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "expires_at",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "latitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 2,
          },
          {
            "name": "longitude",
            "req": True,
            "type": "`$NUMBER`",
            "active": True,
            "index$": 3,
          },
          {
            "name": "name",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 4,
          },
          {
            "name": "qr_code",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 5,
          },
          {
            "name": "share_link",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 6,
          },
        ],
        "name": "share",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/share",
                "parts": [
                  "share",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
