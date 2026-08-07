# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::VectorStores::FileBatchesTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.vector_stores.file_batches.create("vs_abc123")

    assert_pattern do
      response => OpenAI::VectorStores::VectorStoreFileBatch
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::VectorStores::VectorStoreFileBatch::FileCounts,
        object: Symbol,
        status: OpenAI::VectorStores::VectorStoreFileBatch::Status,
        vector_store_id: String
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.vector_stores.file_batches.retrieve("vsfb_abc123", vector_store_id: "vs_abc123")

    assert_pattern do
      response => OpenAI::VectorStores::VectorStoreFileBatch
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::VectorStores::VectorStoreFileBatch::FileCounts,
        object: Symbol,
        status: OpenAI::VectorStores::VectorStoreFileBatch::Status,
        vector_store_id: String
      }
    end
  end

  def test_cancel_required_params
    response = @openai.vector_stores.file_batches.cancel("batch_id", vector_store_id: "vector_store_id")

    assert_pattern do
      response => OpenAI::VectorStores::VectorStoreFileBatch
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::VectorStores::VectorStoreFileBatch::FileCounts,
        object: Symbol,
        status: OpenAI::VectorStores::VectorStoreFileBatch::Status,
        vector_store_id: String
      }
    end
  end

  def test_list_files_required_params
    response = @openai.vector_stores.file_batches.list_files("batch_id", vector_store_id: "vector_store_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::VectorStores::VectorStoreFile
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        last_error: OpenAI::VectorStores::VectorStoreFile::LastError | nil,
        object: Symbol,
        status: OpenAI::VectorStores::VectorStoreFile::Status,
        usage_bytes: Integer,
        vector_store_id: String,
        attributes: ^(OpenAI::Internal::Type::HashOf[union: OpenAI::VectorStores::VectorStoreFile::Attribute]) | nil,
        chunking_strategy: OpenAI::FileChunkingStrategy | nil
      }
    end
  end
end
