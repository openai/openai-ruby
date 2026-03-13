# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::SpeechTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    skip("Mock server doesn't support application/octet-stream responses")

    response = @openai.audio.speech.create(input: "input", model: :"tts-1", voice: "string")

    assert_pattern do
      response => StringIO
    end
  end
end
