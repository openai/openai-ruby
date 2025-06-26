# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ImagesTest < OpenAI::Test::ResourceTest
  def test_create_variation_required_params
    response = @openai.images.create_variation(image: Pathname(__FILE__))

    assert_pattern do
      response => OpenAI::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        background: OpenAI::ImagesResponse::Background | nil,
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Image]) | nil,
        output_format: OpenAI::ImagesResponse::OutputFormat | nil,
        quality: OpenAI::ImagesResponse::Quality | nil,
        size: OpenAI::ImagesResponse::Size | nil,
        usage: OpenAI::ImagesResponse::Usage | nil
      }
    end
  end

  def test_edit_required_params
    response =
      @openai.images.edit(image: Pathname(__FILE__), prompt: "A cute baby sea otter wearing a beret")

    assert_pattern do
      response => OpenAI::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        background: OpenAI::ImagesResponse::Background | nil,
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Image]) | nil,
        output_format: OpenAI::ImagesResponse::OutputFormat | nil,
        quality: OpenAI::ImagesResponse::Quality | nil,
        size: OpenAI::ImagesResponse::Size | nil,
        usage: OpenAI::ImagesResponse::Usage | nil
      }
    end
  end

  def test_generate_required_params
    response = @openai.images.generate(prompt: "A cute baby sea otter")

    assert_pattern do
      response => OpenAI::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        background: OpenAI::ImagesResponse::Background | nil,
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Image]) | nil,
        output_format: OpenAI::ImagesResponse::OutputFormat | nil,
        quality: OpenAI::ImagesResponse::Quality | nil,
        size: OpenAI::ImagesResponse::Size | nil,
        usage: OpenAI::ImagesResponse::Usage | nil
      }
    end
  end
end
