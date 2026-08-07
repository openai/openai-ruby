# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::ResponsesTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.beta.responses.create

    assert_pattern do
      response => OpenAI::Beta::BetaResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Beta::BetaResponseError | nil,
        incomplete_details: OpenAI::Beta::BetaResponse::IncompleteDetails | nil,
        instructions: OpenAI::Beta::BetaResponse::Instructions | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::Beta::BetaResponse::Model,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::Boolean,
        temperature: Float | nil,
        tool_choice: OpenAI::Beta::BetaResponse::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool]),
        top_p: Float | nil,
        background: OpenAI::Internal::Type::Boolean | nil,
        completed_at: Float | nil,
        conversation: OpenAI::Beta::BetaResponse::Conversation | nil,
        max_output_tokens: Integer | nil,
        max_tool_calls: Integer | nil,
        moderation: OpenAI::Beta::BetaResponse::Moderation | nil,
        previous_response_id: String | nil,
        prompt: OpenAI::Beta::BetaResponsePrompt | nil,
        prompt_cache_key: String | nil,
        prompt_cache_options: OpenAI::Beta::BetaResponse::PromptCacheOptions | nil,
        prompt_cache_retention: OpenAI::Beta::BetaResponse::PromptCacheRetention | nil,
        reasoning: OpenAI::Beta::BetaResponse::Reasoning | nil,
        safety_identifier: String | nil,
        service_tier: OpenAI::Beta::BetaResponse::ServiceTier | nil,
        status: OpenAI::Beta::BetaResponseStatus | nil,
        text: OpenAI::Beta::BetaResponseTextConfig | nil,
        top_logprobs: Integer | nil,
        truncation: OpenAI::Beta::BetaResponse::Truncation | nil,
        usage: OpenAI::Beta::BetaResponseUsage | nil,
        user: String | nil
      }
    end
  end

  def test_retrieve
    response = @openai.beta.responses.retrieve("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => OpenAI::Beta::BetaResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Beta::BetaResponseError | nil,
        incomplete_details: OpenAI::Beta::BetaResponse::IncompleteDetails | nil,
        instructions: OpenAI::Beta::BetaResponse::Instructions | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::Beta::BetaResponse::Model,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::Boolean,
        temperature: Float | nil,
        tool_choice: OpenAI::Beta::BetaResponse::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool]),
        top_p: Float | nil,
        background: OpenAI::Internal::Type::Boolean | nil,
        completed_at: Float | nil,
        conversation: OpenAI::Beta::BetaResponse::Conversation | nil,
        max_output_tokens: Integer | nil,
        max_tool_calls: Integer | nil,
        moderation: OpenAI::Beta::BetaResponse::Moderation | nil,
        previous_response_id: String | nil,
        prompt: OpenAI::Beta::BetaResponsePrompt | nil,
        prompt_cache_key: String | nil,
        prompt_cache_options: OpenAI::Beta::BetaResponse::PromptCacheOptions | nil,
        prompt_cache_retention: OpenAI::Beta::BetaResponse::PromptCacheRetention | nil,
        reasoning: OpenAI::Beta::BetaResponse::Reasoning | nil,
        safety_identifier: String | nil,
        service_tier: OpenAI::Beta::BetaResponse::ServiceTier | nil,
        status: OpenAI::Beta::BetaResponseStatus | nil,
        text: OpenAI::Beta::BetaResponseTextConfig | nil,
        top_logprobs: Integer | nil,
        truncation: OpenAI::Beta::BetaResponse::Truncation | nil,
        usage: OpenAI::Beta::BetaResponseUsage | nil,
        user: String | nil
      }
    end
  end

  def test_delete
    response = @openai.beta.responses.delete("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => nil
    end
  end

  def test_cancel
    response = @openai.beta.responses.cancel("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => OpenAI::Beta::BetaResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Beta::BetaResponseError | nil,
        incomplete_details: OpenAI::Beta::BetaResponse::IncompleteDetails | nil,
        instructions: OpenAI::Beta::BetaResponse::Instructions | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::Beta::BetaResponse::Model,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::Boolean,
        temperature: Float | nil,
        tool_choice: OpenAI::Beta::BetaResponse::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaTool]),
        top_p: Float | nil,
        background: OpenAI::Internal::Type::Boolean | nil,
        completed_at: Float | nil,
        conversation: OpenAI::Beta::BetaResponse::Conversation | nil,
        max_output_tokens: Integer | nil,
        max_tool_calls: Integer | nil,
        moderation: OpenAI::Beta::BetaResponse::Moderation | nil,
        previous_response_id: String | nil,
        prompt: OpenAI::Beta::BetaResponsePrompt | nil,
        prompt_cache_key: String | nil,
        prompt_cache_options: OpenAI::Beta::BetaResponse::PromptCacheOptions | nil,
        prompt_cache_retention: OpenAI::Beta::BetaResponse::PromptCacheRetention | nil,
        reasoning: OpenAI::Beta::BetaResponse::Reasoning | nil,
        safety_identifier: String | nil,
        service_tier: OpenAI::Beta::BetaResponse::ServiceTier | nil,
        status: OpenAI::Beta::BetaResponseStatus | nil,
        text: OpenAI::Beta::BetaResponseTextConfig | nil,
        top_logprobs: Integer | nil,
        truncation: OpenAI::Beta::BetaResponse::Truncation | nil,
        usage: OpenAI::Beta::BetaResponseUsage | nil,
        user: String | nil
      }
    end
  end

  def test_compact_required_params
    response = @openai.beta.responses.compact(model: :"gpt-5.6-sol")

    assert_pattern do
      response => OpenAI::Beta::BetaCompactedResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputItem]),
        usage: OpenAI::Beta::BetaResponseUsage
      }
    end
  end
end
