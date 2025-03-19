# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ImagesTest < OpenAI::Test::ResourceTest
  def test_create_variation_required_params
    response = @openai.images.create_variation(image: StringIO.new("some file contents"))

    assert_pattern do
      response => OpenAI::Models::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        data: ^(OpenAI::ArrayOf[OpenAI::Models::Image])
      }
    end
  end

  def test_edit_required_params
    response =
      @openai.images.edit(
        image: StringIO.new("some file contents"),
        prompt: "A cute baby sea otter wearing a beret"
      )

    assert_pattern do
      response => OpenAI::Models::ImagesResponse
    end

    assert_pattern do
      response => {
        created: Integer,
        data: ^(OpenAI::ArrayOf[OpenAI::Models::Image])
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
        data: ^(OpenAI::ArrayOf[OpenAI::Models::Image])
      }
    end
  end
end
