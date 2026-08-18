# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::EmbeddingsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.embeddings.create(
        input: "The quick brown fox jumped over the lazy dog",
        model: :"text-embedding-3-small"
      )

    assert_pattern do
      response => OpenAI::CreateEmbeddingResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Embedding]),
        model: String,
        object: Symbol,
        usage: OpenAI::CreateEmbeddingResponse::Usage
      }
    end
  end
end
