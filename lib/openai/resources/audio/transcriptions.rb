# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Transcriptions
        # See {OpenAI::Resources::Audio::Transcriptions#create_streaming} for streaming
        # counterpart.
        #
        # Transcribes audio into the input language.
        #
        # Returns a transcription object in `json`, `diarized_json`, or `verbose_json`
        # format, or a stream of transcript events.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        #
        # @overload create(file:, model:, chunking_strategy: nil, include: nil, keywords: nil, known_speaker_names: nil, known_speaker_references: nil, language: nil, languages: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart]
        #   The audio file object (not file name) to transcribe, in one of these formats:
        #   flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm. The request must include
        #   enough format metadata for the file to be identified. We recommend an
        #   extension-bearing filename and an appropriate content type.
        #
        #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
        #   content type.
        #
        # @param model [String, Symbol, OpenAI::Models::AudioModel]
        #   ID of the model to use. The options are `gpt-transcribe`, `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`, `whisper-1`
        #   (which is powered by our open source Whisper V2 model), and
        #   `gpt-4o-transcribe-diarize`.
        #
        # @param chunking_strategy [Symbol, :auto, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig, nil]
        #   Controls how the audio is cut into chunks. When set to `"auto"`, the server
        #   first normalizes loudness and then uses voice activity detection (VAD) to choose
        #   boundaries. `server_vad` object can be provided to tweak VAD detection
        #   parameters manually. If unset, the audio is transcribed as a single block.
        #   Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
        #   seconds.
        #
        # @param include [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>]
        #   Additional information to include in the transcription response. `logprobs` will
        #   return the log probabilities of the tokens in the response to understand the
        #   model's confidence in the transcription. `logprobs` only works with
        #   response_format set to `json` and only with the models `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, and `gpt-4o-mini-transcribe-2025-12-15`. This field is
        #   not supported when using `gpt-4o-transcribe-diarize`.
        #
        # @param keywords [Array<String>]
        #   Words or phrases to guide transcription of the input audio. Supported by
        #   `gpt-transcribe`.
        #
        # @param known_speaker_names [Array<String>]
        #   Optional list of speaker names that correspond to the audio samples provided in
        #   `known_speaker_references[]`. Each entry should be a short identifier (for
        #   example `customer` or `agent`). Up to 4 speakers are supported.
        #
        # @param known_speaker_references [Array<String>]
        #   Optional list of audio samples (as
        #   [data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs))
        #   that contain known speaker references matching `known_speaker_names[]`. Each
        #   sample must be between 2 and 10 seconds, and can use any of the same input audio
        #   formats supported by `file`.
        #
        # @param language [String]
        #   The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        #
        # @param languages [Array<String>]
        #   Possible languages of the input audio, in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) format.
        #   Supported by `gpt-transcribe`.
        #
        # @param prompt [String]
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://developers.openai.com/api/docs/guides/speech-to-text#prompting)
        #   should match the audio language. This field is not supported when using
        #   `gpt-4o-transcribe-diarize`.
        #
        # @param response_format [Symbol, OpenAI::Models::AudioResponseFormat]
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
        #   `gpt-4o-mini-transcribe`, the only supported format is `json`. For
        #   `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
        #   `diarized_json`, with `diarized_json` required to receive speaker annotations.
        #
        # @param temperature [Float]
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        #
        # @param timestamp_granularities [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>]
        #   The timestamp granularities to populate for this transcription.
        #   `response_format` must be set `verbose_json` to use timestamp granularities.
        #   Either or both of these options are supported: `word`, or `segment`. Note: There
        #   is no additional latency for segment timestamps, but generating word timestamps
        #   incurs additional latency. This option is not available for
        #   `gpt-4o-transcribe-diarize`.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionDiarized, OpenAI::Models::Audio::TranscriptionVerbose]
        #
        # @see OpenAI::Models::Audio::TranscriptionCreateParams
        def create(params)
          parsed, options = OpenAI::Audio::TranscriptionCreateParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#create_streaming` for the streaming use case."
            raise ArgumentError.new(message)
          end

          @client.request(
            method: :post,
            path: "audio/transcriptions",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Audio::TranscriptionCreateResponse,
            security: {bearer_auth: true},
            options: options
          )
        end

        # See {OpenAI::Resources::Audio::Transcriptions#create} for non-streaming
        # counterpart.
        #
        # Transcribes audio into the input language.
        #
        # Returns a transcription object in `json`, `diarized_json`, or `verbose_json`
        # format, or a stream of transcript events.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        #
        # @overload create_streaming(file:, model:, chunking_strategy: nil, include: nil, keywords: nil, known_speaker_names: nil, known_speaker_references: nil, language: nil, languages: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart]
        #   The audio file object (not file name) to transcribe, in one of these formats:
        #   flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm. The request must include
        #   enough format metadata for the file to be identified. We recommend an
        #   extension-bearing filename and an appropriate content type.
        #
        #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
        #   content type.
        #
        # @param model [String, Symbol, OpenAI::Models::AudioModel]
        #   ID of the model to use. The options are `gpt-transcribe`, `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`, `whisper-1`
        #   (which is powered by our open source Whisper V2 model), and
        #   `gpt-4o-transcribe-diarize`.
        #
        # @param chunking_strategy [Symbol, :auto, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig, nil]
        #   Controls how the audio is cut into chunks. When set to `"auto"`, the server
        #   first normalizes loudness and then uses voice activity detection (VAD) to choose
        #   boundaries. `server_vad` object can be provided to tweak VAD detection
        #   parameters manually. If unset, the audio is transcribed as a single block.
        #   Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
        #   seconds.
        #
        # @param include [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>]
        #   Additional information to include in the transcription response. `logprobs` will
        #   return the log probabilities of the tokens in the response to understand the
        #   model's confidence in the transcription. `logprobs` only works with
        #   response_format set to `json` and only with the models `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, and `gpt-4o-mini-transcribe-2025-12-15`. This field is
        #   not supported when using `gpt-4o-transcribe-diarize`.
        #
        # @param keywords [Array<String>]
        #   Words or phrases to guide transcription of the input audio. Supported by
        #   `gpt-transcribe`.
        #
        # @param known_speaker_names [Array<String>]
        #   Optional list of speaker names that correspond to the audio samples provided in
        #   `known_speaker_references[]`. Each entry should be a short identifier (for
        #   example `customer` or `agent`). Up to 4 speakers are supported.
        #
        # @param known_speaker_references [Array<String>]
        #   Optional list of audio samples (as
        #   [data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs))
        #   that contain known speaker references matching `known_speaker_names[]`. Each
        #   sample must be between 2 and 10 seconds, and can use any of the same input audio
        #   formats supported by `file`.
        #
        # @param language [String]
        #   The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        #
        # @param languages [Array<String>]
        #   Possible languages of the input audio, in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) format.
        #   Supported by `gpt-transcribe`.
        #
        # @param prompt [String]
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://developers.openai.com/api/docs/guides/speech-to-text#prompting)
        #   should match the audio language. This field is not supported when using
        #   `gpt-4o-transcribe-diarize`.
        #
        # @param response_format [Symbol, OpenAI::Models::AudioResponseFormat]
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
        #   `gpt-4o-mini-transcribe`, the only supported format is `json`. For
        #   `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
        #   `diarized_json`, with `diarized_json` required to receive speaker annotations.
        #
        # @param temperature [Float]
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        #
        # @param timestamp_granularities [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>]
        #   The timestamp granularities to populate for this transcription.
        #   `response_format` must be set `verbose_json` to use timestamp granularities.
        #   Either or both of these options are supported: `word`, or `segment`. Note: There
        #   is no additional latency for segment timestamps, but generating word timestamps
        #   incurs additional latency. This option is not available for
        #   `gpt-4o-transcribe-diarize`.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Models::Audio::TranscriptionTextSegmentEvent, OpenAI::Models::Audio::TranscriptionTextDeltaEvent, OpenAI::Models::Audio::TranscriptionTextDoneEvent>]
        #
        # @see OpenAI::Models::Audio::TranscriptionCreateParams
        def create_streaming(params)
          parsed, options = OpenAI::Audio::TranscriptionCreateParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#create` for the non-streaming use case."
            raise ArgumentError.new(message)
          end

          parsed.store(:stream, true)
          @client.request(
            method: :post,
            path: "audio/transcriptions",
            headers: {
              "content-type" => "multipart/form-data",
              "accept" => "text/event-stream",
              "accept-encoding" => "identity"
            },
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Audio::TranscriptionStreamEvent,
            security: {bearer_auth: true},
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
