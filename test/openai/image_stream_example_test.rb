# frozen_string_literal: true

require "bundler"
require "open3"
require "rbconfig"
require "tmpdir"

require_relative "test_helper"

class OpenAI::Test::ImageStreamExampleTest < Minitest::Test
  PNG_FIXTURE = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII="
  PNG_BYTES = PNG_FIXTURE.unpack1("m0")
  STUBBED_EXAMPLE_RUNNER = <<~'RUBY'
    require ENV.fetch("OPENAI_LIBRARY")
    require "minitest/mock"

    StubImages = Data.define(:stream) do
      def generate_stream_raw(**) = stream
    end
    StubClient = Data.define(:images)

    encoded = ENV.fetch("OPENAI_IMAGE_FIXTURE")
    events = [
      OpenAI::Models::ImageGenPartialImageEvent.new(b64_json: encoded, partial_image_index: 0),
      OpenAI::Models::ImageGenCompletedEvent.new(b64_json: encoded)
    ]
    client = StubClient.new(images: StubImages.new(stream: events.each))
    text_writer = -> (*) { raise "image data was written in text mode" }

    File.stub(:write, text_writer) do
      OpenAI::Client.stub(:new, client) do
        load(ENV.fetch("OPENAI_IMAGE_STREAM_EXAMPLE"))
      end
    end
  RUBY

  def test_example_preserves_decoded_png_bytes
    Dir.mktmpdir("openai-image-stream-example") do |directory|
      environment = {
        "OPENAI_API_KEY" => nil,
        "OPENAI_IMAGE_FIXTURE" => PNG_FIXTURE,
        "OPENAI_IMAGE_STREAM_EXAMPLE" => File.expand_path("../../examples/image_stream.rb", __dir__),
        "OPENAI_LIBRARY" => File.expand_path("../../lib/openai.rb", __dir__)
      }
      stdout, stderr, status = Bundler.with_unbundled_env do
        Open3.capture3(
          environment,
          RbConfig.ruby,
          "-e",
          STUBBED_EXAMPLE_RUNNER,
          chdir: directory
        )
      end

      assert(status.success?, stderr)
      assert_empty(stderr)
      assert_includes(stdout, "Image streaming completed!")
      assert_equal(PNG_BYTES, File.binread(File.join(directory, "partial_1.png")))
      assert_equal(PNG_BYTES, File.binread(File.join(directory, "final_image.png")))
    end

    assert_includes(PNG_BYTES, "\r\n".b)
    assert_includes(PNG_BYTES, "\x1A\n".b)
  end
end
