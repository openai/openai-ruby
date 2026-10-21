# typed: strong

module OpenAI
  module Models

    module Audio

      class VoiceConsent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::VoiceConsent,
            OpenAI::Internal::AnyHash
          )
        end

        # The consent recording identifier.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the consent recording was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The BCP 47 language tag for the consent phrase (for example, `en-US`).
        sig { returns(String) }
        attr_accessor :language

        # The label provided when the consent recording was uploaded.
        sig { returns(String) }
        attr_accessor :name

        # The object type, which is always `audio.voice_consent`.
        sig { returns(Symbol) }
        attr_accessor :object

        # A consent recording used to authorize creation of a custom voice.
        sig do
          params(

            id: String,

            created_at: Integer,

            language: String,

            name: String,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The consent recording identifier.
          id:,

          # The Unix timestamp (in seconds) for when the consent recording was created.
          created_at:,

          # The BCP 47 language tag for the consent phrase (for example, `en-US`).
          language:,

          # The label provided when the consent recording was uploaded.
          name:,

          # The object type, which is always `audio.voice_consent`.

          object: :"audio.voice_consent"
        )
        end

        sig do
          override.returns(
            {id: String, created_at: Integer, language: String, name: String, object: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
