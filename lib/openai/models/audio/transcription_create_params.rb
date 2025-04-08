# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Transcriptions#create
      #
      # @see OpenAI::Resources::Audio::Transcriptions#create_streaming
      class TranscriptionCreateParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute file
        #   The audio file object (not file name) to transcribe, in one of these formats:
        #   flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        #
        #   @return [Pathname, StringIO]
        required :file, OpenAI::Internal::Type::IOLike

        # @!attribute model
        #   ID of the model to use. The options are `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        #   Whisper V2 model).
        #
        #   @return [String, Symbol, OpenAI::Models::AudioModel]
        required :model, union: -> { OpenAI::Models::Audio::TranscriptionCreateParams::Model }

        # @!attribute [r] include
        #   Additional information to include in the transcription response. `logprobs` will
        #   return the log probabilities of the tokens in the response to understand the
        #   model's confidence in the transcription. `logprobs` only works with
        #   response_format set to `json` and only with the models `gpt-4o-transcribe` and
        #   `gpt-4o-mini-transcribe`.
        #
        #   @return [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Models::Audio::TranscriptionInclude] }

        # @!parse
        #   # @return [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>]
        #   attr_writer :include

        # @!attribute [r] language
        #   The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        #
        #   @return [String, nil]
        optional :language, String

        # @!parse
        #   # @return [String]
        #   attr_writer :language

        # @!attribute [r] prompt
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #   should match the audio language.
        #
        #   @return [String, nil]
        optional :prompt, String

        # @!parse
        #   # @return [String]
        #   attr_writer :prompt

        # @!attribute [r] response_format
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
        #   the only supported format is `json`.
        #
        #   @return [Symbol, OpenAI::Models::AudioResponseFormat, nil]
        optional :response_format, enum: -> { OpenAI::Models::AudioResponseFormat }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::AudioResponseFormat]
        #   attr_writer :response_format

        # @!attribute [r] temperature
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        #
        #   @return [Float, nil]
        optional :temperature, Float

        # @!parse
        #   # @return [Float]
        #   attr_writer :temperature

        # @!attribute [r] timestamp_granularities
        #   The timestamp granularities to populate for this transcription.
        #   `response_format` must be set `verbose_json` to use timestamp granularities.
        #   Either or both of these options are supported: `word`, or `segment`. Note: There
        #   is no additional latency for segment timestamps, but generating word timestamps
        #   incurs additional latency.
        #
        #   @return [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>, nil]
        optional :timestamp_granularities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity] }

        # @!parse
        #   # @return [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>]
        #   attr_writer :timestamp_granularities

        # @!parse
        #   # @param file [Pathname, StringIO]
        #   # @param model [String, Symbol, OpenAI::Models::AudioModel]
        #   # @param include [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>]
        #   # @param language [String]
        #   # @param prompt [String]
        #   # @param response_format [Symbol, OpenAI::Models::AudioResponseFormat]
        #   # @param temperature [Float]
        #   # @param timestamp_granularities [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(
        #     file:,
        #     model:,
        #     include: nil,
        #     language: nil,
        #     prompt: nil,
        #     response_format: nil,
        #     temperature: nil,
        #     timestamp_granularities: nil,
        #     request_options: {},
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        # Whisper V2 model).
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source Whisper V2 model).
          variant enum: -> { OpenAI::Models::AudioModel }

          # @!parse
          #   # @return [Array(String, Symbol, OpenAI::Models::AudioModel)]
          #   def self.variants; end
        end

        module TimestampGranularity
          extend OpenAI::Internal::Type::Enum

          WORD = :word
          SEGMENT = :segment

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
