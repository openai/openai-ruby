# typed: strong

module OpenAI
  module Resources
    class Audio
      class Speech
        # Generates audio from the input text.
        sig do
          params(
            input: String,
            model: T.any(String, OpenAI::Models::Audio::SpeechModel::OrSymbol),
            voice: T.any(String, OpenAI::Models::Audio::SpeechCreateParams::Voice::OrSymbol),
            instructions: String,
            response_format: OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::OrSymbol,
            speed: Float,
            request_options: OpenAI::RequestOpts
          )
            .returns(StringIO)
        end
        def create(
          # The text to generate audio for. The maximum length is 4096 characters.
          input:,
          # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
          # `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
          model:,
          # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
          # `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
          # `verse`. Previews of the voices are available in the
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
          request_options: {}
        ); end
        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:); end
      end
    end
  end
end
