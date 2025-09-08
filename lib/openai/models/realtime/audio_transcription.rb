# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class AudioTranscription < OpenAI::Internal::Type::BaseModel
        # @!attribute language
        #   The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        #
        #   @return [String, nil]
        optional :language, String

        # @!attribute model
        #   The model to use for transcription. Current options are `whisper-1`,
        #   `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, and `gpt-4o-transcribe`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::AudioTranscription::Model, nil]
        optional :model, enum: -> { OpenAI::Realtime::AudioTranscription::Model }

        # @!attribute prompt
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. For `whisper-1`, the
        #   [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
        #   For `gpt-4o-transcribe` models, the prompt is a free text string, for example
        #   "expect words related to technology".
        #
        #   @return [String, nil]
        optional :prompt, String

        # @!method initialize(language: nil, model: nil, prompt: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::AudioTranscription} for more details.
        #
        #   @param language [String] The language of the input audio. Supplying the input language in
        #
        #   @param model [Symbol, OpenAI::Models::Realtime::AudioTranscription::Model] The model to use for transcription. Current options are `whisper-1`, `gpt-4o-tra
        #
        #   @param prompt [String] An optional text to guide the model's style or continue a previous audio

        # The model to use for transcription. Current options are `whisper-1`,
        # `gpt-4o-transcribe-latest`, `gpt-4o-mini-transcribe`, and `gpt-4o-transcribe`.
        #
        # @see OpenAI::Models::Realtime::AudioTranscription#model
        module Model
          extend OpenAI::Internal::Type::Enum

          WHISPER_1 = :"whisper-1"
          GPT_4O_TRANSCRIBE_LATEST = :"gpt-4o-transcribe-latest"
          GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
          GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
