# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#list
        class AdminAPIKeyListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Return keys with IDs that come after this ID in the pagination order.
          #
          #   @return [String, nil]
          optional :after, String, nil?: true

          # @!attribute limit
          #   Maximum number of keys to return.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Order results by creation time, ascending or descending.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::AdminAPIKeyListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Admin::Organization::AdminAPIKeyListParams::Order }

          # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
          #   @param after [String, nil] Return keys with IDs that come after this ID in the pagination order.
          #
          #   @param limit [Integer] Maximum number of keys to return.
          #
          #   @param order [Symbol, OpenAI::Models::Admin::Organization::AdminAPIKeyListParams::Order] Order results by creation time, ascending or descending.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Order results by creation time, ascending or descending.
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
