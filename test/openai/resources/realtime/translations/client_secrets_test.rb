# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Realtime::Translations::ClientSecretsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.realtime.translations.client_secrets.create(session: {model: "model"})

    assert_pattern do
      response => OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse
    end

    assert_pattern do
      response => {
          expires_at: Integer,
          session: OpenAI::Realtime::RealtimeTranslationSession,
          value: String
        }
    end
  end
end
