# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Translations
        # Translates audio into English.
        #
        # @overload create(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        #
        # @param file [Pathname, StringIO]
        # @param model [String, Symbol, OpenAI::Models::AudioModel]
        # @param prompt [String]
        # @param response_format [Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat]
        # @param temperature [Float]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
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
