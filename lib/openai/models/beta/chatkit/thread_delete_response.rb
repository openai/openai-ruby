# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        # @see OpenAI::Resources::Beta::ChatKit::Threads#delete
        class ThreadDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the deleted thread.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Indicates that the thread has been deleted.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   Type discriminator that is always `chatkit.thread.deleted`.
          #
          #   @return [Symbol, :"chatkit.thread.deleted"]
          required :object, const: :"chatkit.thread.deleted"

          # @!method initialize(id:, deleted:, object: :"chatkit.thread.deleted")
          #   Confirmation payload returned after deleting a thread.
          #
          #   @param id [String] Identifier of the deleted thread.
          #
          #   @param deleted [Boolean] Indicates that the thread has been deleted.
          #
          #   @param object [Symbol, :"chatkit.thread.deleted"] Type discriminator that is always `chatkit.thread.deleted`.
        end
      end
    end
  end
end
