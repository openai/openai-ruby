# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Translations
        # Translates audio into English.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        #
        # @overload create(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart]
        #   The audio file object (not file name) translate, in one of these formats: flac,
        #   mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm. The request must include enough
        #   format metadata for the file to be identified. We recommend an extension-bearing
        #   filename and an appropriate content type.
        #
        #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
        #   content type.
        #
        # @param model [String, Symbol, OpenAI::Models::AudioModel]
        #   ID of the model to use. Only `whisper-1` (which is powered by our open source
        #   Whisper V2 model) is currently available.
        #
        # @param prompt [String]
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://developers.openai.com/api/docs/guides/speech-to-text#prompting)
        #   should be in English.
        #
        # @param response_format [Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat]
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, or `vtt`.
        #
        # @param temperature [Float]
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose]
        #
        # @see OpenAI::Models::Audio::TranslationCreateParams
        def create(params)
          parsed, options = OpenAI::Audio::TranslationCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/translations",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Audio::TranslationCreateResponse,
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
