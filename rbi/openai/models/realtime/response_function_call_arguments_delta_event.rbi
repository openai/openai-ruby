# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the function call.
        sig { returns(String) }
        attr_accessor :call_id

        # The arguments delta as a JSON string.
        sig { returns(String) }
        attr_accessor :delta

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

        # The event type, must be `response.function_call_arguments.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the model-generated function call arguments are updated.
        sig do
          params(
            call_id: String,
            delta: String,
            event_id: String,
            item_id: String,
            output_index: Integer,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the function call.
          call_id:,
          # The arguments delta as a JSON string.
          delta:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the function call item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The ID of the response.
          response_id:,
          # The event type, must be `response.function_call_arguments.delta`.
          type: :"response.function_call_arguments.delta"
        )
        end

        sig do
          override.returns(
            {
              call_id: String,
              delta: String,
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
