# typed: strong

module OpenAI
  module Resources
    class Audio
      class Speech
        # Generates audio from the input text.
        sig do
          params(
            input: String,
            model: T.any(String, Symbol),
            voice: Symbol,
            response_format: Symbol,
            speed: Float,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(T.anything)
        end
        def create(
          # The text to generate audio for. The maximum length is 4096 characters.
          input:,
          # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
          #   `tts-1` or `tts-1-hd`
          model:,
          # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
          #   `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
          #   voices are available in the
          #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
          voice:,
          # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
          #   `wav`, and `pcm`.
          response_format: nil,
          # The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
          #   the default.
          speed: nil,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
