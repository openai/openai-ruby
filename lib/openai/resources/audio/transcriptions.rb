# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Transcriptions
        # Transcribes audio into the input language.
        #
        # @param params [OpenAI::Models::Audio::TranscriptionCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [IO, StringIO] :file The audio file object (not file name) to transcribe, in one of these formats:
        #     flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        #
        #   @option params [String, Symbol, OpenAI::Models::AudioModel] :model ID of the model to use. Only `whisper-1` (which is powered by our open source
        #     Whisper V2 model) is currently available.
        #
        #   @option params [String] :language The language of the input audio. Supplying the input language in
        #     [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #     format will improve accuracy and latency.
        #
        #   @option params [String] :prompt An optional text to guide the model's style or continue a previous audio
        #     segment. The
        #     [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #     should match the audio language.
        #
        #   @option params [Symbol, OpenAI::Models::AudioResponseFormat] :response_format The format of the output, in one of these options: `json`, `text`, `srt`,
        #     `verbose_json`, or `vtt`.
        #
        #   @option params [Float] :temperature The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #     output more random, while lower values like 0.2 will make it more focused and
        #     deterministic. If set to 0, the model will use
        #     [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #     automatically increase the temperature until certain thresholds are hit.
        #
        #   @option params [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>] :timestamp_granularities The timestamp granularities to populate for this transcription.
        #     `response_format` must be set `verbose_json` to use timestamp granularities.
        #     Either or both of these options are supported: `word`, or `segment`. Note: There
        #     is no additional latency for segment timestamps, but generating word timestamps
        #     incurs additional latency.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose]
        #
        def create(params)
          parsed, options = OpenAI::Models::Audio::TranscriptionCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/transcriptions",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Audio::TranscriptionCreateResponse,
            options: options
          )
        end

        # @param client [OpenAI::Client]
        #
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
