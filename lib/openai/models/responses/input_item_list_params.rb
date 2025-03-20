# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class InputItemListParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute [r] after
        #   An item ID to list items after, used in pagination.
        #
        #   @return [String, nil]
        optional :after, String

        # @!parse
        #   # @return [String]
        #   attr_writer :after

        # @!attribute [r] before
        #   An item ID to list items before, used in pagination.
        #
        #   @return [String, nil]
        optional :before, String

        # @!parse
        #   # @return [String]
        #   attr_writer :before

        # @!attribute [r] limit
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #     100, and the default is 20.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!parse
        #   # @return [Integer]
        #   attr_writer :limit

        # @!attribute [r] order
        #   The order to return the input items in. Default is `asc`.
        #
        #     - `asc`: Return the input items in ascending order.
        #     - `desc`: Return the input items in descending order.
        #
        #   @return [Symbol, OpenAI::Models::Responses::InputItemListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Models::Responses::InputItemListParams::Order }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::InputItemListParams::Order]
        #   attr_writer :order

        # @!parse
        #   # @param after [String]
        #   # @param before [String]
        #   # @param limit [Integer]
        #   # @param order [Symbol, OpenAI::Models::Responses::InputItemListParams::Order]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(after: nil, before: nil, limit: nil, order: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The order to return the input items in. Default is `asc`.
        #
        #   - `asc`: Return the input items in ascending order.
        #   - `desc`: Return the input items in descending order.
        module Order
          extend OpenAI::Enum

          ASC = :asc
          DESC = :desc

          finalize!
        end
      end
    end
  end
end
