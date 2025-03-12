# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Audio::TranslationsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.audio.translations.create(
      file: StringIO.new("some file contents"),
      model: :"whisper-1"
    )

    assert_pattern do
      response => OpenAI::Models::Audio::TranslationCreateResponse
    end

    assert_pattern do
      case response
      in OpenAI::Models::Audio::Translation
      in OpenAI::Models::Audio::TranslationVerbose
      end
    end
  end
end
