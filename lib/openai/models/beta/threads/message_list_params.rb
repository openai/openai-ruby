# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageListParams < OpenAI::BaseModel
          # @!parse
          #   extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # @!attribute [r] after
          #   A cursor for use in pagination. `after` is an object ID that defines your place
          #     in the list. For instance, if you make a list request and receive 100 objects,
          #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #     fetch the next page of the list.
          #
          #   @return [String, nil]
          optional :after, String

          # @!parse
          #   # @return [String]
          #   attr_writer :after

          # @!attribute [r] before
          #   A cursor for use in pagination. `before` is an object ID that defines your place
          #     in the list. For instance, if you make a list request and receive 100 objects,
          #     starting with obj_foo, your subsequent call can include before=obj_foo in order
          #     to fetch the previous page of the list.
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
          #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #     order and `desc` for descending order.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Models::Beta::Threads::MessageListParams::Order }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order]
          #   attr_writer :order

          # @!attribute [r] run_id
          #   Filter messages by the run ID that generated them.
          #
          #   @return [String, nil]
          optional :run_id, String

          # @!parse
          #   # @return [String]
          #   attr_writer :run_id

          # @!parse
          #   # @param after [String]
          #   # @param before [String]
          #   # @param limit [Integer]
          #   # @param order [Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order]
          #   # @param run_id [String]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(after: nil, before: nil, limit: nil, order: nil, run_id: nil, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #   order and `desc` for descending order.
          module Order
            extend OpenAI::Enum

            ASC = :asc
            DESC = :desc

            finalize!

            class << self
              # @!parse
              #   # @return [Array<Symbol>]
              #   def values; end
            end
          end
        end
      end
    end
  end
end
