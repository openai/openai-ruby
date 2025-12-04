# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ContainersTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.containers.create(name: "name")

    assert_pattern do
      response => OpenAI::Models::ContainerCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: String,
        status: String,
        expires_after: OpenAI::Models::ContainerCreateResponse::ExpiresAfter | nil,
        last_active_at: Integer | nil,
        memory_limit: OpenAI::Models::ContainerCreateResponse::MemoryLimit | nil
      }
    end
  end

  def test_retrieve
    response = @openai.containers.retrieve("container_id")

    assert_pattern do
      response => OpenAI::Models::ContainerRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: String,
        status: String,
        expires_after: OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter | nil,
        last_active_at: Integer | nil,
        memory_limit: OpenAI::Models::ContainerRetrieveResponse::MemoryLimit | nil
      }
    end
  end

  def test_list
    response = @openai.containers.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::ContainerListResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        name: String,
        object: String,
        status: String,
        expires_after: OpenAI::Models::ContainerListResponse::ExpiresAfter | nil,
        last_active_at: Integer | nil,
        memory_limit: OpenAI::Models::ContainerListResponse::MemoryLimit | nil
      }
    end
  end

  def test_delete
    response = @openai.containers.delete("container_id")

    assert_pattern do
      response => nil
    end
  end
end
