# LocationSharing SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

LocationSharingUtility.registrar = ->(u) {
  u.clean = LocationSharingUtilities::Clean
  u.done = LocationSharingUtilities::Done
  u.make_error = LocationSharingUtilities::MakeError
  u.feature_add = LocationSharingUtilities::FeatureAdd
  u.feature_hook = LocationSharingUtilities::FeatureHook
  u.feature_init = LocationSharingUtilities::FeatureInit
  u.fetcher = LocationSharingUtilities::Fetcher
  u.make_fetch_def = LocationSharingUtilities::MakeFetchDef
  u.make_context = LocationSharingUtilities::MakeContext
  u.make_options = LocationSharingUtilities::MakeOptions
  u.make_request = LocationSharingUtilities::MakeRequest
  u.make_response = LocationSharingUtilities::MakeResponse
  u.make_result = LocationSharingUtilities::MakeResult
  u.make_point = LocationSharingUtilities::MakePoint
  u.make_spec = LocationSharingUtilities::MakeSpec
  u.make_url = LocationSharingUtilities::MakeUrl
  u.param = LocationSharingUtilities::Param
  u.prepare_auth = LocationSharingUtilities::PrepareAuth
  u.prepare_body = LocationSharingUtilities::PrepareBody
  u.prepare_headers = LocationSharingUtilities::PrepareHeaders
  u.prepare_method = LocationSharingUtilities::PrepareMethod
  u.prepare_params = LocationSharingUtilities::PrepareParams
  u.prepare_path = LocationSharingUtilities::PreparePath
  u.prepare_query = LocationSharingUtilities::PrepareQuery
  u.result_basic = LocationSharingUtilities::ResultBasic
  u.result_body = LocationSharingUtilities::ResultBody
  u.result_headers = LocationSharingUtilities::ResultHeaders
  u.transform_request = LocationSharingUtilities::TransformRequest
  u.transform_response = LocationSharingUtilities::TransformResponse
}
