# typed: strong

module OpenAI
  module Models
    class BatchUsage < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias { T.any(OpenAI::BatchUsage, OpenAI::Internal::AnyHash) }

      # The number of input tokens.
      sig { returns(Integer) }
      attr_accessor :input_tokens

      # A detailed breakdown of the input tokens.
      sig { returns(OpenAI::BatchUsage::InputTokensDetails) }
      attr_reader :input_tokens_details

      sig do
        params(
          input_tokens_details: OpenAI::BatchUsage::InputTokensDetails::OrHash
        ).void
      end
      attr_writer :input_tokens_details

      # The number of output tokens.
      sig { returns(Integer) }
      attr_accessor :output_tokens

      # A detailed breakdown of the output tokens.
      sig { returns(OpenAI::BatchUsage::OutputTokensDetails) }
      attr_reader :output_tokens_details

      sig do
        params(
          output_tokens_details: OpenAI::BatchUsage::OutputTokensDetails::OrHash
        ).void
      end
      attr_writer :output_tokens_details

      # The total number of tokens used.
      sig { returns(Integer) }
      attr_accessor :total_tokens

      # Represents token usage details including input tokens, output tokens, a
      # breakdown of output tokens, and the total tokens used. Only populated on batches
      # created after September 7, 2025.
      sig do
        params(
          input_tokens: Integer,
          input_tokens_details: OpenAI::BatchUsage::InputTokensDetails::OrHash,
          output_tokens: Integer,
          output_tokens_details:
            OpenAI::BatchUsage::OutputTokensDetails::OrHash,
          total_tokens: Integer
        ).returns(T.attached_class)
      end
      def self.new(
        # The number of input tokens.
        input_tokens:,
        # A detailed breakdown of the input tokens.
        input_tokens_details:,
        # The number of output tokens.
        output_tokens:,
        # A detailed breakdown of the output tokens.
        output_tokens_details:,
        # The total number of tokens used.
        total_tokens:
      )
      end

      sig do
        override.returns(
          {
            input_tokens: Integer,
            input_tokens_details: OpenAI::BatchUsage::InputTokensDetails,
            output_tokens: Integer,
            output_tokens_details: OpenAI::BatchUsage::OutputTokensDetails,
            total_tokens: Integer
          }
        )
      end
      def to_hash
      end

      class InputTokensDetails < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::BatchUsage::InputTokensDetails,
              OpenAI::Internal::AnyHash
            )
          end

        # The number of tokens that were retrieved from the cache.
        # [More on prompt caching](https://platform.openai.com/docs/guides/prompt-caching).
        sig { returns(Integer) }
        attr_accessor :cached_tokens

        # A detailed breakdown of the input tokens.
        sig { params(cached_tokens: Integer).returns(T.attached_class) }
        def self.new(
          # The number of tokens that were retrieved from the cache.
          # [More on prompt caching](https://platform.openai.com/docs/guides/prompt-caching).
          cached_tokens:
        )
        end

        sig { override.returns({ cached_tokens: Integer }) }
        def to_hash
        end
      end

      class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::BatchUsage::OutputTokensDetails,
              OpenAI::Internal::AnyHash
            )
          end

        # The number of reasoning tokens.
        sig { returns(Integer) }
        attr_accessor :reasoning_tokens

        # A detailed breakdown of the output tokens.
        sig { params(reasoning_tokens: Integer).returns(T.attached_class) }
        def self.new(
          # The number of reasoning tokens.
          reasoning_tokens:
        )
        end

        sig { override.returns({ reasoning_tokens: Integer }) }
        def to_hash
        end
      end
    end
  end
end
