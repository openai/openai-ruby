# typed: strong

module OpenAI
  module Resources
    class Audio
      class Speech
        # Generates audio from the input text.
        sig do
          params(
            input: String,
            model: T.any(String, OpenAI::Audio::SpeechModel::OrSymbol),
            voice:
              T.any(String, OpenAI::Audio::SpeechCreateParams::Voice::OrSymbol),
            instructions: String,
            response_format:
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::OrSymbol,
            speed: Float,
            stream_format:
              OpenAI::Audio::SpeechCreateParams::StreamFormat::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(StringIO)
        end
        def create(
          # The text to generate audio for. The maximum length is 4096 characters.
          input:,
          # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
          # `tts-1`, `tts-1-hd`, `gpt-4o-mini-tts`, or `gpt-4o-mini-tts-2025-12-15`.
          model:,
          # The voice to use when generating the audio. Supported built-in voices are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`,
          # `shimmer`, `verse`, `marin`, and `cedar`. Previews of the voices are available
          # in the
          # [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
          voice:,
          # Control the voice of your generated audio with additional instructions. Does not
          # work with `tts-1` or `tts-1-hd`.
          instructions: nil,
          # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
          # `wav`, and `pcm`.
          response_format: nil,
          # The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
          # the default.
          speed: nil,
          # The format to stream the audio in. Supported formats are `sse` and `audio`.
          # `sse` is not supported for `tts-1` or `tts-1-hd`.
          stream_format: nil,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
