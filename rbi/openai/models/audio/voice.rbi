# typed: strong

module OpenAI
  module Models

    module Audio

      class Voice < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::Voice,
            OpenAI::Internal::AnyHash
          )
        end

        # The voice identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the voice was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The name of the voice.
        sig { returns(String) }
        attr_accessor :name

        # The object type, which is always `audio.voice`.
        sig { returns(Symbol) }
        attr_accessor :object

        # How the voice was created. Voices created from text prompts are supported only
        # in Live.
        sig { returns(OpenAI::Audio::Voice::Type::TaggedSymbol) }
        attr_accessor :type

        # A custom voice that can be used for audio output. Voices created from text
        # prompts are supported only in Live.
        sig do
          params(

            id: String,

            created_at: Integer,

            name: String,

            type: OpenAI::Audio::Voice::Type::OrSymbol,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The voice identifier, which can be referenced in API endpoints.
          id:,

          # The Unix timestamp (in seconds) for when the voice was created.
          created_at:,

          # The name of the voice.
          name:,

          # How the voice was created. Voices created from text prompts are supported only
          # in Live.
          type:,

          # The object type, which is always `audio.voice`.

          object: :"audio.voice"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              name: String,
              object: Symbol,
              type: OpenAI::Audio::Voice::Type::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # How the voice was created. Voices created from text prompts are supported only
        # in Live.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Audio::Voice::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUDIO_SAMPLE = T.let(:audio_sample, OpenAI::Audio::Voice::Type::TaggedSymbol)
          PROMPT = T.let(:prompt, OpenAI::Audio::Voice::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Audio::Voice::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
