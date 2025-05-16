# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::TranslationsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.translations.create(file: Pathname(__FILE__), model: :"whisper-1")

    assert_pattern do
      response => OpenAI::Models::Audio::TranslationCreateResponse
    end

    assert_pattern do
      case response
      in OpenAI::Audio::Translation
      in OpenAI::Audio::TranslationVerbose
      end
    end
  end
end
