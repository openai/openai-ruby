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
          sig { returns(T.nilable(Symbol)) }
          def order
          end

          sig { params(_: Symbol).returns(Symbol) }
          def order=(_)
          end

          sig do
            params(
              after: String,
              limit: Integer,
              order: Symbol,
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
            )
              .returns(T.attached_class)
          end
          def self.new(after: nil, limit: nil, order: nil, request_options: {})
          end

          sig do
            override.returns(
              {
                after: String,
                limit: Integer,
                order: Symbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #   for descending order. Defaults to `asc`.
          class Order < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            ASC = :asc
            DESC = :desc
          end
        end
      end
    end
  end
end
