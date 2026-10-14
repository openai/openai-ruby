# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Webhooks::EventTypesTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.webhooks.event_types.list

    assert_pattern do
      response => OpenAI::Webhooks::WebhookEventTypeList
    end

    assert_pattern do
      response => {
          data: ^(OpenAI::Internal::Type::ArrayOf[String]),
          object: Symbol
        }
    end
  end
end
