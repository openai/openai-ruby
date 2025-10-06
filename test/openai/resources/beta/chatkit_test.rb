# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::ChatKitTest < OpenAI::Test::ResourceTest
  def test_upload_file_required_params
    response = @openai.beta.chatkit.upload_file(file: Pathname(__FILE__))

    assert_pattern do
      response => OpenAI::Models::Beta::ChatKitUploadFileResponse
    end

    assert_pattern do
      case response
      in OpenAI::Beta::FilePart
      in OpenAI::Beta::ImagePart
      end
    end

    assert_pattern do
      case response
      in {type: :file, id: String, mime_type: String | nil, name: String | nil, upload_url: String | nil}
      in {type: :image, id: String, mime_type: String, name: String | nil, preview_url: String, upload_url: String | nil}
      end
    end
  end
end
