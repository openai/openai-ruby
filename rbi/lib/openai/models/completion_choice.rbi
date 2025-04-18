# typed: strong

module OpenAI
  module Models
    class CompletionChoice < OpenAI::Internal::Type::BaseModel
      # The reason the model stopped generating tokens. This will be `stop` if the model
      # hit a natural stop point or a provided stop sequence, `length` if the maximum
      # number of tokens specified in the request was reached, or `content_filter` if
      # content was omitted due to a flag from our content filters.
      sig { returns(OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol) }
      attr_accessor :finish_reason

      sig { returns(Integer) }
      attr_accessor :index

      sig { returns(T.nilable(OpenAI::Models::CompletionChoice::Logprobs)) }
      attr_reader :logprobs

      sig do
        params(logprobs: T.nilable(T.any(OpenAI::Models::CompletionChoice::Logprobs, OpenAI::Internal::AnyHash)))
          .void
      end
      attr_writer :logprobs

      sig { returns(String) }
      attr_accessor :text

      sig do
        params(
          finish_reason: OpenAI::Models::CompletionChoice::FinishReason::OrSymbol,
          index: Integer,
          logprobs: T.nilable(T.any(OpenAI::Models::CompletionChoice::Logprobs, OpenAI::Internal::AnyHash)),
          text: String
        )
          .returns(T.attached_class)
      end
      def self.new(finish_reason:, index:, logprobs:, text:); end

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
      def to_hash; end

      # The reason the model stopped generating tokens. This will be `stop` if the model
      # hit a natural stop point or a provided stop sequence, `length` if the maximum
      # number of tokens specified in the request was reached, or `content_filter` if
      # content was omitted due to a flag from our content filters.
      module FinishReason
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::CompletionChoice::FinishReason) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        STOP = T.let(:stop, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
        LENGTH = T.let(:length, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)
        CONTENT_FILTER = T.let(:content_filter, OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::CompletionChoice::FinishReason::TaggedSymbol]) }
        def self.values; end
      end

      class Logprobs < OpenAI::Internal::Type::BaseModel
        sig { returns(T.nilable(T::Array[Integer])) }
        attr_reader :text_offset

        sig { params(text_offset: T::Array[Integer]).void }
        attr_writer :text_offset

        sig { returns(T.nilable(T::Array[Float])) }
        attr_reader :token_logprobs

        sig { params(token_logprobs: T::Array[Float]).void }
        attr_writer :token_logprobs

        sig { returns(T.nilable(T::Array[String])) }
        attr_reader :tokens

        sig { params(tokens: T::Array[String]).void }
        attr_writer :tokens

        sig { returns(T.nilable(T::Array[T::Hash[Symbol, Float]])) }
        attr_reader :top_logprobs

        sig { params(top_logprobs: T::Array[T::Hash[Symbol, Float]]).void }
        attr_writer :top_logprobs

        sig do
          params(
            text_offset: T::Array[Integer],
            token_logprobs: T::Array[Float],
            tokens: T::Array[String],
            top_logprobs: T::Array[T::Hash[Symbol, Float]]
          )
            .returns(T.attached_class)
        end
        def self.new(text_offset: nil, token_logprobs: nil, tokens: nil, top_logprobs: nil); end

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
        def to_hash; end
      end
    end
  end
end
