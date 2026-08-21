# frozen_string_literal: true

require "stringio"
require "tmpdir"
require "zlib"

require_relative "../test_helper"
require_relative "../../../examples/realtime/image_input"
require_relative "example_test_support"

class OpenAI::Test::RealtimeImageInputExampleTest < Minitest::Test
  include OpenAI::Test::RealtimeExampleTestSupport

  def test_validates_png_before_connecting_and_returns_completed_text
    with_image(valid_png, "private-customer-image.png") do |path|
      prompt = "private image question"
      client, connection, realtime = recording_client(
        [response_done(id: "response_image", text: "A small black square.")]
      )
      diagnostics = StringIO.new

      text = OpenAI::Examples::Realtime::ImageInput.run(
        client: client,
        model: "gpt-realtime-2.1",
        image_path: path,
        prompt: prompt,
        output: diagnostics
      )

      assert_equal("A small black square.", text)
      assert_equal(["gpt-realtime-2.1"], realtime.models)
      content = connection.conversation.items.calls.fetch(0).fetch(:content)
      assert_equal(:input_image, content.fetch(0).fetch(:type))
      assert_equal(
        "data:image/png;base64,#{[valid_png].pack("m0")}",
        content.fetch(0).fetch(:image_url)
      )
      assert_equal(prompt, content.fetch(1).fetch(:text))
      assert_equal([{}], connection.response.calls)
      assert_includes(diagnostics.string, "response.done status=completed")
      refute_includes(diagnostics.string, path)
      refute_includes(diagnostics.string, prompt)
      refute_includes(diagnostics.string, text)
    end
  end

  def test_accepts_a_structurally_valid_jpeg
    with_image(valid_jpeg, "image.jpg") do |path|
      uri = OpenAI::Examples::Realtime::ImageInput.image_data_uri(path)

      assert_equal("data:image/jpeg;base64,#{[valid_jpeg].pack("m0")}", uri)
    end
  end

  def test_rejects_invalid_or_corrupted_images_before_connecting
    zero_width_ihdr = [0, 1, 8, 0, 0, 0, 0].pack("NNCCCCC")
    invalid_images = [
      "not an image".b,
      valid_png.dup.tap { _1.setbyte(30, _1.getbyte(30) ^ 0xFF) },
      png_fixture(ihdr: zero_width_ihdr),
      png_fixture(idat: "corrupt compressed data".b),
      png_fixture(idat: Zlib::Deflate.deflate("\x00\x00".b) + "trailing data".b),
      png_fixture(idat: Zlib::Deflate.deflate("\x00".b)),
      valid_jpeg.delete_suffix("\xFF\xD9".b)
    ]

    invalid_images.each do |bytes|
      with_image(bytes, "private-invalid-image") do |path|
        client, _connection, realtime = recording_client([])

        error = assert_raises(ArgumentError) do
          OpenAI::Examples::Realtime::ImageInput.run(
            client: client,
            model: "gpt-realtime-2.1",
            image_path: path,
            prompt: "private prompt",
            output: StringIO.new
          )
        end

        assert_equal("Realtime image input must be a valid PNG or JPEG file", error.message)
        refute_includes(error.message, path)
        assert_empty(realtime.models)
      end
    end
  end

  def test_hides_sensitive_paths_when_image_reading_fails
    private_path = "/private/customer/image.png"
    client, _connection, realtime = recording_client([])

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::ImageInput.run(
        client: client,
        model: "gpt-realtime-2.1",
        image_path: private_path,
        prompt: "private prompt",
        output: StringIO.new
      )
    end

    assert_equal("Unable to read Realtime image input.", error.message)
    refute_includes(error.message, private_path)
    assert_nil(error.cause)
    assert_empty(realtime.models)
  end

  def test_rejects_api_errors_without_exposing_service_details
    error = run_error([api_error("private image payload")])

    assert_equal("Realtime API error.", error.message)
    refute_includes(error.message, "private image payload")
  end

  def test_requires_a_completed_response
    error = run_error([response_done(id: "response_image", status: :failed, text: "partial")])

    assert_equal("Realtime response did not complete.", error.message)
  end

  def test_rejects_premature_eof_and_empty_final_output
    eof_error = run_error([])
    assert_equal("Realtime connection closed before response.done.", eof_error.message)

    empty_error = run_error([response_done(id: "response_image", text: " ")])
    assert_equal("Realtime image response completed without text output.", empty_error.message)
  end

  private def run_error(events)
    with_image(valid_png, "private-image.png") do |path|
      client, = recording_client(events)
      return assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::ImageInput.run(
          client: client,
          model: "gpt-realtime-2.1",
          image_path: path,
          prompt: "private prompt",
          output: StringIO.new
        )
      end
    end
  end

  private def with_image(bytes, basename)
    Dir.mktmpdir("realtime-image-test") do |directory|
      path = File.join(directory, basename)
      File.binwrite(path, bytes)
      yield(path)
    end
  end

  private def valid_png
    @valid_png ||= begin
      ihdr = [1, 1, 8, 0, 0, 0, 0].pack("NNCCCCC")
      png_fixture(ihdr: ihdr)
    end
  end

  private def png_fixture(
    ihdr: [1, 1, 8, 0, 0, 0, 0].pack("NNCCCCC"),
    idat: Zlib::Deflate.deflate("\x00\x00".b)
  )
    OpenAI::Examples::Realtime::ImageInput::PNG_SIGNATURE +
      png_chunk("IHDR", ihdr) +
      png_chunk("IDAT", idat) +
      png_chunk("IEND", "".b)
  end

  private def png_chunk(type, data)
    [data.bytesize].pack("N") + type + data + [Zlib.crc32(type + data)].pack("N")
  end

  private def valid_jpeg
    @valid_jpeg ||= begin
      frame = [8, 1, 1, 1, 1, 0x11, 0].pack("CnnC4")
      scan = [1, 1, 0, 0, 63, 0].pack("C6")
      "\xFF\xD8".b +
        jpeg_segment(0xC0, frame) +
        jpeg_segment(0xDA, scan) +
        "\x01\x02\xFF\x00\x03\xFF\xD9".b
    end
  end

  private def jpeg_segment(marker, data)
    "\xFF".b + marker.chr(Encoding::BINARY) + [data.bytesize + 2].pack("n") + data
  end
end
