# typed: strong

module OpenAI
  module Models

    module Audio

      class VoiceConsentCreateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::VoiceConsentCreateParams,
            OpenAI::Internal::AnyHash
          )
        end

        # The BCP 47 language tag for the consent phrase (for example, `en-US`).
        sig { returns(String) }
        attr_accessor :language

        # The label to use for this consent recording.
        sig { returns(String) }
        attr_accessor :name

        # The consent audio recording file. Maximum size is 10 MiB.
        #
        # Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
        # `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        sig { returns(OpenAI::Internal::FileInput) }
        attr_accessor :recording

        sig do
          params(

            language: String,

            name: String,

            recording: OpenAI::Internal::FileInput,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The BCP 47 language tag for the consent phrase (for example, `en-US`).
          language:,

          # The label to use for this consent recording.
          name:,

          # The consent audio recording file. Maximum size is 10 MiB.
          #
          # Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
          # `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
          #
          # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
          # metadata. Use `OpenAI::FilePart` when you need to override the filename or
          # content type.
          recording:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              language: String,
              name: String,
              recording: OpenAI::Internal::FileInput,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
