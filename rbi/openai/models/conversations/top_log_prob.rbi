# typed: strong

module OpenAI
  module Models
    module Conversations
      class TopLogProb < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Conversations::TopLogProb, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :token

        sig { returns(T::Array[Integer]) }
        attr_accessor :bytes

        sig { returns(Float) }
        attr_accessor :logprob

        sig do
          params(
            token: String,
            bytes: T::Array[Integer],
            logprob: Float
          ).returns(T.attached_class)
        end
        def self.new(token:, bytes:, logprob:)
        end

        sig do
          override.returns(
            { token: String, bytes: T::Array[Integer], logprob: Float }
          )
        end
        def to_hash
        end
      end
    end
  end
end
