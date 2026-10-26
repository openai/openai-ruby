# frozen_string_literal: true

module OpenAI
  module Resources
    class Decisions
      # Use this endpoint to quickly answer classification or scoring questions about
      # some input. You can ask multiple questions in one request.
      #
      # @overload create(input:, model:, questions:, prompt_cache_key: nil, prompt_cache_options: nil, safety_identifier: nil, request_options: {})
      #
      # @param input [String, Array<OpenAI::Models::decision_input_message, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput>]
      #   The input to evaluate for every question. Provide a text string or an ordered
      #   array of messages, function calls and outputs, or custom tool calls and outputs.
      #   Each tool output must identify a matching call by call ID.
      #
      # @param model [String]
      #   The model to use. Only `gpt-6-luna` is supported.
      #
      # @param questions [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      #   Ask 1–400 questions about the input. Each question can be a predicate, choice,
      #   or score. Answers come back in the same order.
      #
      # @param prompt_cache_key [String, nil]
      #   Partition prompt cache reuse by caller-provided key.
      #
      # @param prompt_cache_options [OpenAI::Models::DecisionCreateParams::PromptCacheOptions, nil]
      #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #   request can write up to four breakpoints. For cache matching, OpenAI considers
      #   up to the latest 80 breakpoints in the conversation, without a content-block
      #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #   `ttl` defaults to `30m`, which is currently the only supported value. See the
      #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #   for current details.
      #
      # @param safety_identifier [String, nil]
      #   Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #   Responses' limit; this is never the authenticated user identity.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Decision]
      #
      # @see OpenAI::Models::DecisionCreateParams
      def create(params)
        parsed, options = OpenAI::DecisionCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "decisions",
          body: parsed,
          model: OpenAI::Decision,
          security: {bearer_auth: true},
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
