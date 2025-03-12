# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::SpeechTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.speech.create(input: "input", model: "string", voice: :alloy)

    assert_pattern do
      response => OpenAI::Unknown
    end
  end
end
