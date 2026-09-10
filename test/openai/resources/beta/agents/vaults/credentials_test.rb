# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Vaults::CredentialsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.vaults.credentials.create(
      "vault_id",
      auth: {access_token: "access_token", mcp_server_url: "mcp_server_url", type: :mcp_oauth},
      name: "x"
    )

    assert_pattern do
      response => OpenAI::Beta::Agents::Vaults::Credential
    end

    assert_pattern do
      response => {
          id: String,
          auth: OpenAI::Beta::Agents::Vaults::CredentialAuth,
          created_at: Integer,
          name: String,
          object: Symbol,
          updated_at: Integer,
          vault_id: String
        }
    end
  end

  def test_retrieve_required_params
    response = @openai.beta.agents.vaults.credentials.retrieve("credential_id", vault_id: "vault_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Vaults::Credential
    end

    assert_pattern do
      response => {
          id: String,
          auth: OpenAI::Beta::Agents::Vaults::CredentialAuth,
          created_at: Integer,
          name: String,
          object: Symbol,
          updated_at: Integer,
          vault_id: String
        }
    end
  end

  def test_update_required_params
    response = @openai.beta.agents.vaults.credentials.update(
      "credential_id",
      vault_id: "vault_id",
      auth: {type: :mcp_oauth}
    )

    assert_pattern do
      response => OpenAI::Beta::Agents::Vaults::Credential
    end

    assert_pattern do
      response => {
          id: String,
          auth: OpenAI::Beta::Agents::Vaults::CredentialAuth,
          created_at: Integer,
          name: String,
          object: Symbol,
          updated_at: Integer,
          vault_id: String
        }
    end
  end

  def test_list
    response = @openai.beta.agents.vaults.credentials.list("vault_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Vaults::Credential
    end

    assert_pattern do
      row => {
          id: String,
          auth: OpenAI::Beta::Agents::Vaults::CredentialAuth,
          created_at: Integer,
          name: String,
          object: Symbol,
          updated_at: Integer,
          vault_id: String
        }
    end
  end

  def test_delete_required_params
    response = @openai.beta.agents.vaults.credentials.delete("credential_id", vault_id: "vault_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Vaults::CredentialDeleted
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
