# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageListParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # A cursor for use in pagination. `after` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #   fetch the next page of the list.
          sig { returns(T.nilable(String)) }
          def after
          end

          sig { params(_: String).returns(String) }
          def after=(_)
          end

          # A cursor for use in pagination. `before` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   starting with obj_foo, your subsequent call can include before=obj_foo in order
          #   to fetch the previous page of the list.
          sig { returns(T.nilable(String)) }
          def before
          end

          sig { params(_: String).returns(String) }
          def before=(_)
          end

          # A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          sig { returns(T.nilable(Integer)) }
          def limit
          end

          sig { params(_: Integer).returns(Integer) }
          def limit=(_)
          end

          # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #   order and `desc` for descending order.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::MessageListParams::Order::OrSymbol)) }
          def order
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::MessageListParams::Order::OrSymbol)
              .returns(OpenAI::Models::Beta::Threads::MessageListParams::Order::OrSymbol)
          end
          def order=(_)
          end

          # Filter messages by the run ID that generated them.
          sig { returns(T.nilable(String)) }
          def run_id
          end

          sig { params(_: String).returns(String) }
          def run_id=(_)
          end

          sig do
            params(
              after: String,
              before: String,
              limit: Integer,
              order: OpenAI::Models::Beta::Threads::MessageListParams::Order::OrSymbol,
              run_id: String,
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(after: nil, before: nil, limit: nil, order: nil, run_id: nil, request_options: {})
          end

          sig do
            override
              .returns(
                {
                  after: String,
                  before: String,
                  limit: Integer,
                  order: OpenAI::Models::Beta::Threads::MessageListParams::Order::OrSymbol,
                  run_id: String,
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end

          # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #   order and `desc` for descending order.
          module Order
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order::TaggedSymbol) }

            ASC = T.let(:asc, OpenAI::Models::Beta::Threads::MessageListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Models::Beta::Threads::MessageListParams::Order::TaggedSymbol)

            class << self
              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::MessageListParams::Order::TaggedSymbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
