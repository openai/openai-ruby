# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      module Completions
        # @see OpenAI::Resources::Chat::Completions::Messages#list
        class MessageListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   Identifier for the last message from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   Number of messages to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #   for descending order. Defaults to `asc`.
          #
          #   @return [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Models::Chat::Completions::MessageListParams::Order }

          # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
          #   @param after [String]
          #   @param limit [Integer]
          #   @param order [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          # for descending order. Defaults to `asc`.
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
end
