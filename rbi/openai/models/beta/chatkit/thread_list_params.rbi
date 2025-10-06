# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ThreadListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ThreadListParams,
                OpenAI::Internal::AnyHash
              )
            end

          # List items created after this thread item ID. Defaults to null for the first
          # page.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # List items created before this thread item ID. Defaults to null for the newest
          # results.
          sig { returns(T.nilable(String)) }
          attr_reader :before

          sig { params(before: String).void }
          attr_writer :before

          # Maximum number of thread items to return. Defaults to 20.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Sort order for results by creation time. Defaults to `desc`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ThreadListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order: OpenAI::Beta::ChatKit::ThreadListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          # Filter threads that belong to this user identifier. Defaults to null to return
          # all users.
          sig { returns(T.nilable(String)) }
          attr_reader :user

          sig { params(user: String).void }
          attr_writer :user

          sig do
            params(
              after: String,
              before: String,
              limit: Integer,
              order: OpenAI::Beta::ChatKit::ThreadListParams::Order::OrSymbol,
              user: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # List items created after this thread item ID. Defaults to null for the first
            # page.
            after: nil,
            # List items created before this thread item ID. Defaults to null for the newest
            # results.
            before: nil,
            # Maximum number of thread items to return. Defaults to 20.
            limit: nil,
            # Sort order for results by creation time. Defaults to `desc`.
            order: nil,
            # Filter threads that belong to this user identifier. Defaults to null to return
            # all users.
            user: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: String,
                before: String,
                limit: Integer,
                order: OpenAI::Beta::ChatKit::ThreadListParams::Order::OrSymbol,
                user: String,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Sort order for results by creation time. Defaults to `desc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::ChatKit::ThreadListParams::Order)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC =
              T.let(
                :asc,
                OpenAI::Beta::ChatKit::ThreadListParams::Order::TaggedSymbol
              )
            DESC =
              T.let(
                :desc,
                OpenAI::Beta::ChatKit::ThreadListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ChatKit::ThreadListParams::Order::TaggedSymbol
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
