# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Uploads::PartsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.uploads.parts.create("upload_abc123", data: Pathname(__FILE__))

    assert_pattern do
      response => OpenAI::Models::Uploads::UploadPart
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        object: Symbol,
        upload_id: String
      }
    end
  end
end
