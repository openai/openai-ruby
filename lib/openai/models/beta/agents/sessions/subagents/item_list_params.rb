# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          module Subagents
            # @see OpenAI::Resources::Beta::Agents::Sessions::Subagents::Items#list
            class ItemListParams < OpenAI::Internal::Type::BaseModel
              extend OpenAI::Internal::Type::RequestParameters::Converter
              include OpenAI::Internal::Type::RequestParameters

              # @!attribute session_id
              #
              #   @return [String]
              required :session_id, String

              # @!attribute subagent_id
              #
              #   @return [String]
              required :subagent_id, String

              # @!attribute after
              #   Return resources after this resource ID in the selected order.
              #
              #   @return [String, nil]
              optional :after, String

              # @!attribute limit
              #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
              #
              #   @return [Integer, nil]
              optional :limit, Integer

              # @!attribute order
              #   The order in which resources are returned. Defaults to `desc`.
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::Sessions::Subagents::ItemListParams::Order, nil]
              optional :order, enum: -> { OpenAI::Beta::Agents::Sessions::Subagents::ItemListParams::Order }

              # @!method initialize(session_id:, subagent_id:, after: nil, limit: nil, order: nil, request_options: {})
              #   @param session_id [String]
              #
              #   @param subagent_id [String]
              #
              #   @param after [String]
              #     Return resources after this resource ID in the selected order.
              #
              #   @param limit [Integer]
              #     The maximum number of resources to return, between 1 and 100. Defaults to 20.
              #
              #   @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::Subagents::ItemListParams::Order]
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
    end
  end
end
