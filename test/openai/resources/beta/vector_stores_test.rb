# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::VectorStoresTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.beta.vector_stores.create

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStore
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::Beta::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::Beta::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_retrieve
    response = @openai.beta.vector_stores.retrieve("vector_store_id")

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStore
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::Beta::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::Beta::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_update
    response = @openai.beta.vector_stores.update("vector_store_id")

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStore
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::Beta::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::Beta::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_list
    response = @openai.beta.vector_stores.list

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    assert_pattern do
      row => OpenAI::Models::Beta::VectorStore
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::Beta::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::Beta::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::Beta::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_delete
    response = @openai.beta.vector_stores.delete("vector_store_id")

    assert_pattern do
      response => OpenAI::Models::Beta::VectorStoreDeleted
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
