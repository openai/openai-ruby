# typed: strong

module OpenAI
  module Models
    class CompletionChoice < OpenAI::BaseModel
      # The reason the model stopped generating tokens. This will be `stop` if the model
      #   hit a natural stop point or a provided stop sequence, `length` if the maximum
      #   number of tokens specified in the request was reached, or `content_filter` if
      #   content was omitted due to a flag from our content filters.
      sig { returns(Symbol) }
      def finish_reason
      end

      sig { params(_: Symbol).returns(Symbol) }
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
        params(_: T.nilable(OpenAI::Models::CompletionChoice::Logprobs))
          .returns(T.nilable(OpenAI::Models::CompletionChoice::Logprobs))
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
          finish_reason: Symbol,
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
              finish_reason: Symbol,
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
      class FinishReason < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        STOP = :stop
        LENGTH = :length
        CONTENT_FILTER = :content_filter
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
