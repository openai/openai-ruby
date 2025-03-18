# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseUsage < OpenAI::BaseModel
        # The number of input tokens.
        sig { returns(Integer) }
        def input_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def input_tokens=(_)
        end

        # A detailed breakdown of the input tokens.
        sig { returns(OpenAI::Models::Responses::ResponseUsage::InputTokensDetails) }
        def input_tokens_details
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseUsage::InputTokensDetails)
            .returns(OpenAI::Models::Responses::ResponseUsage::InputTokensDetails)
        end
        def input_tokens_details=(_)
        end

        # The number of output tokens.
        sig { returns(Integer) }
        def output_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def output_tokens=(_)
        end

        # A detailed breakdown of the output tokens.
        sig { returns(OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails) }
        def output_tokens_details
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails)
            .returns(OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails)
        end
        def output_tokens_details=(_)
        end

        # The total number of tokens used.
        sig { returns(Integer) }
        def total_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def total_tokens=(_)
        end

        # Represents token usage details including input tokens, output tokens, a
        #   breakdown of output tokens, and the total tokens used.
        sig do
          params(
            input_tokens: Integer,
            input_tokens_details: OpenAI::Models::Responses::ResponseUsage::InputTokensDetails,
            output_tokens: Integer,
            output_tokens_details: OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails,
            total_tokens: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(input_tokens:, input_tokens_details:, output_tokens:, output_tokens_details:, total_tokens:)
        end

        sig do
          override
            .returns(
              {
                input_tokens: Integer,
                input_tokens_details: OpenAI::Models::Responses::ResponseUsage::InputTokensDetails,
                output_tokens: Integer,
                output_tokens_details: OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails,
                total_tokens: Integer
              }
            )
        end
        def to_hash
        end

        class InputTokensDetails < OpenAI::BaseModel
          # The number of tokens that were retrieved from the cache.
          #   [More on prompt caching](https://platform.openai.com/docs/guides/prompt-caching).
          sig { returns(Integer) }
          def cached_tokens
          end

          sig { params(_: Integer).returns(Integer) }
          def cached_tokens=(_)
          end

          # A detailed breakdown of the input tokens.
          sig { params(cached_tokens: Integer).returns(T.attached_class) }
          def self.new(cached_tokens:)
          end

          sig { override.returns({cached_tokens: Integer}) }
          def to_hash
          end
        end

        class OutputTokensDetails < OpenAI::BaseModel
          # The number of reasoning tokens.
          sig { returns(Integer) }
          def reasoning_tokens
          end

          sig { params(_: Integer).returns(Integer) }
          def reasoning_tokens=(_)
          end

          # A detailed breakdown of the output tokens.
          sig { params(reasoning_tokens: Integer).returns(T.attached_class) }
          def self.new(reasoning_tokens:)
          end

          sig { override.returns({reasoning_tokens: Integer}) }
          def to_hash
          end
        end
      end
    end
  end
end
