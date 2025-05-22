# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ResponsesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.responses.create(input: "string", model: :"gpt-4o")

    assert_pattern do
      response => OpenAI::Responses::Response
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Responses::ResponseError | nil,
        incomplete_details: OpenAI::Responses::Response::IncompleteDetails | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::ResponsesModel,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::Boolean,
        temperature: Float | nil,
        tool_choice: OpenAI::Responses::Response::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool]),
        top_p: Float | nil,
        background: OpenAI::Internal::Type::Boolean | nil,
        max_output_tokens: Integer | nil,
        previous_response_id: String | nil,
        reasoning: OpenAI::Reasoning | nil,
        service_tier: OpenAI::Responses::Response::ServiceTier | nil,
        status: OpenAI::Responses::ResponseStatus | nil,
        text: OpenAI::Responses::ResponseTextConfig | nil,
        truncation: OpenAI::Responses::Response::Truncation | nil,
        usage: OpenAI::Responses::ResponseUsage | nil,
        user: String | nil
      }
    end
  end

  def test_retrieve
    response = @openai.responses.retrieve("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => OpenAI::Responses::Response
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Responses::ResponseError | nil,
        incomplete_details: OpenAI::Responses::Response::IncompleteDetails | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::ResponsesModel,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::Boolean,
        temperature: Float | nil,
        tool_choice: OpenAI::Responses::Response::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool]),
        top_p: Float | nil,
        background: OpenAI::Internal::Type::Boolean | nil,
        max_output_tokens: Integer | nil,
        previous_response_id: String | nil,
        reasoning: OpenAI::Reasoning | nil,
        service_tier: OpenAI::Responses::Response::ServiceTier | nil,
        status: OpenAI::Responses::ResponseStatus | nil,
        text: OpenAI::Responses::ResponseTextConfig | nil,
        truncation: OpenAI::Responses::Response::Truncation | nil,
        usage: OpenAI::Responses::ResponseUsage | nil,
        user: String | nil
      }
    end
  end

  def test_delete
    response = @openai.responses.delete("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => nil
    end
  end

  def test_cancel
    response = @openai.responses.cancel("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => nil
    end
  end
end
