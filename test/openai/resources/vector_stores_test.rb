# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::VectorStoresTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.vector_stores.create

    assert_pattern do
      response => OpenAI::Models::VectorStore
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_retrieve
    response = @openai.vector_stores.retrieve("vector_store_id")

    assert_pattern do
      response => OpenAI::Models::VectorStore
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_update
    response = @openai.vector_stores.update("vector_store_id")

    assert_pattern do
      response => OpenAI::Models::VectorStore
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_list
    response = @openai.vector_stores.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::VectorStore
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        file_counts: OpenAI::Models::VectorStore::FileCounts,
        last_active_at: Integer | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        status: OpenAI::Models::VectorStore::Status,
        usage_bytes: Integer,
        expires_after: OpenAI::Models::VectorStore::ExpiresAfter | nil,
        expires_at: Integer | nil
      }
    end
  end

  def test_delete
    response = @openai.vector_stores.delete("vector_store_id")

    assert_pattern do
      response => OpenAI::Models::VectorStoreDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::BooleanModel,
        object: Symbol
      }
    end
  end

  def test_search_required_params
    response = @openai.vector_stores.search("vs_abc123", query: "string")

    assert_pattern do
      response => OpenAI::Internal::Page
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::VectorStoreSearchResponse
    end

    assert_pattern do
      row => {
        attributes: ^(OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStoreSearchResponse::Attribute]) | nil,
        content: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::VectorStoreSearchResponse::Content]),
        file_id: String,
        filename: String,
        score: Float
      }
    end
  end
end
