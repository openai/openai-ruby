# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::ArtifactsTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    response = @openai.beta.agents.sessions.artifacts.retrieve("artifact_id", session_id: "session_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Sessions::SessionArtifact
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          environment_id: String,
          object: Symbol,
          path: String,
          session_id: String,
          size_bytes: Integer,
          turn_id: String
        }
    end
  end

  def test_list
    response = @openai.beta.agents.sessions.artifacts.list("session_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Sessions::SessionArtifact
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          environment_id: String,
          object: Symbol,
          path: String,
          session_id: String,
          size_bytes: Integer,
          turn_id: String
        }
    end
  end

  def test_delete_required_params
    response = @openai.beta.agents.sessions.artifacts.delete("artifact_id", session_id: "session_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Sessions::SessionArtifactDeleted
    end

    assert_pattern do
      response => {
          id: String,
          deleted: OpenAI::Internal::Type::Boolean,
          object: Symbol
        }
    end
  end

  def test_content_required_params
    response = @openai.beta.agents.sessions.artifacts.content("artifact_id", session_id: "session_id")

    assert_pattern do
      response => StringIO
    end
  end
end
