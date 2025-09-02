# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeConversationItemFunctionCallOutput < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the function call this output is for.
        sig { returns(String) }
        attr_accessor :call_id

        # The output of the function call.
        sig { returns(String) }
        attr_accessor :output

        # The type of the item. Always `function_call_output`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the item.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # Identifier for the API object being returned - always `realtime.item`.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object::OrSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # The status of the item. Has no effect on the conversation.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::OrSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # A function call output item in a Realtime conversation.
        sig do
          params(
            call_id: String,
            output: String,
            id: String,
            object:
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object::OrSymbol,
            status:
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the function call this output is for.
          call_id:,
          # The output of the function call.
          output:,
          # The unique ID of the item.
          id: nil,
          # Identifier for the API object being returned - always `realtime.item`.
          object: nil,
          # The status of the item. Has no effect on the conversation.
          status: nil,
          # The type of the item. Always `function_call_output`.
          type: :function_call_output
        )
        end

        sig do
          override.returns(
            {
              call_id: String,
              output: String,
              type: Symbol,
              id: String,
              object:
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object::OrSymbol,
              status:
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::OrSymbol
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
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          REALTIME_ITEM =
            T.let(
              :"realtime.item",
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Object::TaggedSymbol
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
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED =
            T.let(
              :completed,
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::TaggedSymbol
            )
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::Status::TaggedSymbol
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
