# typed: strong

module OpenAI
  module Models
    class CompletionChoice < OpenAI::BaseModel
      # The reason the model stopped generating tokens. This will be `stop` if the model
      #   hit a natural stop point or a provided stop sequence, `length` if the maximum
      #   number of tokens specified in the request was reached, or `content_filter` if
      #   content was omitted due to a flag from our content filters.
      sig { returns(OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol) }
      def finish_reason
      end

      sig do
        params(_: OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
          .returns(OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
      end
      def finish_reason=(_)
      end

      sig { returns(Integer) }
      def index
      end

      sig { params(_: Integer).returns(Integer) }
      def index=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::CompletionChoice::Logprobs)) }
      def logprobs
      end

      sig do
        params(_: T.nilable(T.any(OpenAI::Models::CompletionChoice::Logprobs, OpenAI::Util::AnyHash)))
          .returns(T.nilable(T.any(OpenAI::Models::CompletionChoice::Logprobs, OpenAI::Util::AnyHash)))
      end
      def logprobs=(_)
      end

      sig { returns(String) }
      def text
      end

      sig { params(_: String).returns(String) }
      def text=(_)
      end

      sig do
        params(
          finish_reason: OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol,
          index: Integer,
          logprobs: T.nilable(OpenAI::Models::CompletionChoice::Logprobs),
          text: String
        )
          .returns(T.attached_class)
      end
      def self.new(finish_reason:, index:, logprobs:, text:)
      end

      sig do
        override
          .returns(
            {
              finish_reason: OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol,
              index: Integer,
              logprobs: T.nilable(OpenAI::Models::CompletionChoice::Logprobs),
              text: String
            }
          )
      end
      def to_hash
      end

      # The reason the model stopped generating tokens. This will be `stop` if the model
      #   hit a natural stop point or a provided stop sequence, `length` if the maximum
      #   number of tokens specified in the request was reached, or `content_filter` if
      #   content was omitted due to a flag from our content filters.
      module FinishReason
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::CompletionChoice::FinishReason) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol) }

        STOP = T.let(:stop, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
        LENGTH = T.let(:length, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
        CONTENT_FILTER = T.let(:content_filter, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
      end

      class Logprobs < OpenAI::BaseModel
        sig { returns(T.nilable(T::Array[Integer])) }
        def text_offset
        end

        sig { params(_: T::Array[Integer]).returns(T::Array[Integer]) }
        def text_offset=(_)
        end

        sig { returns(T.nilable(T::Array[Float])) }
        def token_logprobs
        end

        sig { params(_: T::Array[Float]).returns(T::Array[Float]) }
        def token_logprobs=(_)
        end

        sig { returns(T.nilable(T::Array[String])) }
        def tokens
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def tokens=(_)
        end

        sig { returns(T.nilable(T::Array[T::Hash[Symbol, Float]])) }
        def top_logprobs
        end

        sig { params(_: T::Array[T::Hash[Symbol, Float]]).returns(T::Array[T::Hash[Symbol, Float]]) }
        def top_logprobs=(_)
        end

        sig do
          params(
            text_offset: T::Array[Integer],
            token_logprobs: T::Array[Float],
            tokens: T::Array[String],
            top_logprobs: T::Array[T::Hash[Symbol, Float]]
          )
            .returns(T.attached_class)
        end
        def self.new(text_offset: nil, token_logprobs: nil, tokens: nil, top_logprobs: nil)
        end

        sig do
          override
            .returns(
              {
                text_offset: T::Array[Integer],
                token_logprobs: T::Array[Float],
                tokens: T::Array[String],
                top_logprobs: T::Array[T::Hash[Symbol, Float]]
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
