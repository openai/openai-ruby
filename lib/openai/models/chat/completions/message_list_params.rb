# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      module Completions
        # @see OpenAI::Resources::Chat::Completions::Messages#list
        class MessageListParams < OpenAI::BaseModel
          # @!parse
          #   extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute [r] after
          #   Identifier for the last message from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!parse
          #   # @return [String]
          #   attr_writer :after

          # @!attribute [r] limit
          #   Number of messages to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :limit

          # @!attribute [r] order
          #   Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #     for descending order. Defaults to `asc`.
          #
          #   @return [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Models::Chat::Completions::MessageListParams::Order }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order]
          #   attr_writer :order

          # @!parse
          #   # @param after [String]
          #   # @param limit [Integer]
          #   # @param order [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(after: nil, limit: nil, order: nil, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #   for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Enum

            ASC = :asc
            DESC = :desc

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end
  end
end
