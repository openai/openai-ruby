# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ImageSizeCompatibilityTest < Minitest::Test
  extend Minitest::Serial

  def test_image_response_preserves_known_size_symbols_and_custom_size_strings
    {"1024x1024" => :"1024x1024", "1536x864" => "1536x864"}.each do |wire_size, expected|
      with_response({created: 1, data: [], quality: "max", size: wire_size}.to_json) do |client|
        image = client.images.generate(prompt: "synthetic", model: "gpt-image-2.5-sunburst", quality: :max)

        assert_equal(expected, image.size)
        assert_equal(:max, image.quality)
      end
    end

    assert_equal(
      [:"1024x1024", :"1024x1536", :"1536x1024"].to_set,
      OpenAI::ImagesResponse::Size.values.to_set
    )
  end

  def test_image_streams_preserve_size_values_and_enum_helpers
    %w[image_generation.completed image_generation.partial_image image_edit.completed image_edit.partial_image]
      .each do |type|
        {"1024x1024" => :"1024x1024", "1536x864" => "1536x864"}.each do |wire_size, expected|
          payload = {type: type, created_at: 1, b64_json: "synthetic", quality: "xhigh", size: wire_size}
          wire = "event: #{type}\ndata: #{payload.to_json}\n\n"

          with_response(wire, content_type: "text/event-stream") do |client|
            stream = if type.start_with?("image_edit.")
              client.images.edit_stream_raw(image: StringIO.new("synthetic"), prompt: "synthetic")
            else
              client.images.generate_stream_raw(prompt: "synthetic")
            end

            event = stream.to_a.fetch(0)

            assert_equal(expected, event.size, type)
            assert_equal(:xhigh, event.quality, type)
            assert_equal(
              [:"1024x1024", :"1024x1536", :"1536x1024", :auto].to_set,
              event.class::Size.values.to_set
            )
          ensure
            stream&.close
          end
        end
      end
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
