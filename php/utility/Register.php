<?php
declare(strict_types=1);

// LocationSharing SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

LocationSharingUtility::setRegistrar(function (LocationSharingUtility $u): void {
    $u->clean = [LocationSharingClean::class, 'call'];
    $u->done = [LocationSharingDone::class, 'call'];
    $u->make_error = [LocationSharingMakeError::class, 'call'];
    $u->feature_add = [LocationSharingFeatureAdd::class, 'call'];
    $u->feature_hook = [LocationSharingFeatureHook::class, 'call'];
    $u->feature_init = [LocationSharingFeatureInit::class, 'call'];
    $u->fetcher = [LocationSharingFetcher::class, 'call'];
    $u->make_fetch_def = [LocationSharingMakeFetchDef::class, 'call'];
    $u->make_context = [LocationSharingMakeContext::class, 'call'];
    $u->make_options = [LocationSharingMakeOptions::class, 'call'];
    $u->make_request = [LocationSharingMakeRequest::class, 'call'];
    $u->make_response = [LocationSharingMakeResponse::class, 'call'];
    $u->make_result = [LocationSharingMakeResult::class, 'call'];
    $u->make_point = [LocationSharingMakePoint::class, 'call'];
    $u->make_spec = [LocationSharingMakeSpec::class, 'call'];
    $u->make_url = [LocationSharingMakeUrl::class, 'call'];
    $u->param = [LocationSharingParam::class, 'call'];
    $u->prepare_auth = [LocationSharingPrepareAuth::class, 'call'];
    $u->prepare_body = [LocationSharingPrepareBody::class, 'call'];
    $u->prepare_headers = [LocationSharingPrepareHeaders::class, 'call'];
    $u->prepare_method = [LocationSharingPrepareMethod::class, 'call'];
    $u->prepare_params = [LocationSharingPrepareParams::class, 'call'];
    $u->prepare_path = [LocationSharingPreparePath::class, 'call'];
    $u->prepare_query = [LocationSharingPrepareQuery::class, 'call'];
    $u->result_basic = [LocationSharingResultBasic::class, 'call'];
    $u->result_body = [LocationSharingResultBody::class, 'call'];
    $u->result_headers = [LocationSharingResultHeaders::class, 'call'];
    $u->transform_request = [LocationSharingTransformRequest::class, 'call'];
    $u->transform_response = [LocationSharingTransformResponse::class, 'call'];
});
