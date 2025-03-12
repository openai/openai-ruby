# typed: strong

module OpenAI
  module Models
    class CompletionUsage < OpenAI::BaseModel
      sig { returns(Integer) }
      def completion_tokens
      end

      sig { params(_: Integer).returns(Integer) }
      def completion_tokens=(_)
      end

      sig { returns(Integer) }
      def prompt_tokens
      end

      sig { params(_: Integer).returns(Integer) }
      def prompt_tokens=(_)
      end

      sig { returns(Integer) }
      def total_tokens
      end

      sig { params(_: Integer).returns(Integer) }
      def total_tokens=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::CompletionUsage::CompletionTokensDetails)) }
      def completion_tokens_details
      end

      sig do
        params(_: OpenAI::Models::CompletionUsage::CompletionTokensDetails)
          .returns(OpenAI::Models::CompletionUsage::CompletionTokensDetails)
      end
      def completion_tokens_details=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::CompletionUsage::PromptTokensDetails)) }
      def prompt_tokens_details
      end

      sig do
        params(_: OpenAI::Models::CompletionUsage::PromptTokensDetails)
          .returns(OpenAI::Models::CompletionUsage::PromptTokensDetails)
      end
      def prompt_tokens_details=(_)
      end

      sig do
        params(
          completion_tokens: Integer,
          prompt_tokens: Integer,
          total_tokens: Integer,
          completion_tokens_details: OpenAI::Models::CompletionUsage::CompletionTokensDetails,
          prompt_tokens_details: OpenAI::Models::CompletionUsage::PromptTokensDetails
        )
          .returns(T.attached_class)
      end
      def self.new(
        completion_tokens:,
        prompt_tokens:,
        total_tokens:,
        completion_tokens_details: nil,
        prompt_tokens_details: nil
      )
      end

      sig do
        override
          .returns(
            {
              completion_tokens: Integer,
              prompt_tokens: Integer,
              total_tokens: Integer,
              completion_tokens_details: OpenAI::Models::CompletionUsage::CompletionTokensDetails,
              prompt_tokens_details: OpenAI::Models::CompletionUsage::PromptTokensDetails
            }
          )
      end
      def to_hash
      end

      class CompletionTokensDetails < OpenAI::BaseModel
        sig { returns(T.nilable(Integer)) }
        def accepted_prediction_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def accepted_prediction_tokens=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def audio_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def audio_tokens=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def reasoning_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def reasoning_tokens=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def rejected_prediction_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def rejected_prediction_tokens=(_)
        end

        sig do
          params(
            accepted_prediction_tokens: Integer,
            audio_tokens: Integer,
            reasoning_tokens: Integer,
            rejected_prediction_tokens: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(accepted_prediction_tokens: nil, audio_tokens: nil, reasoning_tokens: nil, rejected_prediction_tokens: nil)
        end

        sig do
          override
            .returns(
              {
                accepted_prediction_tokens: Integer,
                audio_tokens: Integer,
                reasoning_tokens: Integer,
                rejected_prediction_tokens: Integer
              }
            )
        end
        def to_hash
        end
      end

      class PromptTokensDetails < OpenAI::BaseModel
        sig { returns(T.nilable(Integer)) }
        def audio_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def audio_tokens=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def cached_tokens
        end

        sig { params(_: Integer).returns(Integer) }
        def cached_tokens=(_)
        end

        sig { params(audio_tokens: Integer, cached_tokens: Integer).returns(T.attached_class) }
        def self.new(audio_tokens: nil, cached_tokens: nil)
        end

        sig { override.returns({audio_tokens: Integer, cached_tokens: Integer}) }
        def to_hash
        end
      end
    end
  end
end
