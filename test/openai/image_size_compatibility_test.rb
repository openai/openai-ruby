# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ImageSizeCompatibilityTest < Minitest::Test
  extend Minitest::Serial

  def test_image_response_decodes_known_and_custom_sizes_as_strings
    %w[1024x1024 1024x1536 1536x1024 1536x864].each do |wire_size|
      with_response({created: 1, data: [], quality: "max", size: wire_size}.to_json) do |client|
        image = client.images.generate(prompt: "synthetic", model: "gpt-image-2.5-sunburst", quality: :max)

        assert_equal(wire_size, image.size)
        assert_equal(:max, image.quality)
      end
    end

    assert_equal(
      %w[1024x1024 1024x1536 1536x1024].to_set,
      OpenAI::ImagesResponse::Size.values.to_set
    )
  end

  def test_image_streams_preserve_size_values_and_enum_helpers
    %w[image_generation.completed image_generation.partial_image image_edit.completed image_edit.partial_image]
      .each do |type|
        %w[1024x1024 1024x1536 1536x1024 auto 1536x864].each do |wire_size|
          payload = {type: type, created_at: 1, b64_json: "synthetic", quality: "xhigh", size: wire_size}
          wire = "event: #{type}\ndata: #{payload.to_json}\n\n"

          with_response(wire, content_type: "text/event-stream") do |client|
            stream = if type.start_with?("image_edit.")
              client.images.edit_stream_raw(image: StringIO.new("synthetic"), prompt: "synthetic")
            else
              client.images.generate_stream_raw(prompt: "synthetic")
            end

            event = stream.to_a.fetch(0)

            assert_equal(wire_size, event.size, type)
            assert_equal(:xhigh, event.quality, type)
            assert_equal(
              %w[1024x1024 1024x1536 1536x1024 auto].to_set,
              event.class::Size.values.to_set
            )
          ensure
            stream&.close
          end
        end
      end
  end

  def test_image_response_size_preserves_absence_and_json_null
    [{}, {size: nil}].each do |fields|
      with_response({created: 1, **fields}.to_json) do |client|
        image = client.images.generate(prompt: "synthetic")
        assert_nil(image.size)
        assert_equal(fields.key?(:size), JSON.parse(image.to_json).key?("size"))
      end
    end
  end

  def test_symbol_inputs_match_named_string_presets
    image = OpenAI::ImagesResponse.new(created: 1, size: :"1024x1024")
    assert_equal("1024x1024", OpenAI::ImagesResponse::Size::SIZE_1024X1024)
    assert_equal(OpenAI::ImagesResponse::Size::SIZE_1024X1024, image.size)
    assert_equal(:"1024x1024", image.to_hash.fetch(:size))
    image.size = :"1536x864"
    assert_equal("1536x864", image.size)
    assert_equal(:"1536x864", image.to_hash.fetch(:size))
    assert_equal("1536x864", JSON.parse(image.to_json).fetch("size"))
  end

  private

  def with_response(body, content_type: "application/json")
    transport = OpenAI::HTTPClient.new
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => content_type},
      body: [body]
    )

    transport.stub(:execute, response) do
      yield(
        OpenAI::Client.new(
          api_key: "synthetic-key",
          base_url: "https://sdk.example.test",
          http_client: transport
        )
      )
    end
  end
end
