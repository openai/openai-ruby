# typed: strong

module OpenAI
  module Models
    module Chat
      module Completions
        class MessageListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
          # for descending order. Defaults to `asc`.
          sig do
            returns(
              T.nilable(
                OpenAI::Chat::Completions::MessageListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order:
                OpenAI::Chat::Completions::MessageListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          sig do
            params(
              after: String,
              limit: Integer,
              order:
                OpenAI::Chat::Completions::MessageListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the last message from the previous pagination request.
            after: nil,
            # Number of messages to retrieve.
            limit: nil,
            # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
            # for descending order. Defaults to `asc`.
            order: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: String,
                limit: Integer,
                order:
                  OpenAI::Chat::Completions::MessageListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          # for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Chat::Completions::MessageListParams::Order
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC =
              T.let(
                :asc,
                OpenAI::Chat::Completions::MessageListParams::Order::TaggedSymbol
              )
            DESC =
              T.let(
                :desc,
                OpenAI::Chat::Completions::MessageListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Chat::Completions::MessageListParams::Order::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
