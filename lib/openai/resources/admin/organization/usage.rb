# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Usage
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageAudioSpeechesParams} for more
          # details.
          #
          # Get audio speeches usage details for the organization.
          #
          # @overload audio_speeches(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageAudioSpeechesParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageAudioSpeechesParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageAudioSpeechesResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageAudioSpeechesParams
          def audio_speeches(params)
            parsed, options = OpenAI::Admin::Organization::UsageAudioSpeechesParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/audio_speeches",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageAudioSpeechesResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams} for more
          # details.
          #
          # Get audio transcriptions usage details for the organization.
          #
          # @overload audio_transcriptions(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams
          def audio_transcriptions(params)
            parsed, options = OpenAI::Admin::Organization::UsageAudioTranscriptionsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/audio_transcriptions",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsParams} for
          # more details.
          #
          # Get code interpreter sessions usage details for the organization.
          #
          # @overload code_interpreter_sessions(start_time:, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, page: nil, project_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsParams
          def code_interpreter_sessions(params)
            parsed, options = OpenAI::Admin::Organization::UsageCodeInterpreterSessionsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/code_interpreter_sessions",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageCompletionsParams} for more details.
          #
          # Get completions usage details for the organization.
          #
          # @overload completions(start_time:, api_key_ids: nil, batch: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param batch [Boolean] If `true`, return batch jobs only. If `false`, return non-batch jobs only. By de
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageCompletionsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageCompletionsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageCompletionsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageCompletionsParams
          def completions(params)
            parsed, options = OpenAI::Admin::Organization::UsageCompletionsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/completions",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageCompletionsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageCostsParams} for more details.
          #
          # Get costs details for the organization.
          #
          # @overload costs(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, page: nil, project_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only costs for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageCostsParams::BucketWidth] Width of each time bucket in response. Currently only `1d` is supported, default
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageCostsParams::GroupBy>] Group the costs by the specified fields. Support fields include `project_id`, `l
          #
          # @param limit [Integer] A limit on the number of buckets to be returned. Limit can range between 1 and 1
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only costs for these projects.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageCostsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageCostsParams
          def costs(params)
            parsed, options = OpenAI::Admin::Organization::UsageCostsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/costs",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageCostsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageEmbeddingsParams} for more details.
          #
          # Get embeddings usage details for the organization.
          #
          # @overload embeddings(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageEmbeddingsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageEmbeddingsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageEmbeddingsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageEmbeddingsParams
          def embeddings(params)
            parsed, options = OpenAI::Admin::Organization::UsageEmbeddingsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/embeddings",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageEmbeddingsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageFileSearchCallsParams} for more
          # details.
          #
          # Get file search calls usage details for the organization.
          #
          # @overload file_search_calls(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, page: nil, project_ids: nil, user_ids: nil, vector_store_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageFileSearchCallsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageFileSearchCallsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param vector_store_ids [Array<String>] Return only usage for these vector stores.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageFileSearchCallsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageFileSearchCallsParams
          def file_search_calls(params)
            parsed, options = OpenAI::Admin::Organization::UsageFileSearchCallsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/file_search_calls",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageFileSearchCallsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageImagesParams} for more details.
          #
          # Get images usage details for the organization.
          #
          # @overload images(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, sizes: nil, sources: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageImagesParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageImagesParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param sizes [Array<Symbol, OpenAI::Models::Admin::Organization::UsageImagesParams::Size>] Return only usages for these image sizes. Possible values are `256x256`, `512x51
          #
          # @param sources [Array<Symbol, OpenAI::Models::Admin::Organization::UsageImagesParams::Source>] Return only usages for these sources. Possible values are `image.generation`, `i
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageImagesResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageImagesParams
          def images(params)
            parsed, options = OpenAI::Admin::Organization::UsageImagesParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/images",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageImagesResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageModerationsParams} for more details.
          #
          # Get moderations usage details for the organization.
          #
          # @overload moderations(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageModerationsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageModerationsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageModerationsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageModerationsParams
          def moderations(params)
            parsed, options = OpenAI::Admin::Organization::UsageModerationsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/moderations",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageModerationsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageVectorStoresParams} for more details.
          #
          # Get vector stores usage details for the organization.
          #
          # @overload vector_stores(start_time:, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, page: nil, project_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageVectorStoresParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageVectorStoresParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageVectorStoresResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageVectorStoresParams
          def vector_stores(params)
            parsed, options = OpenAI::Admin::Organization::UsageVectorStoresParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/vector_stores",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageVectorStoresResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UsageWebSearchCallsParams} for more
          # details.
          #
          # Get web search calls usage details for the organization.
          #
          # @overload web_search_calls(start_time:, api_key_ids: nil, bucket_width: nil, context_levels: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #
          # @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          # @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          # @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageWebSearchCallsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          # @param context_levels [Array<Symbol, OpenAI::Models::Admin::Organization::UsageWebSearchCallsParams::ContextLevel>] Return only web search usage for these context levels.
          #
          # @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          # @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageWebSearchCallsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          # @param limit [Integer] Specifies the number of buckets to return.
          #
          # @param models [Array<String>] Return only usage for these models.
          #
          # @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          # @param project_ids [Array<String>] Return only usage for these projects.
          #
          # @param user_ids [Array<String>] Return only usage for these users.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UsageWebSearchCallsResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UsageWebSearchCallsParams
          def web_search_calls(params)
            parsed, options = OpenAI::Admin::Organization::UsageWebSearchCallsParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/usage/web_search_calls",
              query: query,
              model: OpenAI::Models::Admin::Organization::UsageWebSearchCallsResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
