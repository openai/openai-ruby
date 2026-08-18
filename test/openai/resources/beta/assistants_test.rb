# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::AssistantsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.assistants.create(model: :"gpt-4o")

    assert_pattern do
      response => OpenAI::Beta::Assistant
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AssistantTool]),
        response_format: OpenAI::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_retrieve
    response = @openai.beta.assistants.retrieve("assistant_id")

    assert_pattern do
      response => OpenAI::Beta::Assistant
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AssistantTool]),
        response_format: OpenAI::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_update
    response = @openai.beta.assistants.update("assistant_id")

    assert_pattern do
      response => OpenAI::Beta::Assistant
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AssistantTool]),
        response_format: OpenAI::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_list
    response = @openai.beta.assistants.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Assistant
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        description: String | nil,
        instructions: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String | nil,
        object: Symbol,
        tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AssistantTool]),
        response_format: OpenAI::Beta::AssistantResponseFormatOption | nil,
        temperature: Float | nil,
        tool_resources: OpenAI::Beta::Assistant::ToolResources | nil,
        top_p: Float | nil
      }
    end
  end

  def test_delete
    response = @openai.beta.assistants.delete("assistant_id")

    assert_pattern do
      response => OpenAI::Beta::AssistantDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
