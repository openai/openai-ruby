# typed: strong

module OpenAI
  module Models
    BetaResponseCustomToolCallOutputItem =
      Beta::BetaResponseCustomToolCallOutputItem

    module Beta
      class BetaResponseCustomToolCallOutputItem < OpenAI::Models::Beta::BetaResponseCustomToolCallOutput
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseCustomToolCallOutputItem,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the custom tool call output item.
        sig { returns(String) }
        attr_accessor :id

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(
            OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::TaggedSymbol
          )
        end
        attr_accessor :status

        # The identifier of the actor that created the item.
        sig { returns(T.nilable(String)) }
        attr_reader :created_by

        sig { params(created_by: String).void }
        attr_writer :created_by

        # The output of a custom tool call from your code, being sent back to the model.
        sig do
          params(
            id: String,
            status:
              OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::OrSymbol,
            created_by: String
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the custom tool call output item.
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
                OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::TaggedSymbol,
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
                OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseCustomToolCallOutputItem::Status::TaggedSymbol
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
