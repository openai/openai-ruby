# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::RateLimits#update_rate_limit
          class RateLimitUpdateRateLimitParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute rate_limit_id
            #
            #   @return [String]
            required :rate_limit_id, String

            # @!attribute batch_1_day_max_input_tokens
            #   The maximum batch input tokens per day. Only relevant for certain models.
            #
            #   @return [Integer, nil]
            optional :batch_1_day_max_input_tokens, Integer

            # @!attribute max_audio_megabytes_per_1_minute
            #   The maximum audio megabytes per minute. Only relevant for certain models.
            #
            #   @return [Integer, nil]
            optional :max_audio_megabytes_per_1_minute, Integer

            # @!attribute max_images_per_1_minute
            #   The maximum images per minute. Only relevant for certain models.
            #
            #   @return [Integer, nil]
            optional :max_images_per_1_minute, Integer

            # @!attribute max_requests_per_1_day
            #   The maximum requests per day. Only relevant for certain models.
            #
            #   @return [Integer, nil]
            optional :max_requests_per_1_day, Integer

            # @!attribute max_requests_per_1_minute
            #   The maximum requests per minute.
            #
            #   @return [Integer, nil]
            optional :max_requests_per_1_minute, Integer

            # @!attribute max_tokens_per_1_minute
            #   The maximum tokens per minute.
            #
            #   @return [Integer, nil]
            optional :max_tokens_per_1_minute, Integer

            # @!method initialize(project_id:, rate_limit_id:, batch_1_day_max_input_tokens: nil, max_audio_megabytes_per_1_minute: nil, max_images_per_1_minute: nil, max_requests_per_1_day: nil, max_requests_per_1_minute: nil, max_tokens_per_1_minute: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param rate_limit_id [String]
            #
            #   @param batch_1_day_max_input_tokens [Integer] The maximum batch input tokens per day. Only relevant for certain models.
            #
            #   @param max_audio_megabytes_per_1_minute [Integer] The maximum audio megabytes per minute. Only relevant for certain models.
            #
            #   @param max_images_per_1_minute [Integer] The maximum images per minute. Only relevant for certain models.
            #
            #   @param max_requests_per_1_day [Integer] The maximum requests per day. Only relevant for certain models.
            #
            #   @param max_requests_per_1_minute [Integer] The maximum requests per minute.
            #
            #   @param max_tokens_per_1_minute [Integer] The maximum tokens per minute.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
