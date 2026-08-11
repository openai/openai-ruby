# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Translations
        # Returns a wrapper that exposes the raw HTTP response for each request.
        #
        # @return [Translations::WithRawResponse]
        def with_raw_response
          WithRawResponse.new(
            resource: Translations.new(
              client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
            )
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Audio::TranslationCreateParams} for more details.
        #
        # Translates audio into English.
        #
        # @overload create(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The audio file object (not file name) translate, in one of these formats: flac,
        #
        # @param model [String, Symbol, OpenAI::Models::AudioModel] ID of the model to use. Only `whisper-1` (which is powered by our open source Wh
        #
        # @param prompt [String] An optional text to guide the model's style or continue a previous audio segment
        #
        # @param response_format [Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat] The format of the output, in one of these options: `json`, `text`, `srt`, `verbo
        #
        # @param temperature [Float] The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
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
        # @param client [OpenAI::Internal::Transport::RequestClient]
        def initialize(client:)
          @client = client
        end

        class WithRawResponse
          def create(params)
            @resource.create(params)
          end

          # @api private
          #
          # @param resource [Translations]
          def initialize(resource:)
            @resource = resource
          end
        end
      end
    end
  end
end
