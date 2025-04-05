# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::FilesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.files.create(file: StringIO.new("some file contents"), purpose: :assistants)

    assert_pattern do
      response => OpenAI::Models::FileObject
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        created_at: Integer,
        filename: String,
        object: Symbol,
        purpose: OpenAI::Models::FileObject::Purpose,
        status: OpenAI::Models::FileObject::Status,
        expires_at: Integer | nil,
        status_details: String | nil
      }
    end
  end

  def test_retrieve
    response = @openai.files.retrieve("file_id")

    assert_pattern do
      response => OpenAI::Models::FileObject
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        created_at: Integer,
        filename: String,
        object: Symbol,
        purpose: OpenAI::Models::FileObject::Purpose,
        status: OpenAI::Models::FileObject::Status,
        expires_at: Integer | nil,
        status_details: String | nil
      }
    end
  end

  def test_list
    response = @openai.files.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::FileObject
    end

    assert_pattern do
      row => {
        id: String,
        bytes: Integer,
        created_at: Integer,
        filename: String,
        object: Symbol,
        purpose: OpenAI::Models::FileObject::Purpose,
        status: OpenAI::Models::FileObject::Status,
        expires_at: Integer | nil,
        status_details: String | nil
      }
    end
  end

  def test_delete
    response = @openai.files.delete("file_id")

    assert_pattern do
      response => OpenAI::Models::FileDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end

  def test_content
    skip("skipped: test server currently has no support for method content-type")

    response = @openai.files.content("file_id")

    assert_pattern do
      response => StringIO
    end
  end
end
