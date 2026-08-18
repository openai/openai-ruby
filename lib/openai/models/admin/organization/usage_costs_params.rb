# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Usage#costs
        class UsageCostsParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute start_time
          #   Start time (Unix seconds) of the query time range, inclusive.
          #
          #   @return [Integer]
          required :start_time, Integer

          # @!attribute api_key_ids
          #   Return only costs for these API keys.
          #
          #   @return [Array<String>, nil]
          optional :api_key_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute bucket_width
          #   Width of each time bucket in response. Currently only `1d` is supported, default
          #   to `1d`.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::UsageCostsParams::BucketWidth, nil]
          optional :bucket_width, enum: -> { OpenAI::Admin::Organization::UsageCostsParams::BucketWidth }

          # @!attribute end_time
          #   End time (Unix seconds) of the query time range, exclusive.
          #
          #   @return [Integer, nil]
          optional :end_time, Integer

          # @!attribute group_by
          #   Group the costs by the specified fields. Support fields include `project_id`,
          #   `line_item`, `api_key_id` and any combination of them.
          #
          #   @return [Array<Symbol, OpenAI::Models::Admin::Organization::UsageCostsParams::GroupBy>, nil]
          optional :group_by,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Admin::Organization::UsageCostsParams::GroupBy] }

          # @!attribute limit
          #   A limit on the number of buckets to be returned. Limit can range between 1 and
          #   180, and the default is 7.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute page
          #   A cursor for use in pagination. Corresponding to the `next_page` field from the
          #   previous response.
          #
          #   @return [String, nil]
          optional :page, String

          # @!attribute project_ids
          #   Return only costs for these projects.
          #
          #   @return [Array<String>, nil]
          optional :project_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!method initialize(start_time:, api_key_ids: nil, bucket_width: nil, end_time: nil, group_by: nil, limit: nil, page: nil, project_ids: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::UsageCostsParams} for more details.
          #
          #   @param start_time [Integer] Start time (Unix seconds) of the query time range, inclusive.
          #
          #   @param api_key_ids [Array<String>] Return only costs for these API keys.
          #
          #   @param bucket_width [Symbol, OpenAI::Models::Admin::Organization::UsageCostsParams::BucketWidth] Width of each time bucket in response. Currently only `1d` is supported, default
          #
          #   @param end_time [Integer] End time (Unix seconds) of the query time range, exclusive.
          #
          #   @param group_by [Array<Symbol, OpenAI::Models::Admin::Organization::UsageCostsParams::GroupBy>] Group the costs by the specified fields. Support fields include `project_id`, `l
          #
          #   @param limit [Integer] A limit on the number of buckets to be returned. Limit can range between 1 and 1
          #
          #   @param page [String] A cursor for use in pagination. Corresponding to the `next_page` field from the
          #
          #   @param project_ids [Array<String>] Return only costs for these projects.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Width of each time bucket in response. Currently only `1d` is supported, default
          # to `1d`.
          module BucketWidth
            extend OpenAI::Internal::Type::Enum

            BUCKET_WIDTH_1D = :"1d"

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          module GroupBy
            extend OpenAI::Internal::Type::Enum

            PROJECT_ID = :project_id
            LINE_ITEM = :line_item
            API_KEY_ID = :api_key_id

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
