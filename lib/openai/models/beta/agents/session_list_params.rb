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
          #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute metadata
          #   Exact string matches supplied as `metadata[key]=value`. All supplied pairs must
          #   match. Up to 16 pairs, with keys from 1 to 64 characters and values up to 512
          #   characters. New sessions and metadata updates may take time to appear in
          #   filtered results.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String]

          # @!attribute order
          #   The order in which resources are returned. Defaults to `desc`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::SessionListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Beta::Agents::SessionListParams::Order }

          # @!method initialize(after: nil, agent_id: nil, limit: nil, metadata: nil, order: nil, request_options: {})
          #   @param after [String]
          #     Return resources after this resource ID in the selected order.
          #
          #   @param agent_id [String]
          #     Only return sessions whose root agent has this ID. Omit to return sessions for
          #     all agents.
          #
          #   @param limit [Integer]
          #     The maximum number of resources to return, between 1 and 100. Defaults to 20.
          #
          #   @param metadata [Hash{Symbol=>String}]
          #     Exact string matches supplied as `metadata[key]=value`. All supplied pairs must
          #     match. Up to 16 pairs, with keys from 1 to 64 characters and values up to 512
          #     characters. New sessions and metadata updates may take time to appear in
          #     filtered results.
          #
          #   @param order [Symbol, OpenAI::Models::Beta::Agents::SessionListParams::Order]
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
