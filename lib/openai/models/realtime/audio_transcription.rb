# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class AudioTranscription < OpenAI::Internal::Type::BaseModel
        # @!attribute delay
        #   Controls how long the model waits before emitting transcription text. Higher
        #   values can improve transcription accuracy at the cost of latency. Only supported
        #   with `gpt-realtime-whisper` in GA Realtime sessions.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::AudioTranscription::Delay, nil]
        optional :delay, enum: -> { OpenAI::Realtime::AudioTranscription::Delay }

        # @!attribute language
        #   The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        #
        #   @return [String, nil]
        optional :language, String

        # @!attribute model
        #   The model to use for transcription. Current options are `whisper-1`,
        #   `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`,
        #   `gpt-4o-transcribe`, `gpt-4o-transcribe-diarize`, and `gpt-realtime-whisper`.
        #   Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::AudioTranscription::Model, nil]
        optional :model, union: -> { OpenAI::Realtime::AudioTranscription::Model }

        # @!attribute prompt
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. For `whisper-1`, the
        #   [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
        #   For `gpt-4o-transcribe` models (excluding `gpt-4o-transcribe-diarize`), the
        #   prompt is a free text string, for example "expect words related to technology".
        #   Prompt is not supported with `gpt-realtime-whisper` in GA Realtime sessions.
        #
        #   @return [String, nil]
        optional :prompt, String

        # @!method initialize(delay: nil, language: nil, model: nil, prompt: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::AudioTranscription} for more details.
        #
        #   @param delay [Symbol, OpenAI::Models::Realtime::AudioTranscription::Delay] Controls how long the model waits before emitting transcription text.
        #
        #   @param language [String] The language of the input audio. Supplying the input language in
        #
        #   @param model [String, Symbol, OpenAI::Models::Realtime::AudioTranscription::Model] The model to use for transcription. Current options are `whisper-1`, `gpt-4o-min
        #
        #   @param prompt [String] An optional text to guide the model's style or continue a previous audio

        # Controls how long the model waits before emitting transcription text. Higher
        # values can improve transcription accuracy at the cost of latency. Only supported
        # with `gpt-realtime-whisper` in GA Realtime sessions.
        #
        # @see OpenAI::Models::Realtime::AudioTranscription#delay
        module Delay
          extend OpenAI::Internal::Type::Enum

          MINIMAL = :minimal
          LOW = :low
          MEDIUM = :medium
          HIGH = :high
          XHIGH = :xhigh

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The model to use for transcription. Current options are `whisper-1`,
        # `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`,
        # `gpt-4o-transcribe`, `gpt-4o-transcribe-diarize`, and `gpt-realtime-whisper`.
        # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
        #
        # @see OpenAI::Models::Realtime::AudioTranscription#model
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::AudioTranscription::Model::WHISPER_1 }

          variant const: -> { OpenAI::Models::Realtime::AudioTranscription::Model::GPT_4O_MINI_TRANSCRIBE }

          variant const: -> { OpenAI::Models::Realtime::AudioTranscription::Model::GPT_4O_MINI_TRANSCRIBE_2025_12_15 }

          variant const: -> { OpenAI::Models::Realtime::AudioTranscription::Model::GPT_4O_TRANSCRIBE }

          variant const: -> { OpenAI::Models::Realtime::AudioTranscription::Model::GPT_4O_TRANSCRIBE_DIARIZE }

          variant const: -> { OpenAI::Models::Realtime::AudioTranscription::Model::GPT_REALTIME_WHISPER }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol) }
          end

          # @!group

          WHISPER_1 = :"whisper-1"
          GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
          GPT_4O_MINI_TRANSCRIBE_2025_12_15 = :"gpt-4o-mini-transcribe-2025-12-15"
          GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
          GPT_4O_TRANSCRIBE_DIARIZE = :"gpt-4o-transcribe-diarize"
          GPT_REALTIME_WHISPER = :"gpt-realtime-whisper"

          # @!endgroup
        end
      end
    end
  end
end
