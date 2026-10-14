# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseImageGenCallPartialImageEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseImageGenCallPartialImageEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier of the image generation item being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # Base64-encoded partial image data, suitable for rendering as an image.
        sig { returns(String) }
        attr_accessor :partial_image_b64

        # 0-based index for the partial image (backend is 1-based, but this is 0-based for
        # the user).
        sig { returns(Integer) }
        attr_accessor :partial_image_index

        # The sequence number of the image generation item being processed.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.image_generation_call.partial_image'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a partial image is available during image generation streaming.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            partial_image_b64: String,
            partial_image_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the image generation item being processed.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # Base64-encoded partial image data, suitable for rendering as an image.
          partial_image_b64:,
          # 0-based index for the partial image (backend is 1-based, but this is 0-based for
          # the user).
          partial_image_index:,
          # The sequence number of the image generation item being processed.
          sequence_number:,
          # The type of the event. Always 'response.image_generation_call.partial_image'.
          type: :"response.image_generation_call.partial_image"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              partial_image_b64: String,
              partial_image_index: Integer,
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
