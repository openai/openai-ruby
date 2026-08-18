# typed: strong

module OpenAI
  module Models
    module Beta
      ChatKitAttachment = ChatKit::ChatKitAttachment

      module ChatKit
        class ChatKitAttachment < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatKitAttachment,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier for the attachment.
          sig { returns(String) }
          attr_accessor :id

          # MIME type of the attachment.
          sig { returns(String) }
          attr_accessor :mime_type

          # Original display name for the attachment.
          sig { returns(String) }
          attr_accessor :name

          # Preview URL for rendering the attachment inline.
          sig { returns(T.nilable(String)) }
          attr_accessor :preview_url

          # Attachment discriminator.
          sig do
            returns(
              OpenAI::Beta::ChatKit::ChatKitAttachment::Type::TaggedSymbol
            )
          end
          attr_accessor :type

          # Attachment metadata included on thread items.
          sig do
            params(
              id: String,
              mime_type: String,
              name: String,
              preview_url: T.nilable(String),
              type: OpenAI::Beta::ChatKit::ChatKitAttachment::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the attachment.
            id:,
            # MIME type of the attachment.
            mime_type:,
            # Original display name for the attachment.
            name:,
            # Preview URL for rendering the attachment inline.
            preview_url:,
            # Attachment discriminator.
            type:
          )
          end

          sig do
            override.returns(
              {
                id: String,
                mime_type: String,
                name: String,
                preview_url: T.nilable(String),
                type:
                  OpenAI::Beta::ChatKit::ChatKitAttachment::Type::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          # Attachment discriminator.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::ChatKit::ChatKitAttachment::Type)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IMAGE =
              T.let(
                :image,
                OpenAI::Beta::ChatKit::ChatKitAttachment::Type::TaggedSymbol
              )
            FILE =
              T.let(
                :file,
                OpenAI::Beta::ChatKit::ChatKitAttachment::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ChatKit::ChatKitAttachment::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
