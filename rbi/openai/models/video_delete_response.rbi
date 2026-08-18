# typed: strong

module OpenAI
  module Models
    class VideoDeleteResponse < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::Models::VideoDeleteResponse, OpenAI::Internal::AnyHash)
        end

      # Identifier of the deleted video.
      sig { returns(String) }
      attr_accessor :id

      # Indicates that the video resource was deleted.
      sig { returns(T::Boolean) }
      attr_accessor :deleted

      # The object type that signals the deletion response.
      sig { returns(Symbol) }
      attr_accessor :object

      # Confirmation payload returned after deleting a video.
      sig do
        params(id: String, deleted: T::Boolean, object: Symbol).returns(
          T.attached_class
        )
      end
      def self.new(
        # Identifier of the deleted video.
        id:,
        # Indicates that the video resource was deleted.
        deleted:,
        # The object type that signals the deletion response.
        object: :"video.deleted"
      )
      end

      sig do
        override.returns({ id: String, deleted: T::Boolean, object: Symbol })
      end
      def to_hash
      end
    end
  end
end
