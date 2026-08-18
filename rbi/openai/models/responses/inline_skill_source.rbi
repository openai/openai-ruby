# typed: strong

module OpenAI
  module Models
    module Responses
      class InlineSkillSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::InlineSkillSource,
              OpenAI::Internal::AnyHash
            )
          end

        # Base64-encoded skill zip bundle.
        sig { returns(String) }
        attr_accessor :data

        # The media type of the inline skill payload. Must be `application/zip`.
        sig { returns(Symbol) }
        attr_accessor :media_type

        # The type of the inline skill source. Must be `base64`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Inline skill payload
        sig do
          params(data: String, media_type: Symbol, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # Base64-encoded skill zip bundle.
          data:,
          # The media type of the inline skill payload. Must be `application/zip`.
          media_type: :"application/zip",
          # The type of the inline skill source. Must be `base64`.
          type: :base64
        )
        end

        sig do
          override.returns({ data: String, media_type: Symbol, type: Symbol })
        end
        def to_hash
        end
      end
    end
  end
end
