# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::VectorStores::FilesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.vector_stores.files.create("vs_abc123", file_id: "file_id")

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStores::VectorStoreFile
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        chunking_strategy: OpenAI::Models::Beta::FileChunkingStrategy | nil
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.beta.vector_stores.files.retrieve("file-abc123", vector_store_id: "vs_abc123")

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStores::VectorStoreFile
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        chunking_strategy: OpenAI::Models::Beta::FileChunkingStrategy | nil
      }
    end
  end

  def test_list
    response = @openai.beta.vector_stores.files.list("vector_store_id")

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    assert_pattern do
      row => OpenAI::Models::Beta::VectorStores::VectorStoreFile
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::Models::Beta::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        chunking_strategy: OpenAI::Models::Beta::FileChunkingStrategy | nil
      }
    end
  end

  def test_delete_required_params
    response = @openai.beta.vector_stores.files.delete("file_id", vector_store_id: "vector_store_id")

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStores::VectorStoreFileDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::BooleanModel,
        object: Symbol
      }
    end
  end
end
