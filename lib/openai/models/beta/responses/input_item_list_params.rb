# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Responses
        # @see OpenAI::Resources::Beta::Responses::InputItems#list
        class InputItemListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute response_id
          #
          #   @return [String]
          required :response_id, String

          # @!attribute after
          #   An item ID to list items after, used in pagination.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute include
          #   Additional fields to include in the response. See the `include` parameter for
          #   Response creation above for more information.
          #
          #   @return [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>, nil]
          optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaResponseIncludable] }

          # @!attribute limit
          #   A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   The order to return the input items in. Default is `desc`.
          #
          #   - `asc`: Return the input items in ascending order.
          #   - `desc`: Return the input items in descending order.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Responses::InputItemListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Beta::Responses::InputItemListParams::Order }

          # @!attribute betas
          #
          #   @return [Array<Symbol, OpenAI::Models::Beta::Responses::InputItemListParams::Beta>, nil]
          optional :betas,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::Responses::InputItemListParams::Beta] }

          # @!method initialize(response_id:, after: nil, include: nil, limit: nil, order: nil, betas: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::Responses::InputItemListParams} for more details.
          #
          #   @param response_id [String]
          #
          #   @param after [String] An item ID to list items after, used in pagination.
          #
          #   @param include [Array<Symbol, OpenAI::Models::Beta::BetaResponseIncludable>] Additional fields to include in the response. See the `include`
          #
          #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between
          #
          #   @param order [Symbol, OpenAI::Models::Beta::Responses::InputItemListParams::Order] The order to return the input items in. Default is `desc`.
          #
          #   @param betas [Array<Symbol, OpenAI::Models::Beta::Responses::InputItemListParams::Beta>]
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The order to return the input items in. Default is `desc`.
          #
          # - `asc`: Return the input items in ascending order.
          # - `desc`: Return the input items in descending order.
          module Order
            extend OpenAI::Internal::Type::Enum

            ASC = :asc
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          module Beta
            extend OpenAI::Internal::Type::Enum

            RESPONSES_MULTI_AGENT_V1 = :"responses_multi_agent=v1"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
