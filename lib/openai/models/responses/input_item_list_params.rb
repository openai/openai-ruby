# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses::InputItems#list
      class InputItemListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   An item ID to list items after, used in pagination.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute before
        #   An item ID to list items before, used in pagination.
        #
        #   @return [String, nil]
        optional :before, String

        # @!attribute include
        #   Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Models::Responses::ResponseIncludable] }

        # @!attribute limit
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute order
        #   The order to return the input items in. Default is `asc`.
        #
        #   - `asc`: Return the input items in ascending order.
        #   - `desc`: Return the input items in descending order.
        #
        #   @return [Symbol, OpenAI::Models::Responses::InputItemListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Models::Responses::InputItemListParams::Order }

        # @!method initialize(after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
        #   @param after [String]
        #   @param before [String]
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
        #   @param limit [Integer]
        #   @param order [Symbol, OpenAI::Models::Responses::InputItemListParams::Order]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The order to return the input items in. Default is `asc`.
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
      end
    end
  end
end
