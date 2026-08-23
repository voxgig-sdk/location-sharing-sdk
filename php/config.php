<?php
declare(strict_types=1);

// LocationSharing SDK configuration

class LocationSharingConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "LocationSharing",
                "slug" => "location-sharing",
                "version" => "0.0.1",
                "target" => "php",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://mcinenews.net/LAT",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "address" => [],
                    "building_check" => [],
                    "export" => [],
                    "history" => [],
                    "location" => [],
                    "marker" => [],
                    "repeat" => [],
                    "search" => [],
                    "share" => [],
                ],
            ],
            "entity" => [
        'address' => [
          'fields' => [
            [
              'name' => 'address',
              'req' => true,
              'short' => 'Full formatted address',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'city',
              'short' => 'City name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'country',
              'short' => 'Country name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'postalCode',
              'short' => 'Postal or ZIP code',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'state',
              'short' => 'State or province',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'street',
              'short' => 'Street name',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'address',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'lat',
                        'orig' => 'lat',
                        'reqd' => true,
                        'type' => '`$NUMBER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'lon',
                        'orig' => 'lon',
                        'reqd' => true,
                        'type' => '`$NUMBER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/geocode/reverse',
                  'parts' => [
                    'geocode',
                    'reverse',
                  ],
                  'select' => [
                    'exist' => [
                      'lat',
                      'lon',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'building_check' => [
          'fields' => [
            [
              'name' => 'distance',
              'short' => 'Distance to building edge in meters',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'highlighted',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'building_check',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'lat',
                        'orig' => 'lat',
                        'reqd' => true,
                        'type' => '`$NUMBER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'lon',
                        'orig' => 'lon',
                        'reqd' => true,
                        'type' => '`$NUMBER`',
                      ],
                      [
                        'example' => 40,
                        'kind' => 'query',
                        'name' => 'radius',
                        'orig' => 'radius',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 3,
                        'kind' => 'query',
                        'name' => 'top',
                        'orig' => 'top',
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/buildings/check',
                  'parts' => [
                    'buildings',
                    'check',
                  ],
                  'select' => [
                    'exist' => [
                      'lat',
                      'lon',
                      'radius',
                      'top',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.buildings`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'export' => [
          'fields' => [],
          'name' => 'export',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/export/csv',
                  'parts' => [
                    'export',
                    'csv',
                  ],
                  'select' => [
                    '$action' => 'csv',
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/export/geojson',
                  'parts' => [
                    'export',
                    'geojson',
                  ],
                  'select' => [
                    '$action' => 'geojson',
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/export/kml',
                  'parts' => [
                    'export',
                    'kml',
                  ],
                  'select' => [
                    '$action' => 'kml',
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'history' => [
          'fields' => [
            [
              'name' => 'accuracy',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'address',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'latitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'longitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'timestamp',
              'req' => true,
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'history',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/history',
                  'parts' => [
                    'history',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/history',
                  'parts' => [
                    'history',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'remove' => [
              'input' => 'data',
              'name' => 'remove',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'DELETE',
                  'orig' => '/history',
                  'parts' => [
                    'history',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'location' => [
          'fields' => [
            [
              'name' => 'accuracy',
              'req' => true,
              'short' => 'Accuracy in meters',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'address',
              'short' => 'Human-readable address',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'latitude',
              'req' => true,
              'short' => 'Latitude coordinate',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'longitude',
              'req' => true,
              'short' => 'Longitude coordinate',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'timestamp',
              'short' => 'Timestamp of the location fix',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'location',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/location',
                  'parts' => [
                    'location',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'marker' => [
          'fields' => [
            [
              'name' => 'address',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'createdAt',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'req' => true,
              'short' => 'Unique marker identifier',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'latitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'longitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'name',
              'short' => 'Name or label for the marker',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'marker',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/markers',
                  'parts' => [
                    'markers',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/markers',
                  'parts' => [
                    'markers',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'remove' => [
              'input' => 'data',
              'name' => 'remove',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'DELETE',
                  'orig' => '/markers',
                  'parts' => [
                    'markers',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'repeat' => [
          'fields' => [
            [
              'name' => 'accuracy',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'bestAccuracy',
              'short' => 'Best (lowest) accuracy value from all measurements',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'count',
              'req' => true,
              'short' => 'Number of measurements to take (recommended 8-15)',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'interval',
              'req' => true,
              'short' => 'Interval between measurements in seconds (recommended 0.8-2.0)',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'latitude',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'longitude',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'measurements',
              'type' => '`$ARRAY`',
            ],
            [
              'name' => 'resultType',
              'op' => [
                'create' => [
                  'req' => true,
                  'type' => '`$STRING`',
                ],
              ],
              'short' => 'Type of result to return',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'repeat',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/measurement/repeat',
                  'parts' => [
                    'measurement',
                    'repeat',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'search' => [
          'fields' => [
            [
              'name' => 'address',
              'short' => 'Full address',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'latitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'longitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'name',
              'req' => true,
              'short' => 'Name of the location',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'short' => 'Type of location (e.g., building, park, street)',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'search',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'q',
                        'orig' => 'q',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/search',
                  'parts' => [
                    'search',
                  ],
                  'select' => [
                    'exist' => [
                      'q',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'share' => [
          'fields' => [
            [
              'name' => 'address',
              'short' => 'Address of the location',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'expiresAt',
              'short' => 'Expiration time of the share link',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'latitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'longitude',
              'req' => true,
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'name',
              'short' => 'Optional name for the location',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'qrCode',
              'short' => 'URL to QR code image',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'shareLink',
              'req' => true,
              'short' => 'Shareable URL for the location',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'share',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/share',
                  'parts' => [
                    'share',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return LocationSharingFeatures::make_feature($name);
    }
}
