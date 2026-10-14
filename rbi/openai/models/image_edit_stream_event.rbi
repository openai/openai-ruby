# typed: strong

module OpenAI
  module Models
    # Emitted when a partial image is available during image editing streaming.
    module ImageEditStreamEvent
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            OpenAI::ImageEditPartialImageEvent,
            OpenAI::ImageEditCompletedEvent
          )
        end

      sig { override.returns(T::Array[OpenAI::ImageEditStreamEvent::Variants]) }
      def self.variants
      end
    end
  end
end
