# typed: strong

module OpenAI
  module Models

    module Audio

      class VoiceCreateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::VoiceCreateParams,
            OpenAI::Internal::AnyHash
          )
        end

        # Creates a voice from a consent recording and an audio sample. Requires
        # multipart/form-data.
        sig { returns(OpenAI::Audio::VoiceCreateParams::Body::AudioSample) }
        attr_accessor :body

        sig do
          params(

            body: OpenAI::Audio::VoiceCreateParams::Body::AudioSample::OrHash,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Creates a voice from a consent recording and an audio sample. Requires
          # multipart/form-data.
          body:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {body: OpenAI::Audio::VoiceCreateParams::Body::AudioSample, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

        # Creates a voice from a consent recording and an audio sample. Requires
        # multipart/form-data.
        module Body
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { OpenAI::Audio::VoiceCreateParams::Body::AudioSample }

          class AudioSample < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Audio::VoiceCreateParams::Body::AudioSample,
                OpenAI::Internal::AnyHash
              )
            end

            # The sample audio recording file. Maximum size is 10 MiB.
            #
            # Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
            # `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
            #
            # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
            # metadata. Use `OpenAI::FilePart` when you need to override the filename or
            # content type.
            sig { returns(OpenAI::Internal::FileInput) }
            attr_accessor :audio_sample

            # The consent recording ID (for example, `cons_1234`).
            sig { returns(String) }
            attr_accessor :consent

            # The name of the new voice.
            sig { returns(String) }
            attr_accessor :name

            # The voice creation method. Defaults to `audio_sample` when omitted.
            sig { returns(T.nilable(OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type::OrSymbol)) }
            attr_reader :type

            sig { params(type: OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type::OrSymbol).void }
            attr_writer :type

            # Creates a voice from a consent recording and an audio sample. Requires
            # multipart/form-data.
            sig do
              params(

                audio_sample: OpenAI::Internal::FileInput,

                consent: String,

                name: String,

                type: OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The sample audio recording file. Maximum size is 10 MiB.
              #
              # Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
              # `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
              #
              # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
              # metadata. Use `OpenAI::FilePart` when you need to override the filename or
              # content type.
              audio_sample:,

              # The consent recording ID (for example, `cons_1234`).
              consent:,

              # The name of the new voice.
              name:,

              # The voice creation method. Defaults to `audio_sample` when omitted.

              type: nil
            )
            end

            sig do
              override.returns(
                {
                  audio_sample: OpenAI::Internal::FileInput,
                  consent: String,
                  name: String,
                  type: OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # The voice creation method. Defaults to `audio_sample` when omitted.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              AUDIO_SAMPLE = T.let(
                :audio_sample,
                OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type::TaggedSymbol
              )

              sig {
                override.returns(T::Array[OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type::TaggedSymbol])
              }
              def self.values
              end
            end
          end

          sig { override.returns(T::Array[OpenAI::Audio::VoiceCreateParams::Body::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
