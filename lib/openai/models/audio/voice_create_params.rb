# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Voices#create
      class VoiceCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute body
        #   Creates a voice from a consent recording and an audio sample. Requires
        #   multipart/form-data.
        #
        #   @return [OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt]
        required :body, union: -> { OpenAI::Audio::VoiceCreateParams::Body }

        # @!method initialize(body:, request_options: {})
        #   @param body [OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt]
        #     Creates a voice from a consent recording and an audio sample. Requires
        #     multipart/form-data.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Creates a voice from a consent recording and an audio sample. Requires
        # multipart/form-data.
        module Body
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # @api private
          def self.resolve_variant(value)
            if value.is_a?(Hash) && !value.key?(:type) && !value.key?("type")
              OpenAI::Audio::VoiceCreateParams::Body::AudioSample
            else
              super
            end
          end

          private_class_method :resolve_variant

          # Creates a voice from a consent recording and an audio sample. Requires multipart/form-data.
          variant :audio_sample, -> { OpenAI::Audio::VoiceCreateParams::Body::AudioSample }

          # Creates a synthetic voice from a text description. Supports application/json or multipart/form-data.
          variant :prompt, -> { OpenAI::Audio::VoiceCreateParams::Body::Prompt }

          class AudioSample < OpenAI::Internal::Type::BaseModel
            # @!attribute audio_sample
            #   The sample audio recording file. Maximum size is 10 MiB.
            #
            #   Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
            #   `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
            #
            #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
            #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
            #   content type.
            #
            #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
            required :audio_sample, OpenAI::Internal::Type::FileInput

            # @!attribute consent
            #   The consent recording ID (for example, `cons_1234`).
            #
            #   @return [String]
            required :consent, String

            # @!attribute name
            #   The name of the new voice.
            #
            #   @return [String]
            required :name, String

            # @!attribute type
            #   The voice creation method. Defaults to `audio_sample` when omitted.
            #
            #   @return [Symbol, OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample::Type, nil]
            optional :type, enum: -> { OpenAI::Audio::VoiceCreateParams::Body::AudioSample::Type }

            # @!method initialize(audio_sample:, consent:, name:, type: nil)
            #   Creates a voice from a consent recording and an audio sample. Requires
            #   multipart/form-data.
            #
            #   @param audio_sample [Pathname, StringIO, IO, String, OpenAI::FilePart]
            #     The sample audio recording file. Maximum size is 10 MiB.
            #
            #     Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
            #     `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
            #
            #     `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
            #     metadata. Use `OpenAI::FilePart` when you need to override the filename or
            #     content type.
            #
            #   @param consent [String]
            #     The consent recording ID (for example, `cons_1234`).
            #
            #   @param name [String]
            #     The name of the new voice.
            #
            #   @param type [Symbol, OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample::Type]
            #     The voice creation method. Defaults to `audio_sample` when omitted.

            # The voice creation method. Defaults to `audio_sample` when omitted.
            #
            # @see OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample#type
            module Type
              extend OpenAI::Internal::Type::Enum

              AUDIO_SAMPLE = :audio_sample

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class Prompt < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #   The name of the new voice.
            #
            #   @return [String]
            required :name, String

            # @!attribute prompt
            #   A description of the desired voice. Must not contain only whitespace.
            #
            #   @return [String]
            required :prompt, String

            # @!attribute type
            #   Set to `prompt` to create a voice from a text description.
            #
            #   @return [Symbol, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt::Type]
            required :type, enum: -> { OpenAI::Audio::VoiceCreateParams::Body::Prompt::Type }

            # @!attribute model
            #   The voice creation model to use. Defaults to `auto`.
            #
            #   @return [String, Symbol, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt::Model, nil]
            optional :model, union: -> { OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model }

            # @!attribute script_hint
            #   Optional text for the voice to speak during creation. If omitted, a script is
            #   generated from the prompt. Must not be blank after trimming whitespace; scripts
            #   that are too short are rejected.
            #
            #   @return [String, nil]
            optional :script_hint, String

            # @!method initialize(name:, prompt:, type:, model: nil, script_hint: nil)
            #   Creates a synthetic voice from a text description. Supports application/json or
            #   multipart/form-data.
            #
            #   @param name [String]
            #     The name of the new voice.
            #
            #   @param prompt [String]
            #     A description of the desired voice. Must not contain only whitespace.
            #
            #   @param type [Symbol, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt::Type]
            #     Set to `prompt` to create a voice from a text description.
            #
            #   @param model [String, Symbol, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt::Model]
            #     The voice creation model to use. Defaults to `auto`.
            #
            #   @param script_hint [String]
            #     Optional text for the voice to speak during creation. If omitted, a script is
            #     generated from the prompt. Must not be blank after trimming whitespace; scripts
            #     that are too short are rejected.

            # Set to `prompt` to create a voice from a text description.
            #
            # @see OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt#type
            module Type
              extend OpenAI::Internal::Type::Enum

              PROMPT = :prompt

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # The voice creation model to use. Defaults to `auto`.
            #
            # @see OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt#model
            module Model
              extend OpenAI::Internal::Type::Union

              variant String

              variant const: -> { OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt::Model::AUTO }

              variant const: -> { OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt::Model::MODEL_2026_10_01 }

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(String, OpenAI::Audio::VoiceCreateParams::Body::Prompt::Model::TaggedSymbol) }
              end

              # @!group

              AUTO = :auto
              MODEL_2026_10_01 = :"2026-10-01"

              # @!endgroup
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample, OpenAI::Models::Audio::VoiceCreateParams::Body::Prompt)]
        end
      end
    end
  end
end
