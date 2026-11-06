# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::VoicesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.voices.create(
      body: {audio_sample: StringIO.new("Example data"), consent: "consent", name: "x"}
    )

    assert_pattern do
      response => OpenAI::Audio::Voice
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          name: String,
          object: Symbol,
          type: OpenAI::Audio::Voice::Type,
          prompt: String | nil
        }
    end
  end

  def test_delete
    response = @openai.audio.voices.delete("voice_id")

    assert_pattern do
      response => OpenAI::Audio::VoiceDeleted
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
