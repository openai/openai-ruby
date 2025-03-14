# typed: strong

module OpenAI
  module Resources
    class Audio
      class Transcriptions
        # Transcribes audio into the input language.
        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, Symbol),
            language: String,
            prompt: String,
            response_format: Symbol,
            temperature: Float,
            timestamp_granularities: T::Array[Symbol],
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(T.any(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose))
        end
        def create(
          # The audio file object (not file name) to transcribe, in one of these formats:
          #   flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. Only `whisper-1` (which is powered by our open source
          #   Whisper V2 model) is currently available.
          model:,
          # The language of the input audio. Supplying the input language in
          #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          #   format will improve accuracy and latency.
          language: nil,
          # An optional text to guide the model's style or continue a previous audio
          #   segment. The
          #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
          #   should match the audio language.
          prompt: nil,
          # The format of the output, in one of these options: `json`, `text`, `srt`,
          #   `verbose_json`, or `vtt`.
          response_format: nil,
          # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
          #   output more random, while lower values like 0.2 will make it more focused and
          #   deterministic. If set to 0, the model will use
          #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
          #   automatically increase the temperature until certain thresholds are hit.
          temperature: nil,
          # The timestamp granularities to populate for this transcription.
          #   `response_format` must be set `verbose_json` to use timestamp granularities.
          #   Either or both of these options are supported: `word`, or `segment`. Note: There
          #   is no additional latency for segment timestamps, but generating word timestamps
          #   incurs additional latency.
          timestamp_granularities: nil,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
