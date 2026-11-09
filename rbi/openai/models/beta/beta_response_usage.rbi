# typed: strong

module OpenAI
  module Models

    BetaResponseUsage = Beta::BetaResponseUsage

    module Beta

      class BetaResponseUsage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseUsage,
            OpenAI::Internal::AnyHash
          )
        end

        # The number of input tokens.
        sig { returns(Integer) }
        attr_accessor :input_tokens

        # A detailed breakdown of the input tokens.
        sig { returns(OpenAI::Beta::BetaResponseUsage::InputTokensDetails) }
        attr_reader :input_tokens_details

        sig { params(input_tokens_details: OpenAI::Beta::BetaResponseUsage::InputTokensDetails::OrHash).void }
        attr_writer :input_tokens_details

        # The number of output tokens.
        sig { returns(Integer) }
        attr_accessor :output_tokens

        # A detailed breakdown of the output tokens.
        sig { returns(OpenAI::Beta::BetaResponseUsage::OutputTokensDetails) }
        attr_reader :output_tokens_details

        sig { params(output_tokens_details: OpenAI::Beta::BetaResponseUsage::OutputTokensDetails::OrHash).void }
        attr_writer :output_tokens_details

        # The total number of tokens used.
        sig { returns(Integer) }
        attr_accessor :total_tokens

        # Represents token usage details including input tokens, output tokens, a
        # breakdown of output tokens, and the total tokens used.
        sig do
          params(

            input_tokens: Integer,

            input_tokens_details: OpenAI::Beta::BetaResponseUsage::InputTokensDetails::OrHash,

            output_tokens: Integer,

            output_tokens_details: OpenAI::Beta::BetaResponseUsage::OutputTokensDetails::OrHash,

            total_tokens: Integer
          )
            .returns(T.attached_class)
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
              input_tokens_details: OpenAI::Beta::BetaResponseUsage::InputTokensDetails,
              output_tokens: Integer,
              output_tokens_details: OpenAI::Beta::BetaResponseUsage::OutputTokensDetails,
              total_tokens: Integer
            }
          )
        end
        def to_hash
        end

        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseUsage::InputTokensDetails,
              OpenAI::Internal::AnyHash
            )
          end

          # The number of input tokens that were written to the cache.
          sig { returns(Integer) }
          attr_accessor :cache_write_tokens

          # The number of tokens that were retrieved from the cache.
          # [More on prompt caching](https://developers.openai.com/api/docs/guides/prompt-caching).
          sig { returns(Integer) }
          attr_accessor :cached_tokens

          sig { returns(T.nilable(OpenAI::Beta::BetaResponseUsage::InputTokensDetails::CacheWriteTokensDetails)) }
          attr_reader :cache_write_tokens_details

          sig {
            params(
              cache_write_tokens_details: OpenAI::Beta::BetaResponseUsage::InputTokensDetails::CacheWriteTokensDetails::OrHash
            )
              .void
          }
          attr_writer :cache_write_tokens_details

          # A detailed breakdown of the input tokens.
          sig do
            params(

              cache_write_tokens: Integer,

              cached_tokens: Integer,

              cache_write_tokens_details: OpenAI::Beta::BetaResponseUsage::InputTokensDetails::CacheWriteTokensDetails::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The number of input tokens that were written to the cache.
            cache_write_tokens:,

            # The number of tokens that were retrieved from the cache.
            # [More on prompt caching](https://developers.openai.com/api/docs/guides/prompt-caching).
            cached_tokens:,

            cache_write_tokens_details: nil
          )
          end

          sig do
            override.returns(
              {
                cache_write_tokens: Integer,
                cached_tokens: Integer,
                cache_write_tokens_details: OpenAI::Beta::BetaResponseUsage::InputTokensDetails::CacheWriteTokensDetails
              }
            )
          end
          def to_hash
          end

          class CacheWriteTokensDetails < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseUsage::InputTokensDetails::CacheWriteTokensDetails,
                OpenAI::Internal::AnyHash
              )
            end

            # The number of input tokens written with 12-hour retention.
            sig { returns(Integer) }
            attr_accessor :ttl_12h_tokens

            # The number of input tokens written with 30-minute retention.
            sig { returns(Integer) }
            attr_accessor :ttl_30m_tokens

            sig do
              params(

                ttl_12h_tokens: Integer,

                ttl_30m_tokens: Integer
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The number of input tokens written with 12-hour retention.
              ttl_12h_tokens:,

              # The number of input tokens written with 30-minute retention.

              ttl_30m_tokens:
            )
            end

            sig do
              override.returns(
                {ttl_12h_tokens: Integer, ttl_30m_tokens: Integer}
              )
            end
            def to_hash
            end

          end
        end

        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseUsage::OutputTokensDetails,
              OpenAI::Internal::AnyHash
            )
          end

          # The number of reasoning tokens.
          sig { returns(Integer) }
          attr_accessor :reasoning_tokens

          # A detailed breakdown of the output tokens.
          sig do
            params(

              reasoning_tokens: Integer
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The number of reasoning tokens.

            reasoning_tokens:
          )
          end

          sig do
            override.returns(
              {reasoning_tokens: Integer}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
