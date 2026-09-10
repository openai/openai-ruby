# typed: strong

module OpenAI
  module Models

    module Beta

      class InlineCapabilitySourceParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::InlineCapabilitySourceParam,
            OpenAI::Internal::AnyHash
          )
        end

        # Standard-base64 encoded ZIP archive bytes.
        sig { returns(String) }
        attr_accessor :data

        # The archive media type, always `application/zip`.
        sig { returns(Symbol) }
        attr_accessor :media_type

        # The type of the object. Always `base64`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Provides ZIP bytes encoded with standard base64.
        sig do
          params(

            data: String,

            media_type: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Standard-base64 encoded ZIP archive bytes.
          data:,

          # The archive media type, always `application/zip`.
          media_type: :"application/zip",

          # The type of the object. Always `base64`.

          type: :base64
        )
        end

        sig do
          override.returns(
            {data: String, media_type: Symbol, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
