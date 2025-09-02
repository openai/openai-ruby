# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Realtime::ClientSecretsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.realtime.client_secrets.create

    assert_pattern do
      response => OpenAI::Models::Realtime::ClientSecretCreateResponse
    end

    assert_pattern do
      response => {
        expires_at: Integer,
        session: OpenAI::Models::Realtime::ClientSecretCreateResponse::Session,
        value: String
      }
    end
  end
end
