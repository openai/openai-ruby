# typed: strong

module OpenAI
  module Models
    class ImageInputReferenceParam < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ImageInputReferenceParam, OpenAI::Internal::AnyHash)
        end

      sig { returns(T.nilable(String)) }
      attr_reader :file_id

      sig { params(file_id: String).void }
      attr_writer :file_id

      # A fully qualified URL or base64-encoded data URL.
      sig { returns(T.nilable(String)) }
      attr_reader :image_url

      sig { params(image_url: String).void }
      attr_writer :image_url

      sig do
        params(file_id: String, image_url: String).returns(T.attached_class)
      end
      def self.new(
        file_id: nil,
        # A fully qualified URL or base64-encoded data URL.
        image_url: nil
      )
      end

      sig { override.returns({ file_id: String, image_url: String }) }
      def to_hash
      end
    end
  end
end
