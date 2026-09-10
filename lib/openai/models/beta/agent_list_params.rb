# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Agents#list
      class AgentListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   Return resources after this resource ID in the selected order.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute limit
        #   The maximum number of resources to return.
        #
        #   @return [Integer, nil]
        optional :limit, Integer, nil?: true

        # @!attribute order
        #   The order in which resources are returned. Defaults to `desc`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Beta::AgentListParams::Order }

        # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
        #   @param after [String]
        #     Return resources after this resource ID in the selected order.
        #
        #   @param limit [Integer, nil]
        #     The maximum number of resources to return.
        #
        #   @param order [Symbol, OpenAI::Models::Beta::AgentListParams::Order]
        #     The order in which resources are returned. Defaults to `desc`.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The order in which resources are returned. Defaults to `desc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          # Returns resources in ascending order.
          ASC = :asc

          # Returns resources in descending order.
          DESC = :desc

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
