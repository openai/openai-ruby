# typed: strong

module OpenAI
  module Resources
    class Audio
      class Translations
        # Translates audio into English.
        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            prompt: String,
            response_format: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
            temperature: Float,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(T.any(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose))
        end
        def create(
          # The audio file object (not file name) translate, in one of these formats: flac,
          #   mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. Only `whisper-1` (which is powered by our open source
          #   Whisper V2 model) is currently available.
          model:,
          # An optional text to guide the model's style or continue a previous audio
          #   segment. The
          #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
          #   should be in English.
          prompt: nil,
          # The format of the output, in one of these options: `json`, `text`, `srt`,
          #   `verbose_json`, or `vtt`.
          response_format: nil,
          # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
          #   output more random, while lower values like 0.2 will make it more focused and
          #   deterministic. If set to 0, the model will use
          #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
          #   automatically increase the temperature until certain thresholds are hit.
          temperature: nil,
          request_options: {}
        ); end
        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:); end
      end
    end
  end
end
