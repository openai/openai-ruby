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
        sig {
          returns(
            T.any(OpenAI::Audio::VoiceCreateParams::Body::AudioSample, OpenAI::Audio::VoiceCreateParams::Body::Prompt)
          )
        }
        attr_accessor :body

        sig do
          params(

            body: T.any(
              OpenAI::Audio::VoiceCreateParams::Body::AudioSample::OrHash,
              OpenAI::Audio::VoiceCreateParams::Body::Prompt::OrHash
            ),

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
            {
              body: T.any(
                OpenAI::Audio::VoiceCreateParams::Body::AudioSample,
                OpenAI::Audio::VoiceCreateParams::Body::Prompt
              ),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Creates a voice from a consent recording and an audio sample. Requires
        # multipart/form-data.
        module Body
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(OpenAI::Audio::VoiceCreateParams::Body::AudioSample, OpenAI::Audio::VoiceCreateParams::Body::Prompt)
          }

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

          class Prompt < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Audio::VoiceCreateParams::Body::Prompt,
                OpenAI::Internal::AnyHash
              )
            end

            # The name of the new voice.
            sig { returns(String) }
            attr_accessor :name

            # A description of the desired voice. Must not contain only whitespace.
            sig { returns(String) }
            attr_accessor :prompt

            # Set to `prompt` to create a voice from a text description.
            sig { returns(OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type::OrSymbol) }
            attr_accessor :type

            # The voice creation model to use. Defaults to `auto`.
            sig { returns(T.nilable(T.any(String, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::OrSymbol))) }
            attr_reader :model

            sig { params(model: T.any(String, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::OrSymbol)).void }
            attr_writer :model

            # Optional text for the voice to speak during creation. If omitted, a script is
            # generated from the prompt. Must not be blank after trimming whitespace; scripts
            # that are too short are rejected.
            sig { returns(T.nilable(String)) }
            attr_reader :script_hint

            sig { params(script_hint: String).void }
            attr_writer :script_hint

            # Creates a synthetic voice from a text description. Supports application/json or
            # multipart/form-data.
            sig do
              params(

                name: String,

                prompt: String,

                type: OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type::OrSymbol,

                model: T.any(String, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::OrSymbol),

                script_hint: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The name of the new voice.
              name:,

              # A description of the desired voice. Must not contain only whitespace.
              prompt:,

              # Set to `prompt` to create a voice from a text description.
              type:,

              # The voice creation model to use. Defaults to `auto`.
              model: nil,

              # Optional text for the voice to speak during creation. If omitted, a script is
              # generated from the prompt. Must not be blank after trimming whitespace; scripts
              # that are too short are rejected.

              script_hint: nil
            )
            end

            sig do
              override.returns(
                {
                  name: String,
                  prompt: String,
                  type: OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type::OrSymbol,
                  model: T.any(String, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::OrSymbol),
                  script_hint: String
                }
              )
            end
            def to_hash
            end

            # Set to `prompt` to create a voice from a text description.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              PROMPT = T.let(:prompt, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type::TaggedSymbol]) }
              def self.values
              end
            end

            # The voice creation model to use. Defaults to `auto`.
            module Model
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(String, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::TaggedSymbol)
              }

              sig { override.returns(T::Array[OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::Variants]) }
              def self.variants
              end

              TaggedSymbol = T.type_alias do
                T.all(Symbol, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model)
              end

              OrSymbol = T.type_alias { T.any(Symbol, String) }

              AUTO = T.let(:auto, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::TaggedSymbol)
              MODEL_2026_10_01 = T.let(
                :"2026-10-01",
                OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::TaggedSymbol
              )

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
