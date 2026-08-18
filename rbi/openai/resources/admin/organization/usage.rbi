# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Usage
          # Get audio speeches usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageAudioSpeechesParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageAudioSpeechesParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageAudioSpeechesResponse
            )
          end
          def audio_speeches(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # Get audio transcriptions usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageAudioTranscriptionsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageAudioTranscriptionsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsResponse
            )
          end
          def audio_transcriptions(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # Get code interpreter sessions usage details for the organization.
          sig do
            params(
              start_time: Integer,
              bucket_width:
                OpenAI::Admin::Organization::UsageCodeInterpreterSessionsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageCodeInterpreterSessionsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              page: String,
              project_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse
            )
          end
          def code_interpreter_sessions(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            request_options: {}
          )
          end

          # Get completions usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              batch: T::Boolean,
              bucket_width:
                OpenAI::Admin::Organization::UsageCompletionsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageCompletionsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageCompletionsResponse
            )
          end
          def completions(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # If `true`, return batch jobs only. If `false`, return non-batch jobs only. By
            # default, return both.
            batch: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model`, `batch`, `service_tier` or any
            # combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # Get costs details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageCostsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              page: String,
              project_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::UsageCostsResponse)
          end
          def costs(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only costs for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently only `1d` is supported, default
            # to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the costs by the specified fields. Support fields include `project_id`,
            # `line_item`, `api_key_id` and any combination of them.
            group_by: nil,
            # A limit on the number of buckets to be returned. Limit can range between 1 and
            # 180, and the default is 7.
            limit: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only costs for these projects.
            project_ids: nil,
            request_options: {}
          )
          end

          # Get embeddings usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageEmbeddingsResponse
            )
          end
          def embeddings(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # Get file search calls usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageFileSearchCallsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageFileSearchCallsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              vector_store_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageFileSearchCallsResponse
            )
          end
          def file_search_calls(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `vector_store_id` or any combination of
            # them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            # Return only usage for these vector stores.
            vector_store_ids: nil,
            request_options: {}
          )
          end

          # Get images usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageImagesParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageImagesParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              sizes:
                T::Array[
                  OpenAI::Admin::Organization::UsageImagesParams::Size::OrSymbol
                ],
              sources:
                T::Array[
                  OpenAI::Admin::Organization::UsageImagesParams::Source::OrSymbol
                ],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::UsageImagesResponse)
          end
          def images(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model`, `size`, `source` or any
            # combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usages for these image sizes. Possible values are `256x256`,
            # `512x512`, `1024x1024`, `1792x1792`, `1024x1792` or any combination of them.
            sizes: nil,
            # Return only usages for these sources. Possible values are `image.generation`,
            # `image.edit`, `image.variation` or any combination of them.
            sources: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # Get moderations usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageModerationsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageModerationsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageModerationsResponse
            )
          end
          def moderations(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # Get vector stores usage details for the organization.
          sig do
            params(
              start_time: Integer,
              bucket_width:
                OpenAI::Admin::Organization::UsageVectorStoresParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageVectorStoresParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              page: String,
              project_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageVectorStoresResponse
            )
          end
          def vector_stores(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            request_options: {}
          )
          end

          # Get web search calls usage details for the organization.
          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageWebSearchCallsParams::BucketWidth::OrSymbol,
              context_levels:
                T::Array[
                  OpenAI::Admin::Organization::UsageWebSearchCallsParams::ContextLevel::OrSymbol
                ],
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageWebSearchCallsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::UsageWebSearchCallsResponse
            )
          end
          def web_search_calls(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # Return only web search usage for these context levels.
            context_levels: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model`, `context_level` or any
            # combination of them.
            group_by: nil,
            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,
            # Return only usage for these models.
            models: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only usage for these projects.
            project_ids: nil,
            # Return only usage for these users.
            user_ids: nil,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
