# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Environments#list
        class EnvironmentListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Return environments after this environment ID in the selected order.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   The maximum number of environments to return, between 1 and 100. Defaults to 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   The order in which environments are returned. Defaults to `desc`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::EnvironmentListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Beta::Agents::EnvironmentListParams::Order }

          # @!attribute type
          #   The hosting type to list. Defaults to `openai_hosted`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::EnvironmentListParams::Type, nil]
          optional :type, enum: -> { OpenAI::Beta::Agents::EnvironmentListParams::Type }

          # @!method initialize(after: nil, limit: nil, order: nil, type: nil, request_options: {})
          #   @param after [String]
          #     Return environments after this environment ID in the selected order.
          #
          #   @param limit [Integer]
          #     The maximum number of environments to return, between 1 and 100. Defaults to 20.
          #
          #   @param order [Symbol, OpenAI::Models::Beta::Agents::EnvironmentListParams::Order]
          #     The order in which environments are returned. Defaults to `desc`.
          #
          #   @param type [Symbol, OpenAI::Models::Beta::Agents::EnvironmentListParams::Type]
          #     The hosting type to list. Defaults to `openai_hosted`.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The order in which environments are returned. Defaults to `desc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            # Returns resources in ascending order.
            ASC = :asc

            # Returns resources in descending order.
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The hosting type to list. Defaults to `openai_hosted`.
          module Type
            extend OpenAI::Internal::Type::Enum

            OPENAI_HOSTED = :openai_hosted

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
