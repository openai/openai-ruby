# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::RateLimits#list_rate_limits
          class ProjectRateLimit < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints.
            #
            #   @return [String]
            required :id, String

            # @!attribute max_requests_per_1_minute
            #   The maximum requests per minute.
            #
            #   @return [Integer]
            required :max_requests_per_1_minute, Integer

            # @!attribute max_tokens_per_1_minute
            #   The maximum tokens per minute.
            #
            #   @return [Integer]
            required :max_tokens_per_1_minute, Integer

            # @!attribute model
            #   The model this rate limit applies to.
            #
            #   @return [String]
            required :model, String

            # @!attribute object
            #   The object type, which is always `project.rate_limit`
            #
            #   @return [Symbol, :"project.rate_limit"]
            required :object, const: :"project.rate_limit"

            # @!attribute batch_1_day_max_input_tokens
            #   The maximum batch input tokens per day. Only present for relevant models.
            #
            #   @return [Integer, nil]
            optional :batch_1_day_max_input_tokens, Integer

            # @!attribute max_audio_megabytes_per_1_minute
            #   The maximum audio megabytes per minute. Only present for relevant models.
            #
            #   @return [Integer, nil]
            optional :max_audio_megabytes_per_1_minute, Integer

            # @!attribute max_images_per_1_minute
            #   The maximum images per minute. Only present for relevant models.
            #
            #   @return [Integer, nil]
            optional :max_images_per_1_minute, Integer

            # @!attribute max_requests_per_1_day
            #   The maximum requests per day. Only present for relevant models.
            #
            #   @return [Integer, nil]
            optional :max_requests_per_1_day, Integer

            # @!method initialize(id:, max_requests_per_1_minute:, max_tokens_per_1_minute:, model:, batch_1_day_max_input_tokens: nil, max_audio_megabytes_per_1_minute: nil, max_images_per_1_minute: nil, max_requests_per_1_day: nil, object: :"project.rate_limit")
            #   Represents a project rate limit config.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints.
            #
            #   @param max_requests_per_1_minute [Integer] The maximum requests per minute.
            #
            #   @param max_tokens_per_1_minute [Integer] The maximum tokens per minute.
            #
            #   @param model [String] The model this rate limit applies to.
            #
            #   @param batch_1_day_max_input_tokens [Integer] The maximum batch input tokens per day. Only present for relevant models.
            #
            #   @param max_audio_megabytes_per_1_minute [Integer] The maximum audio megabytes per minute. Only present for relevant models.
            #
            #   @param max_images_per_1_minute [Integer] The maximum images per minute. Only present for relevant models.
            #
            #   @param max_requests_per_1_day [Integer] The maximum requests per day. Only present for relevant models.
            #
            #   @param object [Symbol, :"project.rate_limit"] The object type, which is always `project.rate_limit`
          end
        end

        ProjectRateLimit = Projects::ProjectRateLimit
      end
    end
  end
end
