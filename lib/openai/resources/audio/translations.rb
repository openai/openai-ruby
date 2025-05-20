# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Translations
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Audio::TranslationCreateParams} for more details.
        #
        # Translates audio into English.
        #
        # @overload create(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The audio file object (not file name) translate, in one of these formats: flac,
        #
        # @param model [String, Symbol, OpenAI::AudioModel] ID of the model to use. Only `whisper-1` (which is powered by our open source Wh
        #
        # @param prompt [String] An optional text to guide the model's style or continue a previous audio segment
        #
        # @param response_format [Symbol, OpenAI::Audio::TranslationCreateParams::ResponseFormat] The format of the output, in one of these options: `json`, `text`, `srt`, `verbo
        #
        # @param temperature [Float] The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Audio::Translation, OpenAI::Audio::TranslationVerbose]
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
