# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Speech
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Audio::SpeechCreateParams} for more details.
        #
        # Generates audio from the input text.
        #
        # @overload create(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, stream_format: nil, request_options: {})
        #
        # @param input [String] The text to generate audio for. The maximum length is 4096 characters.
        #
        # @param model [String, Symbol, OpenAI::Models::Audio::SpeechModel] One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #
        # @param voice [String, Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice] The voice to use when generating the audio. Supported built-in voices are `alloy
        #
        # @param instructions [String] Control the voice of your generated audio with additional instructions. Does not
        #
        # @param response_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat] The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`, `wav
        #
        # @param speed [Float] The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #
        # @param stream_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::StreamFormat] The format to stream the audio in. Supported formats are `sse` and `audio`. `sse
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [StringIO]
        #
        # @see OpenAI::Models::Audio::SpeechCreateParams
        def create(params)
          parsed, options = OpenAI::Audio::SpeechCreateParams.dump_request(params)
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
