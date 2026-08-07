# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::SpeechTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.speech.create(input: "input", model: :"tts-1", voice: :alloy)

    assert_pattern do
      response => StringIO
    end
  end
end
