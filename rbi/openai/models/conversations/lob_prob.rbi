# typed: strong

module OpenAI
  module Models
    module Conversations
      class LobProb < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Conversations::LobProb, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :token

        sig { returns(T::Array[Integer]) }
        attr_accessor :bytes

        sig { returns(Float) }
        attr_accessor :logprob

        sig { returns(T::Array[OpenAI::Conversations::TopLogProb]) }
        attr_accessor :top_logprobs

        sig do
          params(
            token: String,
            bytes: T::Array[Integer],
            logprob: Float,
            top_logprobs: T::Array[OpenAI::Conversations::TopLogProb::OrHash]
          ).returns(T.attached_class)
        end
        def self.new(token:, bytes:, logprob:, top_logprobs:)
        end

        sig do
          override.returns(
            {
              token: String,
              bytes: T::Array[Integer],
              logprob: Float,
              top_logprobs: T::Array[OpenAI::Conversations::TopLogProb]
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
