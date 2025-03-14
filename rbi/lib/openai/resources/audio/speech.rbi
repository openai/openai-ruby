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
        def create(input:, model:, voice:, response_format: nil, speed: nil, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
