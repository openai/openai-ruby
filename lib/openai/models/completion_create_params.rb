# frozen_string_literal: true

module OpenAI
  module Models
    class CompletionCreateParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute model
      #   ID of the model to use. You can use the
      #     [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #     see all of your available models, or see our
      #     [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #     them.
      #
      #   @return [String, Symbol, OpenAI::Models::CompletionCreateParams::Model::Preset]
      required :model, union: -> { OpenAI::Models::CompletionCreateParams::Model }

      # @!attribute prompt
      #   The prompt(s) to generate completions for, encoded as a string, array of
      #     strings, array of tokens, or array of token arrays.
      #
      #     Note that <|endoftext|> is the document separator that the model sees during
      #     training, so if a prompt is not specified the model will generate as if from the
      #     beginning of a new document.
      #
      #   @return [String, Array<String>, Array<Integer>, Array<Array<Integer>>, nil]
      required :prompt, union: -> { OpenAI::Models::CompletionCreateParams::Prompt }, nil?: true

      # @!attribute best_of
      #   Generates `best_of` completions server-side and returns the "best" (the one with
      #     the highest log probability per token). Results cannot be streamed.
      #
      #     When used with `n`, `best_of` controls the number of candidate completions and
      #     `n` specifies how many to return – `best_of` must be greater than `n`.
      #
      #     **Note:** Because this parameter generates many completions, it can quickly
      #     consume your token quota. Use carefully and ensure that you have reasonable
      #     settings for `max_tokens` and `stop`.
      #
      #   @return [Integer, nil]
      optional :best_of, Integer, nil?: true

      # @!attribute echo
      #   Echo back the prompt in addition to the completion
      #
      #   @return [Boolean, nil]
      optional :echo, OpenAI::BooleanModel, nil?: true

      # @!attribute frequency_penalty
      #   Number between -2.0 and 2.0. Positive values penalize new tokens based on their
      #     existing frequency in the text so far, decreasing the model's likelihood to
      #     repeat the same line verbatim.
      #
      #     [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
      #
      #   @return [Float, nil]
      optional :frequency_penalty, Float, nil?: true

      # @!attribute logit_bias
      #   Modify the likelihood of specified tokens appearing in the completion.
      #
      #     Accepts a JSON object that maps tokens (specified by their token ID in the GPT
      #     tokenizer) to an associated bias value from -100 to 100. You can use this
      #     [tokenizer tool](/tokenizer?view=bpe) to convert text to token IDs.
      #     Mathematically, the bias is added to the logits generated by the model prior to
      #     sampling. The exact effect will vary per model, but values between -1 and 1
      #     should decrease or increase likelihood of selection; values like -100 or 100
      #     should result in a ban or exclusive selection of the relevant token.
      #
      #     As an example, you can pass `{"50256": -100}` to prevent the <|endoftext|> token
      #     from being generated.
      #
      #   @return [Hash{Symbol=>Integer}, nil]
      optional :logit_bias, OpenAI::HashOf[Integer], nil?: true

      # @!attribute logprobs
      #   Include the log probabilities on the `logprobs` most likely output tokens, as
      #     well the chosen tokens. For example, if `logprobs` is 5, the API will return a
      #     list of the 5 most likely tokens. The API will always return the `logprob` of
      #     the sampled token, so there may be up to `logprobs+1` elements in the response.
      #
      #     The maximum value for `logprobs` is 5.
      #
      #   @return [Integer, nil]
      optional :logprobs, Integer, nil?: true

      # @!attribute max_tokens
      #   The maximum number of [tokens](/tokenizer) that can be generated in the
      #     completion.
      #
      #     The token count of your prompt plus `max_tokens` cannot exceed the model's
      #     context length.
      #     [Example Python code](https://cookbook.openai.com/examples/how_to_count_tokens_with_tiktoken)
      #     for counting tokens.
      #
      #   @return [Integer, nil]
      optional :max_tokens, Integer, nil?: true

      # @!attribute n
      #   How many completions to generate for each prompt.
      #
      #     **Note:** Because this parameter generates many completions, it can quickly
      #     consume your token quota. Use carefully and ensure that you have reasonable
      #     settings for `max_tokens` and `stop`.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute presence_penalty
      #   Number between -2.0 and 2.0. Positive values penalize new tokens based on
      #     whether they appear in the text so far, increasing the model's likelihood to
      #     talk about new topics.
      #
      #     [See more information about frequency and presence penalties.](https://platform.openai.com/docs/guides/text-generation)
      #
      #   @return [Float, nil]
      optional :presence_penalty, Float, nil?: true

      # @!attribute seed
      #   If specified, our system will make a best effort to sample deterministically,
      #     such that repeated requests with the same `seed` and parameters should return
      #     the same result.
      #
      #     Determinism is not guaranteed, and you should refer to the `system_fingerprint`
      #     response parameter to monitor changes in the backend.
      #
      #   @return [Integer, nil]
      optional :seed, Integer, nil?: true

      # @!attribute stop
      #   Up to 4 sequences where the API will stop generating further tokens. The
      #     returned text will not contain the stop sequence.
      #
      #   @return [String, Array<String>, nil]
      optional :stop, union: -> { OpenAI::Models::CompletionCreateParams::Stop }, nil?: true

      # @!attribute stream_options
      #   Options for streaming response. Only set this when you set `stream: true`.
      #
      #   @return [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
      optional :stream_options, -> { OpenAI::Models::Chat::ChatCompletionStreamOptions }, nil?: true

      # @!attribute suffix
      #   The suffix that comes after a completion of inserted text.
      #
      #     This parameter is only supported for `gpt-3.5-turbo-instruct`.
      #
      #   @return [String, nil]
      optional :suffix, String, nil?: true

      # @!attribute temperature
      #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
      #     make the output more random, while lower values like 0.2 will make it more
      #     focused and deterministic.
      #
      #     We generally recommend altering this or `top_p` but not both.
      #
      #   @return [Float, nil]
      optional :temperature, Float, nil?: true

      # @!attribute top_p
      #   An alternative to sampling with temperature, called nucleus sampling, where the
      #     model considers the results of the tokens with top_p probability mass. So 0.1
      #     means only the tokens comprising the top 10% probability mass are considered.
      #
      #     We generally recommend altering this or `temperature` but not both.
      #
      #   @return [Float, nil]
      optional :top_p, Float, nil?: true

      # @!attribute [r] user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!parse
      #   # @return [String]
      #   attr_writer :user

      # @!parse
      #   # @param model [String, Symbol, OpenAI::Models::CompletionCreateParams::Model::Preset]
      #   # @param prompt [String, Array<String>, Array<Integer>, Array<Array<Integer>>, nil]
      #   # @param best_of [Integer, nil]
      #   # @param echo [Boolean, nil]
      #   # @param frequency_penalty [Float, nil]
      #   # @param logit_bias [Hash{Symbol=>Integer}, nil]
      #   # @param logprobs [Integer, nil]
      #   # @param max_tokens [Integer, nil]
      #   # @param n [Integer, nil]
      #   # @param presence_penalty [Float, nil]
      #   # @param seed [Integer, nil]
      #   # @param stop [String, Array<String>, nil]
      #   # @param stream_options [OpenAI::Models::Chat::ChatCompletionStreamOptions, nil]
      #   # @param suffix [String, nil]
      #   # @param temperature [Float, nil]
      #   # @param top_p [Float, nil]
      #   # @param user [String]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(
      #     model:,
      #     prompt:,
      #     best_of: nil,
      #     echo: nil,
      #     frequency_penalty: nil,
      #     logit_bias: nil,
      #     logprobs: nil,
      #     max_tokens: nil,
      #     n: nil,
      #     presence_penalty: nil,
      #     seed: nil,
      #     stop: nil,
      #     stream_options: nil,
      #     suffix: nil,
      #     temperature: nil,
      #     top_p: nil,
      #     user: nil,
      #     request_options: {},
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # @abstract
      #
      # ID of the model to use. You can use the
      #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
      #   see all of your available models, or see our
      #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
      #   them.
      class Model < OpenAI::Union
        variant String

        # ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them.
        variant enum: -> { OpenAI::Models::CompletionCreateParams::Model::Preset }

        # @abstract
        #
        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        class Preset < OpenAI::Enum
          GPT_3_5_TURBO_INSTRUCT = :"gpt-3.5-turbo-instruct"
          DAVINCI_002 = :"davinci-002"
          BABBAGE_002 = :"babbage-002"

          finalize!
        end
      end

      # @abstract
      #
      # The prompt(s) to generate completions for, encoded as a string, array of
      #   strings, array of tokens, or array of token arrays.
      #
      #   Note that <|endoftext|> is the document separator that the model sees during
      #   training, so if a prompt is not specified the model will generate as if from the
      #   beginning of a new document.
      class Prompt < OpenAI::Union
        StringArray = OpenAI::ArrayOf[String]

        IntegerArray = OpenAI::ArrayOf[Integer]

        ArrayOfToken2DArray = OpenAI::ArrayOf[OpenAI::ArrayOf[Integer]]

        variant String

        variant OpenAI::Models::CompletionCreateParams::Prompt::StringArray

        variant OpenAI::Models::CompletionCreateParams::Prompt::IntegerArray

        variant OpenAI::Models::CompletionCreateParams::Prompt::ArrayOfToken2DArray
      end

      # @abstract
      #
      # Up to 4 sequences where the API will stop generating further tokens. The
      #   returned text will not contain the stop sequence.
      class Stop < OpenAI::Union
        StringArray = OpenAI::ArrayOf[String]

        variant String

        variant OpenAI::Models::CompletionCreateParams::Stop::StringArray
      end
    end
  end
end
