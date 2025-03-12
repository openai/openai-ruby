# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::UploadsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.uploads.create(
      bytes: 0,
      filename: "filename",
      mime_type: "mime_type",
      purpose: :assistants
    )

    assert_pattern do
      response => OpenAI::Models::Upload
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        created_at: Integer,
        expires_at: Integer,
        filename: String,
        object: Symbol,
        purpose: String,
        status: OpenAI::Models::Upload::Status,
        file: OpenAI::Models::FileObject | nil
      }
    end
  end

  def test_cancel
    response = @openai.uploads.cancel("upload_abc123")

    assert_pattern do
      response => OpenAI::Models::Upload
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        created_at: Integer,
        expires_at: Integer,
        filename: String,
        object: Symbol,
        purpose: String,
        status: OpenAI::Models::Upload::Status,
        file: OpenAI::Models::FileObject | nil
      }
    end
  end

  def test_complete_required_params
    response = @openai.uploads.complete("upload_abc123", part_ids: ["string"])

    assert_pattern do
      response => OpenAI::Models::Upload
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        created_at: Integer,
        expires_at: Integer,
        filename: String,
        object: Symbol,
        purpose: String,
        status: OpenAI::Models::Upload::Status,
        file: OpenAI::Models::FileObject | nil
      }
    end
  end
end
