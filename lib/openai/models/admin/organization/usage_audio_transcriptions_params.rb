# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Usage#audio_transcriptions
        class UsageAudioTranscriptionsParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute start_time
          #   Start time (Unix seconds) of the query time range, inclusive.
          #
          #   @return [Integer]
          required :start_time, Integer

          # @!attribute api_key_ids
          #   Return only usage for these API keys.
          #
          #   @return [Array<String>, nil]
          optional :api_key_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute bucket_width
          #   Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
          #   supported, default to `1d`.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams::BucketWidth, nil]
          optional :bucket_width,
                   enum: -> { OpenAI::Admin::Organization::UsageAudioTranscriptionsParams::BucketWidth }

          # @!attribute end_time
          #   End time (Unix seconds) of the query time range, exclusive.
          #
          #   @return [Integer, nil]
          optional :end_time, Integer

          # @!attribute group_by
          #   Group the usage data by the specified fields. Support fields include
          #   `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
          #
          #   @return [Array<Symbol, OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams::GroupBy>, nil]
          optional :group_by,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Admin::Organization::UsageAudioTranscriptionsParams::GroupBy] }

          # @!attribute limit
          #   Specifies the number of buckets to return.
          #
          #   - `bucket_width=1d`: default: 7, max: 31
          #   - `bucket_width=1h`: default: 24, max: 168
          #   - `bucket_width=1m`: default: 60, max: 1440
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute models
          #   Return only usage for these models.
          #
          #   @return [Array<String>, nil]
          optional :models, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute page
          #   A cursor for use in pagination. Corresponding to the `next_page` field from the
          #   previous response.
          #
          #   @return [String, nil]
          optional :page, String

          # @!attribute project_ids
          #   Return only usage for these projects.
          #
          #   @return [Array<String>, nil]
          optional :project_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute user_ids
          #   Return only usage for these users.
          #
          #   @return [Array<String>, nil]
          optional :user_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!method initialize(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, models: nil, page: nil, project_ids: nil, user_ids: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams} for more
          #   details.
          #
          #   @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          #   @param api_key_ids [Array<String>] Return only usage for these API keys.
          #
          #   @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams::BucketWidth] Width of each time bucket in response. Currently `1m`, `1h` and `1d` are support
          #
          #   @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          #   @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsParams::GroupBy>] Group the usage data by the specified fields. Support fields include `project_id
          #
          #   @param limit [Integer] Specifies the number of buckets to return.
          #
          #   @param models [Array<String>] Return only usage for these models.
          #
          #   @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          #   @param project_ids [Array<String>] Return only usage for these projects.
          #
          #   @param user_ids [Array<String>] Return only usage for these users.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
          # supported, default to `1d`.
          module BucketWidth
            extend OpenAI::Internal::Type::Enum

            BUCKET_WIDTH_1M = :"1m"
            BUCKET_WIDTH_1H = :"1h"
            BUCKET_WIDTH_1D = :"1d"

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          module GroupBy
            extend OpenAI::Internal::Type::Enum

            PROJECT_ID = :project_id
            USER_ID = :user_id
            API_KEY_ID = :api_key_id
            MODEL = :model

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
