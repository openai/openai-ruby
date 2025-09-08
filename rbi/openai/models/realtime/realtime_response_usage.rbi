# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseUsage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeResponseUsage,
              OpenAI::Internal::AnyHash
            )
          end

        # Details about the input tokens used in the Response. Cached tokens are tokens
        # from previous turns in the conversation that are included as context for the
        # current response. Cached tokens here are counted as a subset of input tokens,
        # meaning input tokens will include cached and uncached tokens.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails)
          )
        end
        attr_reader :input_token_details

        sig do
          params(
            input_token_details:
              OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::OrHash
          ).void
        end
        attr_writer :input_token_details

        # The number of input tokens used in the Response, including text and audio
        # tokens.
        sig { returns(T.nilable(Integer)) }
        attr_reader :input_tokens

        sig { params(input_tokens: Integer).void }
        attr_writer :input_tokens

        # Details about the output tokens used in the Response.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeResponseUsageOutputTokenDetails)
          )
        end
        attr_reader :output_token_details

        sig do
          params(
            output_token_details:
              OpenAI::Realtime::RealtimeResponseUsageOutputTokenDetails::OrHash
          ).void
        end
        attr_writer :output_token_details

        # The number of output tokens sent in the Response, including text and audio
        # tokens.
        sig { returns(T.nilable(Integer)) }
        attr_reader :output_tokens

        sig { params(output_tokens: Integer).void }
        attr_writer :output_tokens

        # The total number of tokens in the Response including input and output text and
        # audio tokens.
        sig { returns(T.nilable(Integer)) }
        attr_reader :total_tokens

        sig { params(total_tokens: Integer).void }
        attr_writer :total_tokens

        # Usage statistics for the Response, this will correspond to billing. A Realtime
        # API session will maintain a conversation context and append new Items to the
        # Conversation, thus output from previous turns (text and audio tokens) will
        # become the input for later turns.
        sig do
          params(
            input_token_details:
              OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::OrHash,
            input_tokens: Integer,
            output_token_details:
              OpenAI::Realtime::RealtimeResponseUsageOutputTokenDetails::OrHash,
            output_tokens: Integer,
            total_tokens: Integer
          ).returns(T.attached_class)
        end
        def self.new(
          # Details about the input tokens used in the Response. Cached tokens are tokens
          # from previous turns in the conversation that are included as context for the
          # current response. Cached tokens here are counted as a subset of input tokens,
          # meaning input tokens will include cached and uncached tokens.
          input_token_details: nil,
          # The number of input tokens used in the Response, including text and audio
          # tokens.
          input_tokens: nil,
          # Details about the output tokens used in the Response.
          output_token_details: nil,
          # The number of output tokens sent in the Response, including text and audio
          # tokens.
          output_tokens: nil,
          # The total number of tokens in the Response including input and output text and
          # audio tokens.
          total_tokens: nil
        )
        end

        sig do
          override.returns(
            {
              input_token_details:
                OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails,
              input_tokens: Integer,
              output_token_details:
                OpenAI::Realtime::RealtimeResponseUsageOutputTokenDetails,
              output_tokens: Integer,
              total_tokens: Integer
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
