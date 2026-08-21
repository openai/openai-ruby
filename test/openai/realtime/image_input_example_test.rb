# frozen_string_literal: true

require "stringio"
require "tmpdir"
require "zlib"

require_relative "../test_helper"
require_relative "../../../examples/realtime/image_input"
require_relative "example_test_support"

class OpenAI::Test::RealtimeImageInputExampleTest < Minitest::Test
  include OpenAI::Test::RealtimeExampleTestSupport

  class StreamingInflateProbe
    attr_reader :yielded_bytes

    def initialize
      @inflater = Zlib::Inflate.new
      @yielded_bytes = 0
    end

    def inflate(compressed)
      raise "PNG inflation was not streamed" unless block_given?

      @inflater.inflate(compressed) do |chunk|
        @yielded_bytes += chunk.bytesize
        yield(chunk)
      end
    end

    def close = @inflater.close
    def finished? = @inflater.finished?
    def total_in = @inflater.total_in
  end

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

  def test_accepts_valid_progressive_lossless_and_dnl_jpegs
    progressive_scan = [1, 1, 0, 0, 0, 0].pack("C6")
    lossless_frame = [8, 1, 1, 1, 1, 0x11, 0].pack("CnnC4")
    lossless_scan = [1, 1, 0, 1, 0, 0].pack("C6")
    dnl_frame = [8, 0, 1, 1, 1, 0x11, 0].pack("CnnC4")
    dnl = jpeg_segment(0xDC, [1].pack("n"))
    single_component_4x4 = [8, 1, 1, 1, 1, 0x44, 0].pack("CnnC4")
    valid_images = [
      jpeg_fixture(frame_marker: 0xC2, scan: progressive_scan, scan_data: "\x7F".b),
      jpeg_fixture(
        frame_marker: 0xC3,
        frame: lossless_frame,
        scan: lossless_scan,
        scan_data: "\x7F".b
      ),
      jpeg_fixture(frame: dnl_frame, after_scan: dnl),
      jpeg_fixture(frame: single_component_4x4),
      progressive_restart_jpeg
    ]

    valid_images.each do |bytes|
      assert(OpenAI::Examples::Realtime::ImageInput.valid_jpeg?(bytes))
    end
  end

  def test_accepts_valid_png_across_streaming_chunks
    height = 10_000
    ihdr = [1, height, 8, 0, 0, 0, 0].pack("NNCCCCC")
    idat = Zlib::Deflate.deflate("\x00\x00".b * height)

    assert(OpenAI::Examples::Realtime::ImageInput.valid_png?(png_fixture(ihdr: ihdr, idat: idat)))
  end

  def test_rejects_indexed_png_without_a_preceding_palette_before_connecting
    ihdr = [1, 1, 8, 3, 0, 0, 0].pack("NNCCCCC")
    idat = Zlib::Deflate.deflate("\x00\x00".b)
    palette = "\x00\x00\x00".b
    valid_indexed_png = OpenAI::Examples::Realtime::ImageInput::PNG_SIGNATURE +
      png_chunk("IHDR", ihdr) +
      png_chunk("PLTE", palette) +
      png_chunk("IDAT", idat) +
      png_chunk("IEND", "".b)
    invalid_images = [
      png_fixture(ihdr: ihdr, idat: idat),
      OpenAI::Examples::Realtime::ImageInput::PNG_SIGNATURE +
        png_chunk("IHDR", ihdr) +
        png_chunk("IDAT", idat) +
        png_chunk("PLTE", palette) +
        png_chunk("IEND", "".b)
    ]

    assert(OpenAI::Examples::Realtime::ImageInput.valid_png?(valid_indexed_png))
    invalid_images.each do |bytes|
      with_image(bytes, "private-indexed.png") do |path|
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
        assert_empty(realtime.models)
      end
    end
  end

  def test_bounds_png_inflation_before_connecting
    inflated = "\x00".b * 1_000_000
    compressed = Zlib::Deflate.deflate(inflated)
    probe = StreamingInflateProbe.new
    refute(
      OpenAI::Examples::Realtime::ImageInput.valid_png_scanlines?(
        compressed,
        [[1, 1]],
        [1],
        2,
        inflater: probe
      )
    )
    assert_operator(probe.yielded_bytes, :<, inflated.bytesize)

    with_image(png_fixture(idat: compressed), "private-bomb.png") do |path|
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
      assert_empty(realtime.models)
    end
  end

  def test_rejects_invalid_jpeg_frame_and_scan_contents_before_connecting
    empty_segments = "\xFF\xD8\xFF\xC0\x00\x02\xFF\xDA\x00\x02\xFF\xD9".b
    zero_width_frame = [8, 1, 0, 1, 1, 0x11, 0].pack("CnnC4")
    unknown_scan_component = [1, 2, 0, 0, 63, 0].pack("C6")
    invalid_baseline_parameters = [1, 1, 0, 63, 0, 0].pack("C6")
    invalid_progressive_parameters = [1, 1, 0, 0, 63, 0].pack("C6")
    lossless_frame = [2, 1, 1, 1, 1, 0x11, 0].pack("CnnC4")
    invalid_lossless_parameters = [1, 1, 0, 1, 0, 15].pack("C6")
    unresolved_dnl_frame = [8, 0, 1, 1, 1, 0x11, 0].pack("CnnC4")
    five_component_frame = jpeg_frame(
      [
        [1, 0x11, 0],
        [2, 0x11, 0],
        [3, 0x11, 0],
        [4, 0x11, 0],
        [5, 0x11, 0]
      ]
    )
    five_component_scan = [5, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 0, 63, 0].pack("C*")
    excessive_interleaved_sampling_frame = jpeg_frame([[1, 0x44, 0], [2, 0x44, 0]])
    two_component_scan = [2, 1, 0, 2, 0, 0, 63, 0].pack("C*")
    invalid_images = [
      empty_segments,
      jpeg_fixture(frame: zero_width_frame),
      jpeg_fixture(scan: unknown_scan_component),
      jpeg_fixture(scan: invalid_baseline_parameters),
      jpeg_fixture(frame_marker: 0xC2, scan: invalid_progressive_parameters),
      jpeg_fixture(
        frame_marker: 0xC3,
        frame: lossless_frame,
        scan: invalid_lossless_parameters
      ),
      jpeg_fixture(frame: unresolved_dnl_frame),
      jpeg_fixture(
        frame: unresolved_dnl_frame,
        after_scan: jpeg_segment(0xDC, [0].pack("n"))
      ),
      jpeg_fixture(frame: five_component_frame, scan: five_component_scan),
      jpeg_fixture(frame: excessive_interleaved_sampling_frame, scan: two_component_scan),
      jpeg_fixture(scan_data: "".b)
    ]

    invalid_images.each do |bytes|
      with_image(bytes, "private-invalid-frame.jpg") do |path|
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
        assert_empty(realtime.models)
      end
    end
  end

  def test_rejects_jpeg_with_invalid_coding_tables_or_scan_data_before_connecting
    quantization_table_one = [8, 1, 1, 1, 1, 0x11, 1].pack("CnnC4")
    huffman_table_one = [1, 1, 0x11, 0, 63, 0].pack("C6")
    large_frame = [8, 100, 100, 1, 1, 0x11, 0].pack("CnnC4")
    progressive_frame = [8, 1, 1, 1, 1, 0x11, 0].pack("CnnC4")
    progressive_dc_scan = [1, 1, 0, 0, 0, 0].pack("C6")
    invalid_dc_refinement = [1, 1, 0, 0, 0, 0x10].pack("C6")
    lossless_nonzero_quantizer = [8, 1, 1, 1, 1, 0x11, 3].pack("CnnC4")
    invalid_progression = "\xFF\xD8".b +
      jpeg_coding_tables +
      jpeg_segment(0xC2, progressive_frame) +
      jpeg_segment(0xDA, progressive_dc_scan) +
      "\x7F".b +
      jpeg_segment(0xDA, invalid_dc_refinement) +
      "\x7F\xFF\xD9".b
    invalid_images = [
      jpeg_fixture(tables: "".b),
      jpeg_fixture(frame: quantization_table_one),
      jpeg_fixture(scan: huffman_table_one),
      jpeg_fixture(frame: large_frame),
      jpeg_fixture(scan_data: "\x80".b),
      jpeg_fixture(tables: jpeg_coding_tables(quantization: "\x00".b * 64)),
      jpeg_fixture(
        tables: jpeg_coding_tables(
          quantization: ([1] * 64).pack("n*"),
          quantization_precision: 1
        )
      ),
      jpeg_fixture(
        frame_marker: 0xC3,
        frame: lossless_nonzero_quantizer,
        scan: [1, 1, 0, 1, 0, 0].pack("C6"),
        scan_data: "\x7F".b
      ),
      jpeg_fixture(tables: jpeg_coding_tables(dc_symbols: "\xFF".b)),
      jpeg_fixture(
        tables: jpeg_coding_tables(
          dc_counts: [2, *([0] * 15)].pack("C*"),
          dc_symbols: "\x00\x01".b
        )
      ),
      invalid_progression
    ]

    invalid_images.each do |bytes|
      with_image(bytes, "private-invalid-table.jpg") do |path|
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
        assert_empty(realtime.models)
      end
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
    @valid_jpeg ||= jpeg_fixture
  end

  private def jpeg_fixture(
    frame_marker: 0xC0,
    frame: [8, 1, 1, 1, 1, 0x11, 0].pack("CnnC4"),
    scan: [1, 1, 0, 0, 63, 0].pack("C6"),
    scan_data: "\x3F".b,
    tables: jpeg_coding_tables,
    after_scan: "".b
  )
    "\xFF\xD8".b +
      tables +
      jpeg_segment(frame_marker, frame) +
      jpeg_segment(0xDA, scan) +
      scan_data +
      after_scan +
      "\xFF\xD9".b
  end

  private def jpeg_segment(marker, data)
    "\xFF".b + marker.chr(Encoding::BINARY) + [data.bytesize + 2].pack("n") + data
  end

  private def jpeg_coding_tables(
    quantization: "\x01".b * 64,
    quantization_precision: 0,
    dc_counts: [1, *([0] * 15)].pack("C*"),
    dc_symbols: "\x00".b,
    ac_counts: [1, *([0] * 15)].pack("C*"),
    ac_symbols: "\x00".b
  )
    huffman = "\x00".b +
      dc_counts +
      dc_symbols +
      "\x10".b +
      ac_counts +
      ac_symbols
    quantization_definition = (quantization_precision << 4).chr(Encoding::BINARY)
    jpeg_segment(0xDB, quantization_definition + quantization) + jpeg_segment(0xC4, huffman)
  end

  private def progressive_restart_jpeg
    ac_counts = [1, 1, *([0] * 14)].pack("C*")
    tables = jpeg_coding_tables(ac_counts: ac_counts, ac_symbols: "\x01\x00".b)
    frame = [8, 8, 16, 1, 1, 0x11, 0].pack("CnnC4")
    dc_scan = [1, 1, 0, 0, 0, 0].pack("C6")
    ac_first_scan = [1, 1, 0, 1, 2, 1].pack("C6")
    ac_refinement_scan = [1, 1, 0, 1, 2, 0x10].pack("C6")
    restart = "\xFF\xD0".b

    "\xFF\xD8".b +
      tables +
      jpeg_segment(0xC2, frame) +
      jpeg_segment(0xDD, [1].pack("n")) +
      jpeg_segment(0xDA, dc_scan) +
      "\x7F".b +
      restart +
      "\x7F".b +
      jpeg_segment(0xDA, ac_first_scan) +
      "\x6F".b +
      restart +
      "\x6F".b +
      jpeg_segment(0xDA, ac_refinement_scan) +
      "\x3F".b +
      restart +
      "\x3F\xFF\xD9".b
  end

  private def jpeg_frame(components)
    [8, 1, 1, components.length].pack("CnnC") + components.flatten.pack("C*")
  end
end
