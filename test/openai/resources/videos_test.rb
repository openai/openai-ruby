# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::VideosTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.videos.create(prompt: "x")

    assert_pattern do
      response => OpenAI::Video
    end

    assert_pattern do
      response => {
        id: String,
        completed_at: Integer | nil,
        created_at: Integer,
        error: OpenAI::VideoCreateError | nil,
        expires_at: Integer | nil,
        model: OpenAI::VideoModel,
        object: Symbol,
        progress: Integer,
        remixed_from_video_id: String | nil,
        seconds: OpenAI::VideoSeconds,
        size: OpenAI::VideoSize,
        status: OpenAI::Video::Status
      }
    end
  end

  def test_retrieve
    response = @openai.videos.retrieve("video_123")

    assert_pattern do
      response => OpenAI::Video
    end

    assert_pattern do
      response => {
        id: String,
        completed_at: Integer | nil,
        created_at: Integer,
        error: OpenAI::VideoCreateError | nil,
        expires_at: Integer | nil,
        model: OpenAI::VideoModel,
        object: Symbol,
        progress: Integer,
        remixed_from_video_id: String | nil,
        seconds: OpenAI::VideoSeconds,
        size: OpenAI::VideoSize,
        status: OpenAI::Video::Status
      }
    end
  end

  def test_list
    response = @openai.videos.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Video
    end

    assert_pattern do
      row => {
        id: String,
        completed_at: Integer | nil,
        created_at: Integer,
        error: OpenAI::VideoCreateError | nil,
        expires_at: Integer | nil,
        model: OpenAI::VideoModel,
        object: Symbol,
        progress: Integer,
        remixed_from_video_id: String | nil,
        seconds: OpenAI::VideoSeconds,
        size: OpenAI::VideoSize,
        status: OpenAI::Video::Status
      }
    end
  end

  def test_delete
    response = @openai.videos.delete("video_123")

    assert_pattern do
      response => OpenAI::Models::VideoDeleteResponse
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end

  def test_download_content
    skip("Prism doesn't support application/binary responses")

    response = @openai.videos.download_content("video_123")

    assert_pattern do
      response => StringIO
    end
  end

  def test_remix_required_params
    response = @openai.videos.remix("video_123", prompt: "x")

    assert_pattern do
      response => OpenAI::Video
    end

    assert_pattern do
      response => {
        id: String,
        completed_at: Integer | nil,
        created_at: Integer,
        error: OpenAI::VideoCreateError | nil,
        expires_at: Integer | nil,
        model: OpenAI::VideoModel,
        object: Symbol,
        progress: Integer,
        remixed_from_video_id: String | nil,
        seconds: OpenAI::VideoSeconds,
        size: OpenAI::VideoSize,
        status: OpenAI::Video::Status
      }
    end
  end
end
