# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::AssistantsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.assistants.create(model: :"o3-mini")

    assert_pattern do
      response => OpenAI::Models::Beta::Assistant
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Models::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_retrieve
    response = @openai.beta.assistants.retrieve("assistant_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Assistant
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Models::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_update
    response = @openai.beta.assistants.update("assistant_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Assistant
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Models::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_list
    response = @openai.beta.assistants.list

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Beta::Assistant
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Models::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_delete
    response = @openai.beta.assistants.delete("assistant_id")

    assert_pattern do
      response => OpenAI::Models::Beta::AssistantDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::BooleanModel,
        object: Symbol
      }
    end
  end
end
