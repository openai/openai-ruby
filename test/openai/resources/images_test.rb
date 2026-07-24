# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ImagesTest < OpenAI::Test::ResourceTest
  def test_create_variation_required_params
    response = @openai.images.create_variation(image: StringIO.new("Example data"))

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
      @openai.images.edit(
        image: StringIO.new("Example data"),
        prompt: "A cute baby sea otter wearing a beret"
      )

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

  def test_edit_encodes_multiple_images_as_an_array_multipart_field
    requests = []
    client = Object.new
    client.define_singleton_method(:request) do |**request|
      requests << request
      request
    end
    images = OpenAI::Resources::Images.new(client: client)
    files = [
      OpenAI::FilePart.new("first", filename: "first.png"),
      OpenAI::FilePart.new("second", filename: "second.png")
    ]

    images.edit(image: files, prompt: "Combine them")
    images.edit_stream_raw(image: files, prompt: "Combine them")

    requests.each do |request|
      names = multipart_field_names(request)
      assert_equal(2, names.count("image[]"))
      refute_includes(names, "image")
    end
  end

  def test_edit_preserves_the_scalar_image_multipart_field
    client = Object.new
    client.define_singleton_method(:request) { |**request| request }
    images = OpenAI::Resources::Images.new(client: client)

    request = images.edit(image: OpenAI::FilePart.new("first", filename: "first.png"), prompt: "Edit it")

    names = multipart_field_names(request)
    assert_equal(1, names.count("image"))
    refute_includes(names, "image[]")
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

  private def multipart_field_names(request)
    _headers, stream = OpenAI::Internal::Util.encode_content(request.fetch(:headers), request.fetch(:body))
    body = stream.respond_to?(:read) ? stream.read : stream.to_a.join
    body.scan(/Content-Disposition: form-data; name="([^"]+)"/).flatten
  end
end
