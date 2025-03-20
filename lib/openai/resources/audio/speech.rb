# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Speech
        # Generates audio from the input text.
        #
        # @param params [OpenAI::Models::Audio::SpeechCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :input The text to generate audio for. The maximum length is 4096 characters.
        #
        #   @option params [String, Symbol, OpenAI::Models::Audio::SpeechModel] :model One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #     `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        #
        #   @option params [Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice] :voice The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #     `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #     voices are available in the
        #     [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        #
        #   @option params [String] :instructions Control the voice of your generated audio with additional instructions. Does not
        #     work with `tts-1` or `tts-1-hd`.
        #
        #   @option params [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat] :response_format The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #     `wav`, and `pcm`.
        #
        #   @option params [Float] :speed The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #     the default.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [Object]
        def create(params)
          parsed, options = OpenAI::Models::Audio::SpeechCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "audio/speech",
            headers: {"accept" => "application/octet-stream"},
            body: parsed,
            model: OpenAI::Unknown,
            options: options
          )
        end

        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
