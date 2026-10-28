# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::VoiceConsents#create
      class VoiceConsentCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute language
        #   The BCP 47 language tag for the consent phrase (for example, `en-US`).
        #
        #   @return [String]
        required :language, String

        # @!attribute name
        #   The label to use for this consent recording.
        #
        #   @return [String]
        required :name, String

        # @!attribute recording
        #   The consent audio recording file. Maximum size is 10 MiB.
        #
        #   Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
        #   `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
        #
        #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
        #   content type.
        #
        #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
        required :recording, OpenAI::Internal::Type::FileInput

        # @!method initialize(language:, name:, recording:, request_options: {})
        #   @param language [String]
        #     The BCP 47 language tag for the consent phrase (for example, `en-US`).
        #
        #   @param name [String]
        #     The label to use for this consent recording.
        #
        #   @param recording [Pathname, StringIO, IO, String, OpenAI::FilePart]
        #     The consent audio recording file. Maximum size is 10 MiB.
        #
        #     Supported MIME types: `audio/mpeg`, `audio/wav`, `audio/x-wav`, `audio/ogg`,
        #     `audio/aac`, `audio/flac`, `audio/webm`, `audio/mp4`.
        #
        #     `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        #     metadata. Use `OpenAI::FilePart` when you need to override the filename or
        #     content type.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
