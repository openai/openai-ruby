# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Translations
        # Translates audio into English.
        #
        # @param params [OpenAI::Models::Audio::TranslationCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [IO, StringIO] :file The audio file object (not file name) translate, in one of these formats: flac,
        #     mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        #
        #   @option params [String, Symbol, OpenAI::Models::AudioModel] :model ID of the model to use. Only `whisper-1` (which is powered by our open source
        #     Whisper V2 model) is currently available.
        #
        #   @option params [String] :prompt An optional text to guide the model's style or continue a previous audio
        #     segment. The
        #     [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #     should be in English.
        #
        #   @option params [Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat] :response_format The format of the output, in one of these options: `json`, `text`, `srt`,
        #     `verbose_json`, or `vtt`.
        #
        #   @option params [Float] :temperature The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #     output more random, while lower values like 0.2 will make it more focused and
        #     deterministic. If set to 0, the model will use
        #     [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #     automatically increase the temperature until certain thresholds are hit.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose]
        #
        # @see OpenAI::Models::Audio::TranslationCreateParams
        def create(params)
          parsed, options = OpenAI::Models::Audio::TranslationCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/translations",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Audio::TranslationCreateResponse,
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
