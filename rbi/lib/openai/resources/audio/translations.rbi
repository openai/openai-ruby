# typed: strong

module OpenAI
  module Resources
    class Audio
      class Translations
        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, Symbol),
            prompt: String,
            response_format: Symbol,
            temperature: Float,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(T.any(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose))
        end
        def create(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
