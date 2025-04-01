# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Speech
        # Generates audio from the input text.
        #
        # @overload create(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, request_options: {})
        #
        # @param input [String]
        # @param model [String, Symbol, OpenAI::Models::Audio::SpeechModel]
        # @param voice [String, Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice]
        # @param instructions [String]
        # @param response_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat]
        # @param speed [Float]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [StringIO]
        #
        # @see OpenAI::Models::Audio::SpeechCreateParams
        def create(params)
          parsed, options = OpenAI::Models::Audio::SpeechCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/speech",
            headers: {"accept" => "application/octet-stream"},
            body: parsed,
            model: StringIO,
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
