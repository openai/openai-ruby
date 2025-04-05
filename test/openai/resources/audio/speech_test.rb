# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::SpeechTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    skip("skipped: test server currently has no support for method content-type")

    response = @openai.audio.speech.create(input: "input", model: :"tts-1", voice: :alloy)

    assert_pattern do
      response => StringIO
    end
  end
end
