# typed: strong

module OpenAI
  module Models
    BetaResponseFunctionToolCallItem = Beta::BetaResponseFunctionToolCallItem

    module Beta
      class BetaResponseFunctionToolCallItem < OpenAI::Models::Beta::BetaResponseFunctionToolCall
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFunctionToolCallItem,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the function tool call.
        sig { returns(String) }
        attr_accessor :id

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(
            OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::TaggedSymbol
          )
        end
        attr_accessor :status

        # The identifier of the actor that created the item.
        sig { returns(T.nilable(String)) }
        attr_reader :created_by

        sig { params(created_by: String).void }
        attr_writer :created_by

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        # for more information.
        sig do
          params(
            id: String,
            status:
              OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::OrSymbol,
            created_by: String
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the function tool call.
          id:,
          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          status:,
          # The identifier of the actor that created the item.
          created_by: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              status:
                OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::TaggedSymbol,
              created_by: String
            }
          )
        end
        def to_hash
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Beta::BetaResponseFunctionToolCallItem::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseFunctionToolCallItem::Status::TaggedSymbol
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
