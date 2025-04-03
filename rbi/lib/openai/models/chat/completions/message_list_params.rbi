# typed: strong

module OpenAI
  module Models
    module Chat
      module Completions
        class MessageListParams < OpenAI::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # Identifier for the last message from the previous pagination request.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Number of messages to retrieve.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #   for descending order. Defaults to `asc`.
          sig { returns(T.nilable(OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol).void }
          attr_writer :order

          sig do
            params(
              after: String,
              limit: Integer,
              order: OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol,
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(after: nil, limit: nil, order: nil, request_options: {})
          end

          sig do
            override
              .returns(
                {
                  after: String,
                  limit: Integer,
                  order: OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #   for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol) }

            ASC = T.let(:asc, OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol]) }
            def self.values
            end
          end
        end
      end
    end
  end
end
