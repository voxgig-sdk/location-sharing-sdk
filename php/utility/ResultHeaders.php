<?php
declare(strict_types=1);

// LocationSharing SDK utility: result_headers

class LocationSharingResultHeaders
{
    public static function call(LocationSharingContext $ctx): ?LocationSharingResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
