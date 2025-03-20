# typed: strong

module OpenAI
  module Models
    module Chat
      module Completions
        class MessageListParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # Identifier for the last message from the previous pagination request.
          sig { returns(T.nilable(String)) }
          def after
          end

          sig { params(_: String).returns(String) }
          def after=(_)
          end

          # Number of messages to retrieve.
          sig { returns(T.nilable(Integer)) }
          def limit
          end

          sig { params(_: Integer).returns(Integer) }
          def limit=(_)
          end

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #   for descending order. Defaults to `asc`.
          sig { returns(T.nilable(OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol)) }
          def order
          end

          sig do
            params(_: OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol)
              .returns(OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol)
          end
          def order=(_)
          end

          sig do
            params(
              after: String,
              limit: Integer,
              order: OpenAI::Models::Chat::Completions::MessageListParams::Order::OrSymbol,
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
              T.type_alias { T.any(Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol) }

            ASC = T.let(:asc, OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol)

            class << self
              sig { override.returns(T::Array[OpenAI::Models::Chat::Completions::MessageListParams::Order::TaggedSymbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
