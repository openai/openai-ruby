# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#delete
    class VideoDeleteResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   Identifier of the deleted video.
      #
      #   @return [String]
      required :id, String

      # @!attribute deleted
      #   Indicates that the video resource was deleted.
      #
      #   @return [Boolean]
      required :deleted, OpenAI::Internal::Type::Boolean

      # @!attribute object
      #   The object type that signals the deletion response.
      #
      #   @return [Symbol, :"video.deleted"]
      required :object, const: :"video.deleted"

      # @!method initialize(id:, deleted:, object: :"video.deleted")
      #   Confirmation payload returned after deleting a video.
      #
      #   @param id [String] Identifier of the deleted video.
      #
      #   @param deleted [Boolean] Indicates that the video resource was deleted.
      #
      #   @param object [Symbol, :"video.deleted"] The object type that signals the deletion response.
    end
  end
end
