# typed: strong

module OpenAI
  module Models
    class CompletionCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(T.any(String, Symbol)) }
      def model
      end

      sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
      def model=(_)
      end

      sig do
        returns(T.nilable(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])))
      end
      def prompt
      end

      sig do
        params(_: T.nilable(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])))
          .returns(T.nilable(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])))
      end
      def prompt=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def best_of
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def best_of=(_)
      end

      sig { returns(T.nilable(T::Boolean)) }
      def echo
      end

      sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def echo=(_)
      end

      sig { returns(T.nilable(Float)) }
      def frequency_penalty
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def frequency_penalty=(_)
      end

      sig { returns(T.nilable(T::Hash[Symbol, Integer])) }
      def logit_bias
      end

      sig { params(_: T.nilable(T::Hash[Symbol, Integer])).returns(T.nilable(T::Hash[Symbol, Integer])) }
      def logit_bias=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def logprobs
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def logprobs=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def max_tokens
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def max_tokens=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def n
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def n=(_)
      end

      sig { returns(T.nilable(Float)) }
      def presence_penalty
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def presence_penalty=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def seed
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def seed=(_)
      end

      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def stop
      end

      sig do
        params(
          _: T.nilable(
            T.any(
              String,
              T::Array[String]
            )
          )
        ).returns(T.nilable(T.any(String, T::Array[String])))
      end
      def stop=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions)) }
      def stream_options
      end

      sig do
        params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
          .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
      end
      def stream_options=(_)
      end

      sig { returns(T.nilable(String)) }
      def suffix
      end

      sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
      def suffix=(_)
      end

      sig { returns(T.nilable(Float)) }
      def temperature
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def temperature=(_)
      end

      sig { returns(T.nilable(Float)) }
      def top_p
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def top_p=(_)
      end

      sig { returns(T.nilable(String)) }
      def user
      end

      sig { params(_: String).returns(String) }
      def user=(_)
      end

      sig do
        params(
          model: T.any(String, Symbol),
          prompt: T.nilable(
            T.any(
              String,
              T::Array[String],
              T::Array[Integer],
              T::Array[T::Array[Integer]]
            )
          ),
          best_of: T.nilable(Integer),
          echo: T.nilable(T::Boolean),
          frequency_penalty: T.nilable(Float),
          logit_bias: T.nilable(T::Hash[Symbol, Integer]),
          logprobs: T.nilable(Integer),
          max_tokens: T.nilable(Integer),
          n: T.nilable(Integer),
          presence_penalty: T.nilable(Float),
          seed: T.nilable(Integer),
          stop: T.nilable(T.any(String, T::Array[String])),
          stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
          suffix: T.nilable(String),
          temperature: T.nilable(Float),
          top_p: T.nilable(Float),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(
        model:,
        prompt:,
        best_of: nil,
        echo: nil,
        frequency_penalty: nil,
        logit_bias: nil,
        logprobs: nil,
        max_tokens: nil,
        n: nil,
        presence_penalty: nil,
        seed: nil,
        stop: nil,
        stream_options: nil,
        suffix: nil,
        temperature: nil,
        top_p: nil,
        user: nil,
        request_options: {}
      )
      end

      sig do
        override
          .returns(
            {
              model: T.any(String, Symbol),
              prompt: T.nilable(
                T.any(
                  String,
                  T::Array[String],
                  T::Array[Integer],
                  T::Array[T::Array[Integer]]
                )
              ),
              best_of: T.nilable(Integer),
              echo: T.nilable(T::Boolean),
              frequency_penalty: T.nilable(Float),
              logit_bias: T.nilable(T::Hash[Symbol, Integer]),
              logprobs: T.nilable(Integer),
              max_tokens: T.nilable(Integer),
              n: T.nilable(Integer),
              presence_penalty: T.nilable(Float),
              seed: T.nilable(Integer),
              stop: T.nilable(T.any(String, T::Array[String])),
              stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
              suffix: T.nilable(String),
              temperature: T.nilable(Float),
              top_p: T.nilable(Float),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class Model < OpenAI::Union
        abstract!

        class Preset < OpenAI::Enum
          abstract!

          GPT_3_5_TURBO_INSTRUCT = :"gpt-3.5-turbo-instruct"
          DAVINCI_002 = :"davinci-002"
          BABBAGE_002 = :"babbage-002"

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class << self
          sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
          private def variants
          end
        end
      end

      class Prompt < OpenAI::Union
        abstract!

        StringArray = T.type_alias { T::Array[String] }

        IntegerArray = T.type_alias { T::Array[Integer] }

        ArrayOfToken2DArray = T.type_alias { T::Array[T::Array[Integer]] }

        class << self
          sig do
            override
              .returns(
                [
                  [NilClass, String],
                  [NilClass, T::Array[String]],
                  [NilClass, T::Array[Integer]],
                  [NilClass, T::Array[T::Array[Integer]]]
                ]
              )
          end
          private def variants
          end
        end
      end

      class Stop < OpenAI::Union
        abstract!

        StringArray = T.type_alias { T::Array[String] }

        class << self
          sig { override.returns([[NilClass, String], [NilClass, T::Array[String]]]) }
          private def variants
          end
        end
      end
    end
  end
end
