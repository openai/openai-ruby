# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Artifacts#list
          class ArtifactListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute session_id
            #
            #   @return [String]
            required :session_id, String

            # @!attribute after
            #   Return artifacts after this immutable artifact ID.
            #
            #   @return [String, nil]
            optional :after, String, nil?: true

            # @!attribute environment_id
            #   Restrict the listing to artifacts produced by this environment.
            #
            #   @return [String, nil]
            optional :environment_id, String, nil?: true

            # @!attribute limit
            #   The maximum number of artifacts to return, between 1 and 100.
            #
            #   @return [Integer, nil]
            optional :limit, Integer, nil?: true

            # @!attribute order
            #   Sort by creation time and ID. Defaults to descending.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Agents::Sessions::ArtifactListParams::Order, nil]
            optional :order, enum: -> { OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order }

            # @!method initialize(session_id:, after: nil, environment_id: nil, limit: nil, order: nil, request_options: {})
            #   @param session_id [String]
            #
            #   @param after [String, nil]
            #     Return artifacts after this immutable artifact ID.
            #
            #   @param environment_id [String, nil]
            #     Restrict the listing to artifacts produced by this environment.
            #
            #   @param limit [Integer, nil]
            #     The maximum number of artifacts to return, between 1 and 100.
            #
            #   @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::ArtifactListParams::Order]
            #     Sort by creation time and ID. Defaults to descending.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Sort by creation time and ID. Defaults to descending.
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
