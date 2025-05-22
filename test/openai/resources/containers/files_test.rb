# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Containers::FilesTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.containers.files.create("container_id")

    assert_pattern do
      response => OpenAI::Models::Containers::FileCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        container_id: String,
        created_at: Integer,
        object: Symbol,
        path: String,
        source: String
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.containers.files.retrieve("file_id", container_id: "container_id")

    assert_pattern do
      response => OpenAI::Models::Containers::FileRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        bytes: Integer,
        container_id: String,
        created_at: Integer,
        object: Symbol,
        path: String,
        source: String
      }
    end
  end

  def test_list
    response = @openai.containers.files.list("container_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Containers::FileListResponse
    end

    assert_pattern do
      row => {
        id: String,
        bytes: Integer,
        container_id: String,
        created_at: Integer,
        object: Symbol,
        path: String,
        source: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.containers.files.delete("file_id", container_id: "container_id")

    assert_pattern do
      response => nil
    end
  end
end
