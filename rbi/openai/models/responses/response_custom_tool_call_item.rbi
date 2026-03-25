# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallItem < OpenAI::Models::Responses::ResponseCustomToolCall
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCustomToolCallItem,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the custom tool call item.
        sig { returns(String) }
        attr_accessor :id

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(
            OpenAI::Responses::ResponseCustomToolCallItem::Status::TaggedSymbol
          )
        end
        attr_accessor :status

        # The identifier of the actor that created the item.
        sig { returns(T.nilable(String)) }
        attr_reader :created_by

        sig { params(created_by: String).void }
        attr_writer :created_by

        # A call to a custom tool created by the model.
        sig do
          params(
            id: String,
            status:
              OpenAI::Responses::ResponseCustomToolCallItem::Status::OrSymbol,
            created_by: String
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the custom tool call item.
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
                OpenAI::Responses::ResponseCustomToolCallItem::Status::TaggedSymbol,
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
                OpenAI::Responses::ResponseCustomToolCallItem::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseCustomToolCallItem::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseCustomToolCallItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseCustomToolCallItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCustomToolCallItem::Status::TaggedSymbol
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
