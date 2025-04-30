# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ImagesTest < OpenAI::Test::ResourceTest
  def test_create_variation_required_params
    response = @openai.images.create_variation(image: Pathname(__FILE__))

    assert_pattern do
      response => OpenAI::Models::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Image]) | nil,
        usage: OpenAI::Models::ImagesResponse::Usage | nil
      }
    end
  end

  def test_edit_required_params
    response =
      @openai.images.edit(image: Pathname(__FILE__), prompt: "A cute baby sea otter wearing a beret")

    assert_pattern do
      response => OpenAI::Models::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Image]) | nil,
        usage: OpenAI::Models::ImagesResponse::Usage | nil
      }
    end
  end

  def test_generate_required_params
    response = @openai.images.generate(prompt: "A cute baby sea otter")

    assert_pattern do
      response => OpenAI::Models::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Image]) | nil,
        usage: OpenAI::Models::ImagesResponse::Usage | nil
      }
    end
  end
end
