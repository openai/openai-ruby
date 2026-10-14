# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::UsageTest < OpenAI::Test::ResourceTest
  def test_audio_speeches_required_params
    response = @openai.admin.organization.usage.audio_speeches(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageAudioSpeechesResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageAudioSpeechesResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_audio_transcriptions_required_params
    response = @openai.admin.organization.usage.audio_transcriptions(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageAudioTranscriptionsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_code_interpreter_sessions_required_params
    response = @openai.admin.organization.usage.code_interpreter_sessions(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_completions_required_params
    response = @openai.admin.organization.usage.completions(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageCompletionsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_costs_required_params
    response = @openai.admin.organization.usage.costs(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageCostsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageCostsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_embeddings_required_params
    response = @openai.admin.organization.usage.embeddings(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageEmbeddingsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageEmbeddingsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_file_search_calls_required_params
    response = @openai.admin.organization.usage.file_search_calls(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageFileSearchCallsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageFileSearchCallsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_images_required_params
    response = @openai.admin.organization.usage.images(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageImagesResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageImagesResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_moderations_required_params
    response = @openai.admin.organization.usage.moderations(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageModerationsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageModerationsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_vector_stores_required_params
    response = @openai.admin.organization.usage.vector_stores(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageVectorStoresResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageVectorStoresResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end

  def test_web_search_calls_required_params
    response = @openai.admin.organization.usage.web_search_calls(start_time: 0)

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UsageWebSearchCallsResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageWebSearchCallsResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        next_page: String | nil,
        object: Symbol
      }
    end
  end
end
