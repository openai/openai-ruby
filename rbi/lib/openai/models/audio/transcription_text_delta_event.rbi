# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # The text delta that was additionally transcribed.
        sig { returns(String) }
        attr_accessor :delta

        # The type of the event. Always `transcript.text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The log probabilities of the delta. Only included if you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `include[]` parameter set to `logprobs`.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob])) }
        attr_reader :logprobs

        sig do
          params(
            logprobs: T::Array[T.any(OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob, OpenAI::Internal::AnyHash)]
          )
            .void
        end
        attr_writer :logprobs

        # Emitted when there is an additional text delta. This is also the first event
        #   emitted when the transcription starts. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `Stream` parameter set to `true`.
        sig do
          params(
            delta: String,
            logprobs: T::Array[T.any(OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob, OpenAI::Internal::AnyHash)],
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(delta:, logprobs: nil, type: :"transcript.text.delta"); end

        sig do
          override
            .returns(
              {delta: String, type: Symbol, logprobs: T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob]}
            )
        end
        def to_hash; end

        class Logprob < OpenAI::Internal::Type::BaseModel
          # The token that was used to generate the log probability.
          sig { returns(T.nilable(String)) }
          attr_reader :token

          sig { params(token: String).void }
          attr_writer :token

          # The bytes that were used to generate the log probability.
          sig { returns(T.nilable(T::Array[T.anything])) }
          attr_reader :bytes

          sig { params(bytes: T::Array[T.anything]).void }
          attr_writer :bytes

          # The log probability of the token.
          sig { returns(T.nilable(Float)) }
          attr_reader :logprob

          sig { params(logprob: Float).void }
          attr_writer :logprob

          sig { params(token: String, bytes: T::Array[T.anything], logprob: Float).returns(T.attached_class) }
          def self.new(token: nil, bytes: nil, logprob: nil); end

          sig { override.returns({token: String, bytes: T::Array[T.anything], logprob: Float}) }
          def to_hash; end
        end
      end
    end
  end
end
