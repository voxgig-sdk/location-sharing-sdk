<?php
declare(strict_types=1);

// LocationSharing SDK utility: result_body

class LocationSharingResultBody
{
    public static function call(LocationSharingContext $ctx): ?LocationSharingResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
