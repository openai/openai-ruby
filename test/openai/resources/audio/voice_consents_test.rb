# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::VoiceConsentsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.voice_consents.create(
      language: "language",
      name: "name",
      recording: StringIO.new("Example data")
    )

    assert_pattern do
      response => OpenAI::Audio::VoiceConsent
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          language: String,
          name: String,
          object: Symbol
        }
    end
  end

  def test_retrieve
    response = @openai.audio.voice_consents.retrieve("consent_id")

    assert_pattern do
      response => OpenAI::Audio::VoiceConsent
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          language: String,
          name: String,
          object: Symbol
        }
    end
  end

  def test_update_required_params
    response = @openai.audio.voice_consents.update("consent_id", name: "name")

    assert_pattern do
      response => OpenAI::Audio::VoiceConsent
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          language: String,
          name: String,
          object: Symbol
        }
    end
  end

  def test_list
    response = @openai.audio.voice_consents.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Audio::VoiceConsent
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          language: String,
          name: String,
          object: Symbol
        }
    end
  end

  def test_delete
    response = @openai.audio.voice_consents.delete("consent_id")

    assert_pattern do
      response => OpenAI::Audio::VoiceConsentDeleted
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
