# typed: strong

module OpenAI
  module Resources
    class Audio
      class Transcriptions
        # See {OpenAI::Resources::Audio::Transcriptions#create_streaming} for streaming
        # counterpart.
        #
        # Transcribes audio into the input language.
        sig do
          params(
            file: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            include: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol],
            language: String,
            prompt: String,
            response_format: OpenAI::Models::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol],
            stream: T.noreturn,
            request_options: OpenAI::RequestOpts
          )
            .returns(T.any(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose))
        end
        def create(
          # The audio file object (not file name) to transcribe, in one of these formats:
          # flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. The options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
          # Whisper V2 model).
          model:,
          # Additional information to include in the transcription response. `logprobs` will
          # return the log probabilities of the tokens in the response to understand the
          # model's confidence in the transcription. `logprobs` only works with
          # response_format set to `json` and only with the models `gpt-4o-transcribe` and
          # `gpt-4o-mini-transcribe`.
          include: nil,
          # The language of the input audio. Supplying the input language in
          # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          # format will improve accuracy and latency.
          language: nil,
          # An optional text to guide the model's style or continue a previous audio
          # segment. The
          # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
          # should match the audio language.
          prompt: nil,
          # The format of the output, in one of these options: `json`, `text`, `srt`,
          # `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
          # the only supported format is `json`.
          response_format: nil,
          # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
          # output more random, while lower values like 0.2 will make it more focused and
          # deterministic. If set to 0, the model will use
          # [log probability](https://en.wikipedia.org/wiki/Log_probability) to
          # automatically increase the temperature until certain thresholds are hit.
          temperature: nil,
          # The timestamp granularities to populate for this transcription.
          # `response_format` must be set `verbose_json` to use timestamp granularities.
          # Either or both of these options are supported: `word`, or `segment`. Note: There
          # is no additional latency for segment timestamps, but generating word timestamps
          # incurs additional latency.
          timestamp_granularities: nil,
          # There is no need to provide `stream:`. Instead, use `#create_streaming` or
          # `#create` for streaming and non-streaming use cases, respectively.
          stream: false,
          request_options: {}
        ); end
        # See {OpenAI::Resources::Audio::Transcriptions#create} for non-streaming
        # counterpart.
        #
        # Transcribes audio into the input language.
        sig do
          params(
            file: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            include: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol],
            language: String,
            prompt: String,
            response_format: OpenAI::Models::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol],
            stream: T.noreturn,
            request_options: OpenAI::RequestOpts
          )
            .returns(
              OpenAI::Internal::Stream[
                T.any(
                  OpenAI::Models::Audio::TranscriptionTextDeltaEvent,
                  OpenAI::Models::Audio::TranscriptionTextDoneEvent
                )
              ]
            )
        end
        def create_streaming(
          # The audio file object (not file name) to transcribe, in one of these formats:
          # flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. The options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
          # Whisper V2 model).
          model:,
          # Additional information to include in the transcription response. `logprobs` will
          # return the log probabilities of the tokens in the response to understand the
          # model's confidence in the transcription. `logprobs` only works with
          # response_format set to `json` and only with the models `gpt-4o-transcribe` and
          # `gpt-4o-mini-transcribe`.
          include: nil,
          # The language of the input audio. Supplying the input language in
          # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          # format will improve accuracy and latency.
          language: nil,
          # An optional text to guide the model's style or continue a previous audio
          # segment. The
          # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
          # should match the audio language.
          prompt: nil,
          # The format of the output, in one of these options: `json`, `text`, `srt`,
          # `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
          # the only supported format is `json`.
          response_format: nil,
          # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
          # output more random, while lower values like 0.2 will make it more focused and
          # deterministic. If set to 0, the model will use
          # [log probability](https://en.wikipedia.org/wiki/Log_probability) to
          # automatically increase the temperature until certain thresholds are hit.
          temperature: nil,
          # The timestamp granularities to populate for this transcription.
          # `response_format` must be set `verbose_json` to use timestamp granularities.
          # Either or both of these options are supported: `word`, or `segment`. Note: There
          # is no additional latency for segment timestamps, but generating word timestamps
          # incurs additional latency.
          timestamp_granularities: nil,
          # There is no need to provide `stream:`. Instead, use `#create_streaming` or
          # `#create` for streaming and non-streaming use cases, respectively.
          stream: true,
          request_options: {}
        ); end
        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:); end
      end
    end
  end
end
