# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Chat::CompletionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-4.1")

    assert_pattern do
      response => OpenAI::Models::Chat::ChatCompletion
    end

    assert_pattern do
      response => {
        id: String,
        choices: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletion::Choice]),
        created: Integer,
        model: String,
        object: Symbol,
        service_tier: OpenAI::Models::Chat::ChatCompletion::ServiceTier | nil,
        system_fingerprint: String | nil,
        usage: OpenAI::Models::CompletionUsage | nil
      }
    end
  end

  def test_retrieve
    response = @openai.chat.completions.retrieve("completion_id")

    assert_pattern do
      response => OpenAI::Models::Chat::ChatCompletion
    end

    assert_pattern do
      response => {
        id: String,
        choices: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletion::Choice]),
        created: Integer,
        model: String,
        object: Symbol,
        service_tier: OpenAI::Models::Chat::ChatCompletion::ServiceTier | nil,
        system_fingerprint: String | nil,
        usage: OpenAI::Models::CompletionUsage | nil
      }
    end
  end

  def test_update_required_params
    response = @openai.chat.completions.update("completion_id", metadata: {foo: "string"})

    assert_pattern do
      response => OpenAI::Models::Chat::ChatCompletion
    end

    assert_pattern do
      response => {
        id: String,
        choices: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletion::Choice]),
        created: Integer,
        model: String,
        object: Symbol,
        service_tier: OpenAI::Models::Chat::ChatCompletion::ServiceTier | nil,
        system_fingerprint: String | nil,
        usage: OpenAI::Models::CompletionUsage | nil
      }
    end
  end

  def test_list
    response = @openai.chat.completions.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Chat::ChatCompletion
    end

    assert_pattern do
      row => {
        id: String,
        choices: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletion::Choice]),
        created: Integer,
        model: String,
        object: Symbol,
        service_tier: OpenAI::Models::Chat::ChatCompletion::ServiceTier | nil,
        system_fingerprint: String | nil,
        usage: OpenAI::Models::CompletionUsage | nil
      }
    end
  end

  def test_delete
    response = @openai.chat.completions.delete("completion_id")

    assert_pattern do
      response => OpenAI::Models::Chat::ChatCompletionDeleted
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
