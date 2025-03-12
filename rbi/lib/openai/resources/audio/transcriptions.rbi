# typed: strong

module OpenAI
  module Resources
    class Audio
      class Transcriptions
        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, Symbol),
            language: String,
            prompt: String,
            response_format: Symbol,
            temperature: Float,
            timestamp_granularities: T::Array[Symbol],
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(T.any(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose))
        end
        def create(
          file:,
          model:,
          language: nil,
          prompt: nil,
          response_format: nil,
          temperature: nil,
          timestamp_granularities: nil,
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
