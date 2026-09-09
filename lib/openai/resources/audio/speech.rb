# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      # Turn audio into text or text into audio.
      class Speech
        # Generates audio from the input text.
        #
        # Returns the audio file content, or a stream of audio events.
        #
        # @overload create(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, stream_format: nil, request_options: {})
        #
        # @param input [String]
        #   The text to generate audio for. The maximum length is 4096 characters.
        #
        # @param model [String, Symbol, OpenAI::Models::Audio::SpeechModel]
        #   One of the available
        #   [TTS models](https://developers.openai.com/api/docs/guides/text-to-speech):
        #   `tts-1`, `tts-1-hd`, `gpt-4o-mini-tts`, or `gpt-4o-mini-tts-2025-12-15`.
        #
        # @param voice [String, Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice::ID, OpenAI::Models::Audio::SpeechCreateParams::Voice]
        #   The voice to use when generating the audio. Supported built-in voices are
        #   `alloy`, `ash`, `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`,
        #   `shimmer`, `verse`, `marin`, and `cedar`. You may also provide a custom voice
        #   object with an `id`, for example `{ "id": "voice_1234" }`. Previews of the
        #   voices are available in the
        #   [Text to speech guide](https://developers.openai.com/api/docs/guides/text-to-speech#voice-options).
        #
        # @param instructions [String]
        #   Control the voice of your generated audio with additional instructions. Does not
        #   work with `tts-1` or `tts-1-hd`.
        #
        # @param response_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat]
        #   The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #   `wav`, and `pcm`.
        #
        # @param speed [Float]
        #   The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #   the default.
        #
        # @param stream_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::StreamFormat]
        #   The format to stream the audio in. Supported formats are `sse` and `audio`.
        #   `sse` is not supported for `tts-1` or `tts-1-hd`.
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
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
