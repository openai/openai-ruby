# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalStorage#list
        class ExternalStorageListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Return external storage configurations after this ID.
          #
          #   @return [String, nil]
          optional :after, String, nil?: true

          # @!attribute limit
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalStorageListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Admin::Organization::ExternalStorageListParams::Order }

          # @!attribute project_id
          #
          #   @return [String, nil]
          optional :project_id, String, nil?: true

          # @!method initialize(after: nil, limit: nil, order: nil, project_id: nil, request_options: {})
          #   @param after [String, nil]
          #     Return external storage configurations after this ID.
          #
          #   @param limit [Integer]
          #
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::ExternalStorageListParams::Order]
          #
          #   @param project_id [String, nil]
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          module Order
            extend OpenAI::Internal::Type::Enum

            ASC = :asc
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
