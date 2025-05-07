# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::TranscriptionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.transcriptions.create(file: Pathname(__FILE__), model: :"whisper-1")

    assert_pattern do
      response => OpenAI::Models::Audio::TranscriptionCreateResponse
    end

    assert_pattern do
      case response
      in OpenAI::Audio::Transcription
      in OpenAI::Audio::TranscriptionVerbose
      end
    end
  end
end
