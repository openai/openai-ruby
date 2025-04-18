# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Translations#create
      class TranslationCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute file
        #   The audio file object (not file name) translate, in one of these formats: flac,
        #   mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        #
        #   @return [Pathname, StringIO]
        required :file, OpenAI::Internal::Type::IOLike

        # @!attribute model
        #   ID of the model to use. Only `whisper-1` (which is powered by our open source
        #   Whisper V2 model) is currently available.
        #
        #   @return [String, Symbol, OpenAI::Models::AudioModel]
        required :model, union: -> { OpenAI::Models::Audio::TranslationCreateParams::Model }

        # @!attribute prompt
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #   should be in English.
        #
        #   @return [String, nil]
        optional :prompt, String

        # @!attribute response_format
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, or `vtt`.
        #
        #   @return [Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat, nil]
        optional :response_format, enum: -> { OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat }

        # @!attribute temperature
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        #
        #   @return [Float, nil]
        optional :temperature, Float

        # @!method initialize(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        #   @param file [Pathname, StringIO]
        #   @param model [String, Symbol, OpenAI::Models::AudioModel]
        #   @param prompt [String]
        #   @param response_format [Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat]
        #   @param temperature [Float]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        # Whisper V2 model) is currently available.
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # ID of the model to use. Only `whisper-1` (which is powered by our open source Whisper V2 model) is currently available.
          variant enum: -> { OpenAI::Models::AudioModel }

          # @!method self.variants
          #   @return [Array(String, Symbol, OpenAI::Models::AudioModel)]
        end

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        # `verbose_json`, or `vtt`.
        module ResponseFormat
          extend OpenAI::Internal::Type::Enum

          JSON = :json
          TEXT = :text
          SRT = :srt
          VERBOSE_JSON = :verbose_json
          VTT = :vtt

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
