# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ResponsesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.responses.create(input: "string", model: :"gpt-4o")

    assert_pattern do
      response => OpenAI::Models::Responses::Response
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Models::Responses::ResponseError | nil,
        incomplete_details: OpenAI::Models::Responses::Response::IncompleteDetails | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::Models::ResponsesModel,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::ResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::BooleanModel,
        temperature: Float | nil,
        tool_choice: OpenAI::Models::Responses::Response::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::Tool]),
        top_p: Float | nil,
        max_output_tokens: Integer | nil,
        previous_response_id: String | nil,
        reasoning: OpenAI::Models::Reasoning | nil,
        status: OpenAI::Models::Responses::ResponseStatus | nil,
        text: OpenAI::Models::Responses::ResponseTextConfig | nil,
        truncation: OpenAI::Models::Responses::Response::Truncation | nil,
        usage: OpenAI::Models::Responses::ResponseUsage | nil,
        user: String | nil
      }
    end
  end

  def test_retrieve
    response = @openai.responses.retrieve("resp_677efb5139a88190b512bc3fef8e535d")

    assert_pattern do
      response => OpenAI::Models::Responses::Response
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Float,
        error: OpenAI::Models::Responses::ResponseError | nil,
        incomplete_details: OpenAI::Models::Responses::Response::IncompleteDetails | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: OpenAI::Models::ResponsesModel,
        object: Symbol,
        output: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::ResponseOutputItem]),
        parallel_tool_calls: OpenAI::Internal::Type::BooleanModel,
        temperature: Float | nil,
        tool_choice: OpenAI::Models::Responses::Response::ToolChoice,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::Tool]),
        top_p: Float | nil,
        max_output_tokens: Integer | nil,
        previous_response_id: String | nil,
        reasoning: OpenAI::Models::Reasoning | nil,
        status: OpenAI::Models::Responses::ResponseStatus | nil,
        text: OpenAI::Models::Responses::ResponseTextConfig | nil,
        truncation: OpenAI::Models::Responses::Response::Truncation | nil,
        usage: OpenAI::Models::Responses::ResponseUsage | nil,
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
end
