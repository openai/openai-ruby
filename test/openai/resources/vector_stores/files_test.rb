# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::VectorStores::FilesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.vector_stores.files.create("vs_abc123", file_id: "file_id")

    assert_pattern do
      response => OpenAI::Models::VectorStores::VectorStoreFile
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        attributes: ^(OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStores::VectorStoreFile::Attribute]) | nil,
        chunking_strategy: OpenAI::Models::FileChunkingStrategy | nil
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.vector_stores.files.retrieve("file-abc123", vector_store_id: "vs_abc123")

    assert_pattern do
      response => OpenAI::Models::VectorStores::VectorStoreFile
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        attributes: ^(OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStores::VectorStoreFile::Attribute]) | nil,
        chunking_strategy: OpenAI::Models::FileChunkingStrategy | nil
      }
    end
  end

  def test_update_required_params
    response =
      @openai.vector_stores.files.update(
        "file-abc123",
        vector_store_id: "vs_abc123",
        attributes: {foo: "string"}
      )

    assert_pattern do
      response => OpenAI::Models::VectorStores::VectorStoreFile
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        attributes: ^(OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStores::VectorStoreFile::Attribute]) | nil,
        chunking_strategy: OpenAI::Models::FileChunkingStrategy | nil
      }
    end
  end

  def test_list
    response = @openai.vector_stores.files.list("vector_store_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::VectorStores::VectorStoreFile
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        attributes: ^(OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStores::VectorStoreFile::Attribute]) | nil,
        chunking_strategy: OpenAI::Models::FileChunkingStrategy | nil
      }
    end
  end

  def test_delete_required_params
    response = @openai.vector_stores.files.delete("file_id", vector_store_id: "vector_store_id")

    assert_pattern do
      response => OpenAI::Models::VectorStores::VectorStoreFileDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end

  def test_content_required_params
    response = @openai.vector_stores.files.content("file-abc123", vector_store_id: "vs_abc123")

    assert_pattern do
      response => OpenAI::Internal::Page
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::VectorStores::FileContentResponse
    end

    assert_pattern do
      row => {
        text: String | nil,
        type: String | nil
      }
    end
  end
end
