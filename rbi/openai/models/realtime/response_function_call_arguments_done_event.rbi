# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseFunctionCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The final arguments as a JSON string.
        sig { returns(String) }
        attr_accessor :arguments

        # The ID of the function call.
        sig { returns(String) }
        attr_accessor :call_id

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the function call item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the response.
        sig { returns(String) }
        attr_accessor :response_id

        # The event type, must be `response.function_call_arguments.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the model-generated function call arguments are done streaming.
        # Also emitted when a Response is interrupted, incomplete, or cancelled.
        sig do
          params(
            arguments: String,
            call_id: String,
            event_id: String,
            item_id: String,
            output_index: Integer,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The final arguments as a JSON string.
          arguments:,
          # The ID of the function call.
          call_id:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the function call item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The ID of the response.
          response_id:,
          # The event type, must be `response.function_call_arguments.done`.
          type: :"response.function_call_arguments.done"
        )
        end

        sig do
          override.returns(
            {
              arguments: String,
              call_id: String,
              event_id: String,
              item_id: String,
              output_index: Integer,
              response_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
