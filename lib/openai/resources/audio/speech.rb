# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Speech
        # Returns a wrapper that exposes the raw HTTP response for each request.
        #
        # @return [Speech::WithRawResponse]
        def with_raw_response
          WithRawResponse.new(
            resource: Speech.new(
              client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
            )
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Audio::SpeechCreateParams} for more details.
        #
        # Generates audio from the input text.
        #
        # Returns the audio file content, or a stream of audio events.
        #
        # @overload create(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, stream_format: nil, request_options: {})
        #
        # @param input [String] The text to generate audio for. The maximum length is 4096 characters.
        #
        # @param model [String, Symbol, OpenAI::Models::Audio::SpeechModel] One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #
        # @param voice [String, Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice::ID, OpenAI::Models::Audio::SpeechCreateParams::Voice] The voice to use when generating the audio. Supported built-in voices are `alloy
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
          # @param resource [Speech]
          def initialize(resource:)
            @resource = resource
          end
        end
      end
    end
  end
end
