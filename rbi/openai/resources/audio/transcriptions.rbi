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
            file: OpenAI::Internal::FileInput,
            model: T.any(String, OpenAI::AudioModel::OrSymbol),
            chunking_strategy:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::OrHash
                )
              ),
            include: T::Array[OpenAI::Audio::TranscriptionInclude::OrSymbol],
            language: String,
            prompt: String,
            response_format: OpenAI::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities:
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol
              ],
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(
            OpenAI::Models::Audio::TranscriptionCreateResponse::Variants
          )
        end
        def create(
          # The audio file object (not file name) to transcribe, in one of these formats:
          # flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. The options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
          # Whisper V2 model).
          model:,
          # Controls how the audio is cut into chunks. When set to `"auto"`, the server
          # first normalizes loudness and then uses voice activity detection (VAD) to choose
          # boundaries. `server_vad` object can be provided to tweak VAD detection
          # parameters manually. If unset, the audio is transcribed as a single block.
          chunking_strategy: nil,
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
        )
        end

        # See {OpenAI::Resources::Audio::Transcriptions#create} for non-streaming
        # counterpart.
        #
        # Transcribes audio into the input language.
        sig do
          params(
            file: OpenAI::Internal::FileInput,
            model: T.any(String, OpenAI::AudioModel::OrSymbol),
            chunking_strategy:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::OrHash
                )
              ),
            include: T::Array[OpenAI::Audio::TranscriptionInclude::OrSymbol],
            language: String,
            prompt: String,
            response_format: OpenAI::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities:
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol
              ],
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(
            OpenAI::Internal::Stream[
              OpenAI::Audio::TranscriptionStreamEvent::Variants
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
          # Controls how the audio is cut into chunks. When set to `"auto"`, the server
          # first normalizes loudness and then uses voice activity detection (VAD) to choose
          # boundaries. `server_vad` object can be provided to tweak VAD detection
          # parameters manually. If unset, the audio is transcribed as a single block.
          chunking_strategy: nil,
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
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
