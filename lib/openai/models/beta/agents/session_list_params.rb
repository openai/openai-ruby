# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Sessions#list
        class SessionListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Return resources after this resource ID in the selected order.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute agent_id
          #   Only return sessions whose root agent has this ID. Omit to return sessions for
          #   all agents.
          #
          #   @return [String, nil]
          optional :agent_id, String

          # @!attribute limit
          #   The maximum number of resources to return.
          #
          #   @return [Integer, nil]
          optional :limit, Integer, nil?: true

          # @!attribute order
          #   Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `desc`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::SessionListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Beta::Agents::SessionListParams::Order }

          # @!method initialize(after: nil, agent_id: nil, limit: nil, order: nil, request_options: {})
          #   @param after [String]
          #     Return resources after this resource ID in the selected order.
          #
          #   @param agent_id [String]
          #     Only return sessions whose root agent has this ID. Omit to return sessions for
          #     all agents.
          #
          #   @param limit [Integer, nil]
          #     The maximum number of resources to return.
          #
          #   @param order [Symbol, OpenAI::Models::Beta::Agents::SessionListParams::Order]
          #     Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          #     `desc` for descending order. Defaults to `desc`.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `desc`.
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
