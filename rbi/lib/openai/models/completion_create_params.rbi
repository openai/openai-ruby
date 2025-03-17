# typed: strong

module OpenAI
  module Models
    class CompletionCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      sig { returns(T.any(String, Symbol)) }
      def model
      end

      sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
      def model=(_)
      end

      # The prompt(s) to generate completions for, encoded as a string, array of
      #   strings, array of tokens, or array of token arrays.
      #
      #   Note that <|endoftext|> is the document separator that the model sees during
      #   training, so if a prompt is not specified the model will generate as if from the
      #   beginning of a new document.
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

      # Generates `best_of` completions server-side and returns the "best" (the one with
      #   the highest log probability per token). Results cannot be streamed.
      #
      #   When used with `n`, `best_of` controls the number of candidate completions and
      #   `n` specifies how many to return – `best_of` must be greater than `n`.
      #
      #   **Note:** Because this parameter generates many completions, it can quickly
      #   consume your token quota. Use carefully and ensure that you have reasonable
      #   settings for `max_tokens` and `stop`.
      sig { returns(T.nilable(Integer)) }
      def best_of
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def best_of=(_)
      end

      # Echo back the prompt in addition to the completion
      sig { returns(T.nilable(T::Boolean)) }
      def echo
      end

      sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def echo=(_)
      end

      # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
      #   existing frequency in the text so far, decreasing the model's likelihood to
      #   repeat the same line verbatim.
      #
      #   [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
      sig { returns(T.nilable(Float)) }
      def frequency_penalty
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def frequency_penalty=(_)
      end

      # Modify the likelihood of specified tokens appearing in the completion.
      #
      #   Accepts a JSON object that maps tokens (specified by their token ID in the GPT
      #   tokenizer) to an associated bias value from -100 to 100. You can use this
      #   [tokenizer tool](/tokenizer?view=bpe) to convert text to token IDs.
      #   Mathematically, the bias is added to the logits generated by the model prior to
      #   sampling. The exact effect will vary per model, but values between -1 and 1
      #   should decrease or increase likelihood of selection; values like -100 or 100
      #   should result in a ban or exclusive selection of the relevant token.
      #
      #   As an example, you can pass `{"50256": -100}` to prevent the <|endoftext|> token
      #   from being generated.
      sig { returns(T.nilable(T::Hash[Symbol, Integer])) }
      def logit_bias
      end

      sig { params(_: T.nilable(T::Hash[Symbol, Integer])).returns(T.nilable(T::Hash[Symbol, Integer])) }
      def logit_bias=(_)
      end

      # Include the log probabilities on the `logprobs` most likely output tokens, as
      #   well the chosen tokens. For example, if `logprobs` is 5, the API will return a
      #   list of the 5 most likely tokens. The API will always return the `logprob` of
      #   the sampled token, so there may be up to `logprobs+1` elements in the response.
      #
      #   The maximum value for `logprobs` is 5.
      sig { returns(T.nilable(Integer)) }
      def logprobs
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def logprobs=(_)
      end

      # The maximum number of [tokens](/tokenizer) that can be generated in the
      #   completion.
      #
      #   The token count of your prompt plus `max_tokens` cannot exceed the model's
      #   context length.
      #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #   for counting tokens.
      sig { returns(T.nilable(Integer)) }
      def max_tokens
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def max_tokens=(_)
      end

      # How many completions to generate for each prompt.
      #
      #   **Note:** Because this parameter generates many completions, it can quickly
      #   consume your token quota. Use carefully and ensure that you have reasonable
      #   settings for `max_tokens` and `stop`.
      sig { returns(T.nilable(Integer)) }
      def n
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def n=(_)
      end

      # Number between -2.0 and 2.0. Positive values penalize new tokens based on
      #   whether they appear in the text so far, increasing the model's likelihood to
      #   talk about new topics.
      #
      #   [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
      sig { returns(T.nilable(Float)) }
      def presence_penalty
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def presence_penalty=(_)
      end

      # If specified, our system will make a best effort to sample deterministically,
      #   such that repeated requests with the same `seed` and parameters should return
      #   the same result.
      #
      #   Determinism is not guaranteed, and you should refer to the `system_fingerprint`
      #   response parameter to monitor changes in the backend.
      sig { returns(T.nilable(Integer)) }
      def seed
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def seed=(_)
      end

      # Up to 4 sequences where the API will stop generating further tokens. The
      #   returned text will not contain the stop sequence.
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

      # Options for streaming response. Only set this when you set `stream: true`.
      sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions)) }
      def stream_options
      end

      sig do
        params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
          .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
      end
      def stream_options=(_)
      end

      # The suffix that comes after a completion of inserted text.
      #
      #   This parameter is only supported for `gpt-3.5-turbo-instruct`.
      sig { returns(T.nilable(String)) }
      def suffix
      end

      sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
      def suffix=(_)
      end

      # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
      #   make the output more random, while lower values like 0.2 will make it more
      #   focused and deterministic.
      #
      #   We generally recommend altering this or `top_p` but not both.
      sig { returns(T.nilable(Float)) }
      def temperature
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def temperature=(_)
      end

      # An alternative to sampling with temperature, called nucleus sampling, where the
      #   model considers the results of the tokens with top_p probability mass. So 0.1
      #   means only the tokens comprising the top 10% probability mass are considered.
      #
      #   We generally recommend altering this or `temperature` but not both.
      sig { returns(T.nilable(Float)) }
      def top_p
      end

      sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
      def top_p=(_)
      end

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
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

      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      class Model < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.any(String, Symbol)} }
      end

      # The prompt(s) to generate completions for, encoded as a string, array of
      #   strings, array of tokens, or array of token arrays.
      #
      #   Note that <|endoftext|> is the document separator that the model sees during
      #   training, so if a prompt is not specified the model will generate as if from the
      #   beginning of a new document.
      class Prompt < OpenAI::Union
        abstract!

        Variants = type_template(:out) do
          {fixed: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])}
        end

        StringArray = T.type_alias { T::Array[String] }

        IntegerArray = T.type_alias { T::Array[Integer] }

        ArrayOfToken2DArray = T.type_alias { T::Array[T::Array[Integer]] }
      end

      # Up to 4 sequences where the API will stop generating further tokens. The
      #   returned text will not contain the stop sequence.
      class Stop < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.nilable(T.any(String, T::Array[String]))} }

        StringArray = T.type_alias { T::Array[String] }
      end
    end
  end
end
