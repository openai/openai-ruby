# typed: strong

module OpenAI
  module Models
    module Realtime
      class LogProbProperties < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::LogProbProperties,
              OpenAI::Internal::AnyHash
            )
          end

        # The token that was used to generate the log probability.
        sig { returns(String) }
        attr_accessor :token

        # The bytes that were used to generate the log probability.
        sig { returns(T::Array[Integer]) }
        attr_accessor :bytes

        # The log probability of the token.
        sig { returns(Float) }
        attr_accessor :logprob

        # A log probability object.
        sig do
          params(
            token: String,
            bytes: T::Array[Integer],
            logprob: Float
          ).returns(T.attached_class)
        end
        def self.new(
          # The token that was used to generate the log probability.
          token:,
          # The bytes that were used to generate the log probability.
          bytes:,
          # The log probability of the token.
          logprob:
        )
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
