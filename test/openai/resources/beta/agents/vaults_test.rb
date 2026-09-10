# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::VaultsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.beta.agents.vaults.create

    assert_pattern do
      response => OpenAI::Beta::Agents::Vault
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          name: String | nil,
          object: Symbol
        }
    end
  end

  def test_retrieve
    response = @openai.beta.agents.vaults.retrieve("vault_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Vault
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          name: String | nil,
          object: Symbol
        }
    end
  end

  def test_list
    response = @openai.beta.agents.vaults.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Vault
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          name: String | nil,
          object: Symbol
        }
    end
  end

  def test_delete
    response = @openai.beta.agents.vaults.delete("vault_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::VaultDeleted
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
