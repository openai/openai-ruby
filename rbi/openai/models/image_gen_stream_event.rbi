# typed: strong

module OpenAI
  module Models
    # Emitted when a partial image is available during image generation streaming.
    module ImageGenStreamEvent
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            OpenAI::ImageGenPartialImageEvent,
            OpenAI::ImageGenCompletedEvent
          )
        end

      sig { override.returns(T::Array[OpenAI::ImageGenStreamEvent::Variants]) }
      def self.variants
      end
    end
  end
end
