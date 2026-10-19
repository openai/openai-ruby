# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Usage#decisions
        class UsageDecisionsResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data>]
          required(
            :data,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data] }
          )

          # @!attribute has_more
          #
          #   @return [Boolean]
          required :has_more, OpenAI::Internal::Type::Boolean

          # @!attribute next_page
          #
          #   @return [String, nil]
          required :next_page, String, nil?: true

          # @!attribute object
          #
          #   @return [Symbol, :page]
          required :object, const: :page

          # @!method initialize(data:, has_more:, next_page:, object: :page)
          #   @param data [Array<OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data>]
          #   @param has_more [Boolean]
          #   @param next_page [String, nil]
          #   @param object [Symbol, :page]

          class Data < OpenAI::Internal::Type::BaseModel
            # @!attribute end_time
            #
            #   @return [Integer]
            required :end_time, Integer

            # @!attribute object
            #
            #   @return [Symbol, :bucket]
            required :object, const: :bucket

            # @!attribute results
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result>]
            required(
              :results,
              -> {
                OpenAI::Internal::Type::ArrayOf[
                  OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result
                ]
              }
            )

            # @!attribute start_time
            #
            #   @return [Integer]
            required :start_time, Integer

            # @!method initialize(end_time:, results:, start_time:, object: :bucket)
            #   @param end_time [Integer]
            #   @param results [Array<OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result>]
            #   @param start_time [Integer]
            #   @param object [Symbol, :bucket]

            class Result < OpenAI::Internal::Type::BaseModel
              # @!attribute input_tokens
              #   The aggregated number of input tokens used, including cached and cache-write
              #   tokens. This includes text, audio, and image tokens. For customers subscribed to
              #   Scale Tier, this includes Scale Tier tokens.
              #
              #   @return [Integer]
              required :input_tokens, Integer

              # @!attribute num_model_requests
              #   The count of requests made to the model.
              #
              #   @return [Integer]
              required :num_model_requests, Integer

              # @!attribute object
              #
              #   @return [Symbol, :"organization.usage.decisions.result"]
              required :object, const: :"organization.usage.decisions.result"

              # @!attribute output_tokens
              #   The aggregated number of output tokens used across text, audio, and image
              #   outputs. For customers subscribed to Scale Tier, this includes Scale Tier
              #   tokens.
              #
              #   @return [Integer]
              required :output_tokens, Integer

              # @!attribute api_key_id
              #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
              #   usage result.
              #
              #   @return [String, nil]
              optional :api_key_id, String, nil?: true

              # @!attribute api_source
              #   When grouped by `api_source`, `agents_api` identifies attributed Agents API
              #   activity and `unlabeled` includes all records without published source
              #   attribution, including historical and unknown origins. Unlabeled does not imply
              #   direct API usage. Without source grouping, this field is null.
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource, nil]
              optional(
                :api_source,
                enum: -> { OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource },
                nil?: true
              )

              # @!attribute batch
              #   When `group_by=batch`, this field tells whether the grouped usage result is
              #   batch or not.
              #
              #   @return [Boolean, nil]
              optional :batch, OpenAI::Internal::Type::Boolean, nil?: true

              # @!attribute input_audio_tokens
              #   The aggregated number of uncached audio input tokens used.
              #
              #   @return [Integer, nil]
              optional :input_audio_tokens, Integer, nil?: true

              # @!attribute input_cache_write_12h_tokens
              #   The aggregated number of input tokens written to the cache with a 12-hour
              #   retention period.
              #
              #   @return [Integer, nil]
              optional :input_cache_write_12h_tokens, Integer, nil?: true

              # @!attribute input_cache_write_30m_tokens
              #   The aggregated number of input tokens written to the cache with a 30-minute
              #   retention period.
              #
              #   @return [Integer, nil]
              optional :input_cache_write_30m_tokens, Integer, nil?: true

              # @!attribute input_cache_write_tokens
              #   The aggregated number of input tokens written to the cache with a 30-minute
              #   retention period.
              #
              #   @return [Integer, nil]
              optional :input_cache_write_tokens, Integer, nil?: true

              # @!attribute input_cached_audio_tokens
              #   The aggregated number of cached audio input tokens used.
              #
              #   @return [Integer, nil]
              optional :input_cached_audio_tokens, Integer, nil?: true

              # @!attribute input_cached_image_tokens
              #   The aggregated number of cached image input tokens used.
              #
              #   @return [Integer, nil]
              optional :input_cached_image_tokens, Integer, nil?: true

              # @!attribute input_cached_text_tokens
              #   The aggregated number of cached text input tokens used.
              #
              #   @return [Integer, nil]
              optional :input_cached_text_tokens, Integer, nil?: true

              # @!attribute input_cached_tokens
              #   The aggregated number of cached input tokens used across text, audio, and image
              #   inputs. For customers subscribed to Scale Tier, this includes Scale Tier tokens.
              #
              #   @return [Integer, nil]
              optional :input_cached_tokens, Integer, nil?: true

              # @!attribute input_image_tokens
              #   The aggregated number of uncached image input tokens used.
              #
              #   @return [Integer, nil]
              optional :input_image_tokens, Integer, nil?: true

              # @!attribute input_text_tokens
              #   The aggregated number of uncached text input tokens used, excluding cache-write
              #   tokens.
              #
              #   @return [Integer, nil]
              optional :input_text_tokens, Integer, nil?: true

              # @!attribute input_uncached_tokens
              #   The aggregated number of uncached input tokens used across text, audio, and
              #   image inputs, excluding cache-write tokens.
              #
              #   @return [Integer, nil]
              optional :input_uncached_tokens, Integer, nil?: true

              # @!attribute model
              #   When `group_by=model`, this field provides the model name of the grouped usage
              #   result.
              #
              #   @return [String, nil]
              optional :model, String, nil?: true

              # @!attribute output_audio_tokens
              #   The aggregated number of audio output tokens used.
              #
              #   @return [Integer, nil]
              optional :output_audio_tokens, Integer, nil?: true

              # @!attribute output_image_tokens
              #   The aggregated number of image output tokens used.
              #
              #   @return [Integer, nil]
              optional :output_image_tokens, Integer, nil?: true

              # @!attribute output_text_tokens
              #   The aggregated number of text output tokens used.
              #
              #   @return [Integer, nil]
              optional :output_text_tokens, Integer, nil?: true

              # @!attribute project_id
              #   When `group_by=project_id`, this field provides the project ID of the grouped
              #   usage result.
              #
              #   @return [String, nil]
              optional :project_id, String, nil?: true

              # @!attribute service_tier
              #   When `group_by=service_tier`, this field provides the service tier of the
              #   grouped usage result.
              #
              #   @return [String, nil]
              optional :service_tier, String, nil?: true

              # @!attribute user_id
              #   When `group_by=user_id`, this field provides the user ID of the grouped usage
              #   result.
              #
              #   @return [String, nil]
              optional :user_id, String, nil?: true

              # @!method initialize(input_tokens:, num_model_requests:, output_tokens:, api_key_id: nil, api_source: nil, batch: nil, input_audio_tokens: nil, input_cache_write_12h_tokens: nil, input_cache_write_30m_tokens: nil, input_cache_write_tokens: nil, input_cached_audio_tokens: nil, input_cached_image_tokens: nil, input_cached_text_tokens: nil, input_cached_tokens: nil, input_image_tokens: nil, input_text_tokens: nil, input_uncached_tokens: nil, model: nil, output_audio_tokens: nil, output_image_tokens: nil, output_text_tokens: nil, project_id: nil, service_tier: nil, user_id: nil, object: :"organization.usage.decisions.result")
              #   The aggregated Decisions API usage details of the specific time bucket.
              #
              #   @param input_tokens [Integer]
              #     The aggregated number of input tokens used, including cached and cache-write
              #     tokens. This includes text, audio, and image tokens. For customers subscribed to
              #     Scale Tier, this includes Scale Tier tokens.
              #
              #   @param num_model_requests [Integer]
              #     The count of requests made to the model.
              #
              #   @param output_tokens [Integer]
              #     The aggregated number of output tokens used across text, audio, and image
              #     outputs. For customers subscribed to Scale Tier, this includes Scale Tier
              #     tokens.
              #
              #   @param api_key_id [String, nil]
              #     When `group_by=api_key_id`, this field provides the API key ID of the grouped
              #     usage result.
              #
              #   @param api_source [Symbol, OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource, nil]
              #     When grouped by `api_source`, `agents_api` identifies attributed Agents API
              #     activity and `unlabeled` includes all records without published source
              #     attribution, including historical and unknown origins. Unlabeled does not imply
              #     direct API usage. Without source grouping, this field is null.
              #
              #   @param batch [Boolean, nil]
              #     When `group_by=batch`, this field tells whether the grouped usage result is
              #     batch or not.
              #
              #   @param input_audio_tokens [Integer, nil]
              #     The aggregated number of uncached audio input tokens used.
              #
              #   @param input_cache_write_12h_tokens [Integer, nil]
              #     The aggregated number of input tokens written to the cache with a 12-hour
              #     retention period.
              #
              #   @param input_cache_write_30m_tokens [Integer, nil]
              #     The aggregated number of input tokens written to the cache with a 30-minute
              #     retention period.
              #
              #   @param input_cache_write_tokens [Integer, nil]
              #     The aggregated number of input tokens written to the cache with a 30-minute
              #     retention period.
              #
              #   @param input_cached_audio_tokens [Integer, nil]
              #     The aggregated number of cached audio input tokens used.
              #
              #   @param input_cached_image_tokens [Integer, nil]
              #     The aggregated number of cached image input tokens used.
              #
              #   @param input_cached_text_tokens [Integer, nil]
              #     The aggregated number of cached text input tokens used.
              #
              #   @param input_cached_tokens [Integer, nil]
              #     The aggregated number of cached input tokens used across text, audio, and image
              #     inputs. For customers subscribed to Scale Tier, this includes Scale Tier tokens.
              #
              #   @param input_image_tokens [Integer, nil]
              #     The aggregated number of uncached image input tokens used.
              #
              #   @param input_text_tokens [Integer, nil]
              #     The aggregated number of uncached text input tokens used, excluding cache-write
              #     tokens.
              #
              #   @param input_uncached_tokens [Integer, nil]
              #     The aggregated number of uncached input tokens used across text, audio, and
              #     image inputs, excluding cache-write tokens.
              #
              #   @param model [String, nil]
              #     When `group_by=model`, this field provides the model name of the grouped usage
              #     result.
              #
              #   @param output_audio_tokens [Integer, nil]
              #     The aggregated number of audio output tokens used.
              #
              #   @param output_image_tokens [Integer, nil]
              #     The aggregated number of image output tokens used.
              #
              #   @param output_text_tokens [Integer, nil]
              #     The aggregated number of text output tokens used.
              #
              #   @param project_id [String, nil]
              #     When `group_by=project_id`, this field provides the project ID of the grouped
              #     usage result.
              #
              #   @param service_tier [String, nil]
              #     When `group_by=service_tier`, this field provides the service tier of the
              #     grouped usage result.
              #
              #   @param user_id [String, nil]
              #     When `group_by=user_id`, this field provides the user ID of the grouped usage
              #     result.
              #
              #   @param object [Symbol, :"organization.usage.decisions.result"]

              # When grouped by `api_source`, `agents_api` identifies attributed Agents API
              # activity and `unlabeled` includes all records without published source
              # attribution, including historical and unknown origins. Unlabeled does not imply
              # direct API usage. Without source grouping, this field is null.
              #
              # @see OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result#api_source
              module APISource
                extend OpenAI::Internal::Type::Enum

                AGENTS_API = :agents_api
                UNLABELED = :unlabeled

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end
          end
        end
      end
    end
  end
end
