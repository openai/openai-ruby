# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Videos::CharacterTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.videos.character.create(name: "x", video: StringIO.new("Example data"))

    assert_pattern do
      response => OpenAI::Models::Videos::CharacterCreateResponse
    end

    assert_pattern do
      response => {
        id: String | nil,
        created_at: Integer,
        name: String | nil
      }
    end
  end

  def test_get
    response = @openai.videos.character.get("char_123")

    assert_pattern do
      response => OpenAI::Models::Videos::CharacterGetResponse
    end

    assert_pattern do
      response => {
        id: String | nil,
        created_at: Integer,
        name: String | nil
      }
    end
  end
end
