# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatKitAttachment < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier for the attachment.
          #
          #   @return [String]
          required :id, String

          # @!attribute mime_type
          #   MIME type of the attachment.
          #
          #   @return [String]
          required :mime_type, String

          # @!attribute name
          #   Original display name for the attachment.
          #
          #   @return [String]
          required :name, String

          # @!attribute preview_url
          #   Preview URL for rendering the attachment inline.
          #
          #   @return [String, nil]
          required :preview_url, String, nil?: true

          # @!attribute type
          #   Attachment discriminator.
          #
          #   @return [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitAttachment::Type]
          required :type, enum: -> { OpenAI::Beta::ChatKit::ChatKitAttachment::Type }

          # @!method initialize(id:, mime_type:, name:, preview_url:, type:)
          #   Attachment metadata included on thread items.
          #
          #   @param id [String] Identifier for the attachment.
          #
          #   @param mime_type [String] MIME type of the attachment.
          #
          #   @param name [String] Original display name for the attachment.
          #
          #   @param preview_url [String, nil] Preview URL for rendering the attachment inline.
          #
          #   @param type [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitAttachment::Type] Attachment discriminator.

          # Attachment discriminator.
          #
          # @see OpenAI::Models::Beta::ChatKit::ChatKitAttachment#type
          module Type
            extend OpenAI::Internal::Type::Enum

            IMAGE = :image
            FILE = :file

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end

      ChatKitAttachment = ChatKit::ChatKitAttachment
    end
  end
end
