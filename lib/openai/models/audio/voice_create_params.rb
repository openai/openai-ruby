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
        #   @return [OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample]
        required :body, union: -> { OpenAI::Audio::VoiceCreateParams::Body }

        # @!method initialize(body:, request_options: {})
        #   @param body [OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample]
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

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Audio::VoiceCreateParams::Body::AudioSample)]
        end
      end
    end
  end
end
