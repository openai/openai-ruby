# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemFunctionCall < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeConversationItemFunctionCall,
              OpenAI::Internal::AnyHash
            )
          end

        # The arguments of the function call.
        sig { returns(String) }
        attr_accessor :arguments

        # The name of the function being called.
        sig { returns(String) }
        attr_accessor :name

        # The type of the item. Always `function_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the item.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # The ID of the function call.
        sig { returns(T.nilable(String)) }
        attr_reader :call_id

        sig { params(call_id: String).void }
        attr_writer :call_id

        # Identifier for the API object being returned - always `realtime.item`.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object::OrSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # The status of the item. Has no effect on the conversation.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::OrSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # A function call item in a Realtime conversation.
        sig do
          params(
            arguments: String,
            name: String,
            id: String,
            call_id: String,
            object:
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object::OrSymbol,
            status:
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The arguments of the function call.
          arguments:,
          # The name of the function being called.
          name:,
          # The unique ID of the item.
          id: nil,
          # The ID of the function call.
          call_id: nil,
          # Identifier for the API object being returned - always `realtime.item`.
          object: nil,
          # The status of the item. Has no effect on the conversation.
          status: nil,
          # The type of the item. Always `function_call`.
          type: :function_call
        )
        end

        sig do
          override.returns(
            {
              arguments: String,
              name: String,
              type: Symbol,
              id: String,
              call_id: String,
              object:
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object::OrSymbol,
              status:
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::OrSymbol
            }
          )
        end
        def to_hash
        end

        # Identifier for the API object being returned - always `realtime.item`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          REALTIME_ITEM =
            T.let(
              :"realtime.item",
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::Object::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The status of the item. Has no effect on the conversation.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED =
            T.let(
              :completed,
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::TaggedSymbol
            )
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemFunctionCall::Status::TaggedSymbol
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
