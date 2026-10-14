# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseImageGenCallGeneratingEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseImageGenCallGeneratingEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier of the image generation item being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the image generation item being processed.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.image_generation_call.generating'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an image generation tool call is actively generating an image
        # (intermediate state).
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the image generation item being processed.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The sequence number of the image generation item being processed.
          sequence_number:,
          # The type of the event. Always 'response.image_generation_call.generating'.
          type: :"response.image_generation_call.generating"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
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
