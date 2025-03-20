# typed: strong

module OpenAI
  module Resources
    class Completions
      # Creates a completion for the provided prompt and parameters.
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
          stream: T.noreturn,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Completion)
      end
      def create(
        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        model:,
        # The prompt(s) to generate completions for, encoded as a string, array of
        #   strings, array of tokens, or array of token arrays.
        #
        #   Note that <|endoftext|> is the document separator that the model sees during
        #   training, so if a prompt is not specified the model will generate as if from the
        #   beginning of a new document.
        prompt:,
        # Generates `best_of` completions server-side and returns the "best" (the one with
        #   the highest log probability per token). Results cannot be streamed.
        #
        #   When used with `n`, `best_of` controls the number of candidate completions and
        #   `n` specifies how many to return – `best_of` must be greater than `n`.
        #
        #   **Note:** Because this parameter generates many completions, it can quickly
        #   consume your token quota. Use carefully and ensure that you have reasonable
        #   settings for `max_tokens` and `stop`.
        best_of: nil,
        # Echo back the prompt in addition to the completion
        echo: nil,
        # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #   existing frequency in the text so far, decreasing the model's likelihood to
        #   repeat the same line verbatim.
        #
        #   [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
        frequency_penalty: nil,
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
        logit_bias: nil,
        # Include the log probabilities on the `logprobs` most likely output tokens, as
        #   well the chosen tokens. For example, if `logprobs` is 5, the API will return a
        #   list of the 5 most likely tokens. The API will always return the `logprob` of
        #   the sampled token, so there may be up to `logprobs+1` elements in the response.
        #
        #   The maximum value for `logprobs` is 5.
        logprobs: nil,
        # The maximum number of [tokens](/tokenizer) that can be generated in the
        #   completion.
        #
        #   The token count of your prompt plus `max_tokens` cannot exceed the model's
        #   context length.
        #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
        #   for counting tokens.
        max_tokens: nil,
        # How many completions to generate for each prompt.
        #
        #   **Note:** Because this parameter generates many completions, it can quickly
        #   consume your token quota. Use carefully and ensure that you have reasonable
        #   settings for `max_tokens` and `stop`.
        n: nil,
        # Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #   whether they appear in the text so far, increasing the model's likelihood to
        #   talk about new topics.
        #
        #   [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
        presence_penalty: nil,
        # If specified, our system will make a best effort to sample deterministically,
        #   such that repeated requests with the same `seed` and parameters should return
        #   the same result.
        #
        #   Determinism is not guaranteed, and you should refer to the `system_fingerprint`
        #   response parameter to monitor changes in the backend.
        seed: nil,
        # Up to 4 sequences where the API will stop generating further tokens. The
        #   returned text will not contain the stop sequence.
        stop: nil,
        # Options for streaming response. Only set this when you set `stream: true`.
        stream_options: nil,
        # The suffix that comes after a completion of inserted text.
        #
        #   This parameter is only supported for `gpt-3.5-turbo-instruct`.
        suffix: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        #   We generally recommend altering this or `top_p` but not both.
        temperature: nil,
        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        top_p: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#create_streaming` or
        #   `#create` for streaming and non-streaming use cases, respectively.
        stream: false,
        request_options: {}
      )
      end

      # Creates a completion for the provided prompt and parameters.
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
          stream: T.noreturn,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Stream[OpenAI::Models::Completion])
      end
      def create_streaming(
        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        model:,
        # The prompt(s) to generate completions for, encoded as a string, array of
        #   strings, array of tokens, or array of token arrays.
        #
        #   Note that <|endoftext|> is the document separator that the model sees during
        #   training, so if a prompt is not specified the model will generate as if from the
        #   beginning of a new document.
        prompt:,
        # Generates `best_of` completions server-side and returns the "best" (the one with
        #   the highest log probability per token). Results cannot be streamed.
        #
        #   When used with `n`, `best_of` controls the number of candidate completions and
        #   `n` specifies how many to return – `best_of` must be greater than `n`.
        #
        #   **Note:** Because this parameter generates many completions, it can quickly
        #   consume your token quota. Use carefully and ensure that you have reasonable
        #   settings for `max_tokens` and `stop`.
        best_of: nil,
        # Echo back the prompt in addition to the completion
        echo: nil,
        # Number between -2.0 and 2.0. Positive values penalize new tokens based on their
        #   existing frequency in the text so far, decreasing the model's likelihood to
        #   repeat the same line verbatim.
        #
        #   [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
        frequency_penalty: nil,
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
        logit_bias: nil,
        # Include the log probabilities on the `logprobs` most likely output tokens, as
        #   well the chosen tokens. For example, if `logprobs` is 5, the API will return a
        #   list of the 5 most likely tokens. The API will always return the `logprob` of
        #   the sampled token, so there may be up to `logprobs+1` elements in the response.
        #
        #   The maximum value for `logprobs` is 5.
        logprobs: nil,
        # The maximum number of [tokens](/tokenizer) that can be generated in the
        #   completion.
        #
        #   The token count of your prompt plus `max_tokens` cannot exceed the model's
        #   context length.
        #   [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
        #   for counting tokens.
        max_tokens: nil,
        # How many completions to generate for each prompt.
        #
        #   **Note:** Because this parameter generates many completions, it can quickly
        #   consume your token quota. Use carefully and ensure that you have reasonable
        #   settings for `max_tokens` and `stop`.
        n: nil,
        # Number between -2.0 and 2.0. Positive values penalize new tokens based on
        #   whether they appear in the text so far, increasing the model's likelihood to
        #   talk about new topics.
        #
        #   [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
        presence_penalty: nil,
        # If specified, our system will make a best effort to sample deterministically,
        #   such that repeated requests with the same `seed` and parameters should return
        #   the same result.
        #
        #   Determinism is not guaranteed, and you should refer to the `system_fingerprint`
        #   response parameter to monitor changes in the backend.
        seed: nil,
        # Up to 4 sequences where the API will stop generating further tokens. The
        #   returned text will not contain the stop sequence.
        stop: nil,
        # Options for streaming response. Only set this when you set `stream: true`.
        stream_options: nil,
        # The suffix that comes after a completion of inserted text.
        #
        #   This parameter is only supported for `gpt-3.5-turbo-instruct`.
        suffix: nil,
        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        #   We generally recommend altering this or `top_p` but not both.
        temperature: nil,
        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        top_p: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#create_streaming` or
        #   `#create` for streaming and non-streaming use cases, respectively.
        stream: true,
        request_options: {}
      )
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
