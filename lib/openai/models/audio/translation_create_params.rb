# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranslationCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute file
        #   The audio file object (not file name) translate, in one of these formats: flac,
        #     mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        #
        #   @return [IO, StringIO]
        required :file, IO

        # @!attribute model
        #   ID of the model to use. Only `whisper-1` (which is powered by our open source
        #     Whisper V2 model) is currently available.
        #
        #   @return [String, Symbol, OpenAI::Models::AudioModel]
        required :model, union: -> { OpenAI::Models::Audio::TranslationCreateParams::Model }

        # @!attribute [r] prompt
        #   An optional text to guide the model's style or continue a previous audio
        #     segment. The
        #     [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #     should be in English.
        #
        #   @return [String, nil]
        optional :prompt, String

        # @!parse
        #   # @return [String]
        #   attr_writer :prompt

        # @!attribute [r] response_format
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #     `verbose_json`, or `vtt`.
        #
        #   @return [Symbol, OpenAI::Models::AudioResponseFormat, nil]
        optional :response_format, enum: -> { OpenAI::Models::AudioResponseFormat }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::AudioResponseFormat]
        #   attr_writer :response_format

        # @!attribute [r] temperature
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #     output more random, while lower values like 0.2 will make it more focused and
        #     deterministic. If set to 0, the model will use
        #     [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #     automatically increase the temperature until certain thresholds are hit.
        #
        #   @return [Float, nil]
        optional :temperature, Float

        # @!parse
        #   # @return [Float]
        #   attr_writer :temperature

        # @!parse
        #   # @param file [IO, StringIO]
        #   # @param model [String, Symbol, OpenAI::Models::AudioModel]
        #   # @param prompt [String]
        #   # @param response_format [Symbol, OpenAI::Models::AudioResponseFormat]
        #   # @param temperature [Float]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        #   Whisper V2 model) is currently available.
        class Model < OpenAI::Union
          variant String

          # ID of the model to use. Only `whisper-1` (which is powered by our open source Whisper V2 model) is currently available.
          variant enum: -> { OpenAI::Models::AudioModel }

          # @!parse
          #   class << self
          #     # @return [Array(String, Symbol, OpenAI::Models::AudioModel)]
          #     def variants; end
          #   end
        end
      end
    end
  end
end
