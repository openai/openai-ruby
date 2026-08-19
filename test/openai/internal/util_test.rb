# frozen_string_literal: true

require_relative "../test_helper"
require "tempfile"

class OpenAI::Test::UtilDataHandlingTest < Minitest::Test
  def test_left_map
    assert_pattern do
      OpenAI::Internal::Util.deep_merge({a: 1}, nil) => nil
    end
  end

  def test_right_map
    assert_pattern do
      OpenAI::Internal::Util.deep_merge(nil, {a: 1}) => {a: 1}
    end
  end

  def test_disjoint_maps
    assert_pattern do
      OpenAI::Internal::Util.deep_merge({b: 2}, {a: 1}) => {a: 1, b: 2}
    end
  end

  def test_overlapping_maps
    assert_pattern do
      OpenAI::Internal::Util.deep_merge({b: 2, c: 3}, {a: 1, c: 4}) => {a: 1, b: 2, c: 4}
    end
  end

  def test_nested
    assert_pattern do
      OpenAI::Internal::Util.deep_merge({b: {b2: 1}}, {b: {b2: 2}}) => {b: {b2: 2}}
    end
  end

  def test_nested_left_map
    assert_pattern do
      OpenAI::Internal::Util.deep_merge({b: {b2: 1}}, {b: 6}) => {b: 6}
    end
  end

  def test_omission
    merged = OpenAI::Internal::Util.deep_merge(
      {b: {b2: 1, b3: {c: 4, d: 5}}},
      {b: {b2: 1, b3: {c: OpenAI::Internal::OMIT, d: 5}}}
    )

    assert_pattern do
      merged => {b: {b2: 1, b3: {d: 5}}}
    end
  end

  def test_concat
    merged = OpenAI::Internal::Util.deep_merge(
      {a: {b: [1, 2]}},
      {a: {b: [3, 4]}},
      concat: true
    )

    assert_pattern do
      merged => {a: {b: [1, 2, 3, 4]}}
    end
  end

  def test_concat_false
    merged = OpenAI::Internal::Util.deep_merge(
      {a: {b: [1, 2]}},
      {a: {b: [3, 4]}},
      concat: false
    )

    assert_pattern do
      merged => {a: {b: [3, 4]}}
    end
  end

  def test_dig
    assert_pattern do
      OpenAI::Internal::Util.dig(1, nil) => 1
      OpenAI::Internal::Util.dig({a: 1}, :b) => nil
      OpenAI::Internal::Util.dig({a: 1}, :a) => 1
      OpenAI::Internal::Util.dig({a: {b: 1}}, [:a, :b]) => 1

      OpenAI::Internal::Util.dig([], 1) => nil
      OpenAI::Internal::Util.dig([nil, [nil, 1]], [1, 1]) => 1
      OpenAI::Internal::Util.dig({a: [nil, 1]}, [:a, 1]) => 1
      OpenAI::Internal::Util.dig([], 1.0) => nil

      OpenAI::Internal::Util.dig(Object, 1) => nil
      OpenAI::Internal::Util.dig([], 1.0) { 2 } => 2
      OpenAI::Internal::Util.dig([], -> (_) { 2 }) => 2
      OpenAI::Internal::Util.dig([1], -> { _1 in [1] }) => true
    end
  end
end

class OpenAI::Test::UtilHeaderHandlingTest < Minitest::Test
  def test_normalized_headers_canonicalizes_symbol_names
    headers = OpenAI::Internal::Util.normalized_headers(
      Authorization: " Bearer secret ",
      "X-Request-Ids": ["first", nil, " second "]
    )

    assert_equal(
      {"authorization" => "Bearer secret", "x-request-ids" => "first, second"},
      headers
    )
  end

  def test_normalized_headers_preserves_mixed_key_precedence
    headers = OpenAI::Internal::Util.normalized_headers(
      {"X-Request-Id" => "first", :"x-request-id" => "second"},
      {"X-Request-Id" => "third"}
    )

    assert_equal({"x-request-id" => "third"}, headers)
  end

  def test_normalized_headers_preserves_precedence_for_every_key_spelling
    keys = ["X-Request-Id", "x-request-id", :"X-Request-Id", :"x-request-id"]

    keys.repeated_permutation(3).each do |first, second, third|
      headers = OpenAI::Internal::Util.normalized_headers(
        {first => "first", second => "second"},
        {third => "third"}
      )

      assert_equal({"x-request-id" => "third"}, headers)
    end
  end
end

class OpenAI::Test::UtilUriHandlingTest < Minitest::Test
  def test_parsing
    %w[
      http://example.com
      https://example.com/
      https://example.com:443/example?e1=e1&e2=e2&e=
    ].each do |url|
      parsed = OpenAI::Internal::Util.parse_uri(url)
      unparsed = OpenAI::Internal::Util.unparse_uri(parsed).to_s

      assert_equal(url, unparsed)
      assert_equal(parsed, OpenAI::Internal::Util.parse_uri(unparsed))
    end
  end

  def test_joining
    cases = [
      [
        "h://a.b/c?d=e",
        "h://nope/ignored",
        OpenAI::Internal::Util.parse_uri("h://a.b/c?d=e")
      ],
      [
        "h://a.b/c?d=e",
        "h://nope",
        {
          host: "a.b",
          path: "/c",
          query: {"d" => ["e"]}
        }
      ],
      [
        "h://a.b/c?d=e",
        "h://nope",
        {
          path: "h://a.b/c",
          query: {"d" => ["e"]}
        }
      ]
    ]

    cases.each do |expect, lhs, rhs|
      assert_equal(
        URI.parse(expect),
        OpenAI::Internal::Util.join_parsed_uri(
          OpenAI::Internal::Util.parse_uri(lhs),
          rhs
        )
      )
    end
  end

  def test_joining_queries
    base_url = "h://a.b/c?d=e"
    cases = {
      "c2" => "h://a.b/c/c2",
      "/c2?f=g" => "h://a.b/c2?f=g",
      "/c?f=g" => "h://a.b/c?d=e&f=g"
    }

    cases.each do |path, expected|
      assert_equal(
        URI.parse(expected),
        OpenAI::Internal::Util.join_parsed_uri(
          OpenAI::Internal::Util.parse_uri(base_url),
          {path: path}
        )
      )
    end
  end
end

class OpenAI::Test::UtilFormDataEncodingTest < Minitest::Test
  class FakeCGI < CGI
    def initialize(headers, io)
      encoded = io.to_a
      @ctype = headers["content-type"]
      # rubocop:disable Lint/EmptyBlock
      @io = OpenAI::Internal::Util::ReadIOAdapter.new(encoded.to_enum) { }
      # rubocop:enable Lint/EmptyBlock
      @c_len = encoded.join.bytesize.to_s
      super()
    end

    def stdinput = @io

    def env_table
      {
        "REQUEST_METHOD" => "POST",
        "CONTENT_TYPE" => @ctype,
        "CONTENT_LENGTH" => @c_len
      }
    end
  end

  def test_encoding_length
    headers, = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      Pathname(__FILE__)
    )
    boundary_prefix = "multipart/form-data; boundary="
    content_type = headers.fetch("content-type")
    assert(content_type.start_with?(boundary_prefix))
    field = content_type.delete_prefix(boundary_prefix)
    refute_empty(field)
    assert(field.length < 70 - 6)
  end

  def test_file_encode
    file = Pathname(__FILE__)
    fileinput = OpenAI::Internal::Type::Converter.dump(OpenAI::Internal::Type::FileInput, "abc")
    headers = {"content-type" => "multipart/form-data"}
    cases = {
      "abc" => ["", "abc"],
      StringIO.new("abc") => ["", "abc"],
      fileinput => %w[upload abc],
      OpenAI::FilePart.new(StringIO.new("abc")) => ["", "abc"],
      file => [file.basename.to_path, /^class OpenAI/],
      OpenAI::FilePart.new(file, filename: "d o g") => ["d o g", /^class OpenAI/]
    }
    cases.each do |body, testcase|
      filename, val = testcase
      encoded = OpenAI::Internal::Util.encode_content(headers, body)
      cgi = FakeCGI.new(*encoded)
      io = cgi[""]
      assert_pattern do
        io.original_filename => ^filename
        io.read => ^val
      end
    end
  end

  def test_multipart_filename_quoting
    file = OpenAI::FilePart.new(StringIO.new("x"), filename: "a \"b\"\r\nEvil: 1.md")
    _headers, stream = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      {"f" => [file]}
    )
    body = stream.respond_to?(:read) ? stream.read : stream.to_a.join

    assert_includes(body, "filename=\"a \\\"b\\\"Evil: 1.md\"")
    refute_includes(body, "\r\nEvil:")
  end

  def test_multipart_file_part_io_omits_absolute_local_path
    Tempfile.create(["upload-", ".txt"]) do |content|
      content.write("upload-body")
      content.rewind
      local_path = content.to_path
      _headers, stream = OpenAI::Internal::Util.encode_content(
        {"content-type" => "multipart/form-data"},
        {file: OpenAI::FilePart.new(content)}
      )
      body = stream.to_a.join

      assert_includes(body, "filename=\"#{File.basename(local_path)}\"")
      refute_includes(body, local_path)
    end
  end

  def test_multipart_filename_encoding_with_binary_content
    file = OpenAI::FilePart.new(StringIO.new("\xFF".b), filename: "\u00E9.png")
    _headers, stream = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      {"f" => [file]}
    )
    body = stream.respond_to?(:read) ? stream.read : stream.to_a.join

    assert_equal(Encoding::ASCII_8BIT, body.encoding)
    assert_includes(body, "filename=\"\u00E9.png\"".b)
  end

  def test_multipart_field_name_quoting
    _headers, stream = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      {"a \"b\"\\c\r\nEvil: 1" => "x"}
    )
    body = stream.respond_to?(:read) ? stream.read : stream.to_a.join

    assert_includes(body, "name=\"a \\\"b\\\"\\\\cEvil: 1\"")
    refute_includes(body, "\r\nEvil:")
  end

  def test_primitive_arrays_use_bracketed_field_names
    body, = OpenAI::Audio::TranscriptionCreateParams.dump_request(
      file: OpenAI::FilePart.new("audio", filename: "audio.wav"),
      model: :"whisper-1",
      timestamp_granularities: [:word, :segment]
    )
    encoded = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      body
    )
    cgi = FakeCGI.new(*encoded)

    assert_equal(%w[word segment], cgi.params.fetch("timestamp_granularities[]"))
    refute_includes(cgi.params, "timestamp_granularities")
  end

  def test_file_arrays_use_bracketed_field_names
    files = [
      OpenAI::FilePart.new(StringIO.new("a"), filename: "a.png"),
      OpenAI::FilePart.new(StringIO.new("b"), filename: "b.png")
    ]
    body, = OpenAI::ImageEditParams.dump_request(image: files, prompt: "Edit both images")
    encoded = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      body
    )
    parts = FakeCGI.new(*encoded).params

    assert_equal(["image[]"], parts.keys.grep(/^image/))
    assert_equal(%w[a.png b.png], parts.fetch("image[]").map(&:original_filename))
    assert_equal(%w[a b], parts.fetch("image[]").map(&:read))
  end

  def test_scalar_files_keep_unbracketed_field_names
    body, = OpenAI::ImageEditParams.dump_request(
      image: OpenAI::FilePart.new(StringIO.new("image"), filename: "image.png"),
      prompt: "Edit one image"
    )
    encoded = OpenAI::Internal::Util.encode_content({"content-type" => "multipart/form-data"}, body)
    parts = FakeCGI.new(*encoded).params

    assert_equal(["image"], parts.keys.grep(/^image/))
    assert_equal(["image.png"], parts.fetch("image").map(&:original_filename))
    assert_equal(["image"], parts.fetch("image").map(&:read))
  end

  def test_generated_nested_values_use_bracket_notation
    body, = OpenAI::FileCreateParams.dump_request(
      file: OpenAI::FilePart.new("{}", filename: "batch.jsonl"),
      purpose: :batch,
      expires_after: {anchor: :created_at, seconds: 3600}
    )
    encoded = OpenAI::Internal::Util.encode_content({"content-type" => "multipart/form-data"}, body)
    parts = FakeCGI.new(*encoded).params

    assert_equal(["created_at"], parts.fetch("expires_after[anchor]"))
    assert_equal(["3600"], parts.fetch("expires_after[seconds]"))
    refute_includes(parts, "expires_after")
  end

  def test_nested_values_use_bracket_notation
    encoded = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      {
        expires_after: {anchor: :created_at, seconds: 3600},
        items: [
          {name: "first", tags: %w[a b]},
          {name: "second", tags: %w[c]}
        ]
      }
    )
    cgi = FakeCGI.new(*encoded)

    assert_equal(
      {
        "expires_after[anchor]" => ["created_at"],
        "expires_after[seconds]" => ["3600"],
        "items[][name]" => %w[first second],
        "items[][tags][]" => %w[a b c]
      },
      cgi.params
    )
  end

  def test_empty_collections_are_omitted
    encoded = OpenAI::Internal::Util.encode_content(
      {"content-type" => "multipart/form-data"},
      {empty_array: [], empty_hash: {}, nested: {empty: []}, present: 1}
    )
    cgi = FakeCGI.new(*encoded)

    assert_equal({"present" => ["1"]}, cgi.params)
  end

  def test_hash_encode
    headers = {"content-type" => "multipart/form-data"}
    cases = {
      {a: 2, b: 3} => {"a" => "2", "b" => "3"},
      {a: 2, b: nil} => {"a" => "2", "b" => "null"},
      {strio: StringIO.new("a")} => {"strio" => "a"},
      {strio: OpenAI::FilePart.new("a")} => {"strio" => "a"},
      {pathname: Pathname(__FILE__)} => {"pathname" => -> { _1.read in /^class OpenAI/ }},
      {pathname: OpenAI::FilePart.new(Pathname(__FILE__))} => {"pathname" => -> { _1.read in /^class OpenAI/ }}
    }
    cases.each do |body, testcase|
      encoded = OpenAI::Internal::Util.encode_content(headers, body)
      cgi = FakeCGI.new(*encoded)
      testcase.each do |key, val|
        assert_pattern do
          parsed = case (p = cgi[key])
          in StringIO
            p.read
          else
            p
          end

          parsed => ^val
        end
      end
    end
  end
end

class OpenAI::Test::UtilIOAdapterTest < Minitest::Test
  def test_copy_read
    cases = {
      StringIO.new("abc") => "abc",
      Enumerator.new { _1 << "abc" } => "abc"
    }
    cases.each do |input, expected|
      io = StringIO.new
      # rubocop:disable Lint/EmptyBlock
      adapter = OpenAI::Internal::Util::ReadIOAdapter.new(input) { }
      # rubocop:enable Lint/EmptyBlock
      IO.copy_stream(adapter, io)
      assert_equal(expected, io.string)
    end
  end

  def test_read_all_from_enumerator
    # rubocop:disable Lint/EmptyBlock
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(["hello ", "world"].each) { }
    # rubocop:enable Lint/EmptyBlock

    assert_equal("hello world", adapter.read)
  end

  def test_io_read_preserves_native_length_conversion
    length = Object.new
    def length.to_int = 2
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(
      StringIO.new("abc")
    ) { |_chunk| nil }

    assert_equal("ab", adapter.read(length))
  end

  def test_enum_read_respects_max_len
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(%w[abc def].to_enum) { |_chunk| nil }

    assert_equal("", adapter.read(0))
    assert_equal("a", adapter.read(1))
    assert_equal("bcd", adapter.read(3))
    assert_equal("ef", adapter.read(99))
    assert_nil(adapter.read(1))
  end

  def test_enum_read_preserves_mixed_encoding_chunks_by_byte_length
    chunks = ["caf\u00E9", "\xFF\xFE".b]
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(chunks.to_enum) { |_chunk| nil }
    actual = String.new.b

    while (chunk = adapter.read(2))
      assert_operator(chunk.bytesize, :<=, 2)
      actual << chunk
    end

    assert_equal(chunks.map(&:b).join, actual)
    assert_equal(Encoding::ASCII_8BIT, actual.encoding)
  end

  def test_enum_read_all_preserves_mixed_encoding_chunks
    chunks = ["caf\u00E9", "\xFF\xFE".b]
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(chunks.to_enum) { |_chunk| nil }

    result = adapter.read

    assert_equal(chunks.map(&:b).join, result)
    assert_equal(Encoding::ASCII_8BIT, result.encoding)
  end

  def test_enum_read_all_includes_buffered_bytes
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(%w[abc def].to_enum) { |_chunk| nil }

    assert_equal("ab", adapter.read(2))
    assert_equal("cdef", adapter.read)
    assert_equal("", adapter.read)
  end

  def test_enum_read_clears_out_string_at_eof
    out = +"stale"
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(["abc"].to_enum) { |_chunk| nil }

    assert_equal("abc", adapter.read(99, out))
    assert_same(out, adapter.read(0, out))
    assert_equal("", out)
    assert_nil(adapter.read(1, out))
    assert_equal("", out)
  end

  def test_enum_read_rejects_negative_lengths
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(["abc"].to_enum) { |_chunk| nil }

    assert_raises(ArgumentError) { adapter.read(-1) }
    assert_equal("abc", adapter.read(99))
    assert_raises(ArgumentError) { adapter.read(-1) }
  end

  def test_copy_write
    cases = {
      StringIO.new => "",
      StringIO.new("abc") => "abc"
    }
    cases.each do |input, expected|
      enum = OpenAI::Internal::Util.writable_enum do |y|
        IO.copy_stream(input, y)
      end

      assert_equal(expected, enum.to_a.join)
    end
  end

  def test_close_interrupts_an_enumerator_without_draining_it
    closed = false
    advanced = false
    input = Enumerator.new do |yielder|
      yielder << "first"
      advanced = true
      raise "request enumerator was drained"
    ensure
      closed = true
    end
    # rubocop:disable Lint/EmptyBlock
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(input) { }
    # rubocop:enable Lint/EmptyBlock

    assert_equal("first", adapter.read(5))
    refute(closed)

    adapter.close

    assert(closed)
    refute(advanced)
  end

  def test_close_does_not_start_an_unread_enumerator
    started = false
    input = Enumerator.new do |yielder|
      started = true
      yielder << "first"
    end
    # rubocop:disable Lint/EmptyBlock
    adapter = OpenAI::Internal::Util::ReadIOAdapter.new(input) { }
    # rubocop:enable Lint/EmptyBlock

    adapter.close

    refute(started)
  end
end

class OpenAI::Test::UtilFusedEnumTest < Minitest::Test
  def test_rewind_closing
    touched = false
    once = 0
    steps = 0
    enum = Enumerator.new do |y|
      next if touched

      10.times do
        steps = _1
        y << _1
      end

    ensure
      once = once.succ
    end

    fused = OpenAI::Internal::Util.fused_enum(enum, external: true) do
      touched = true
      loop { enum.next }
    end

    OpenAI::Internal::Util.close_fused!(fused)

    assert_equal(1, once)
    assert_equal(0, steps)
  end

  def test_thread_interrupts
    once = 0
    que = Queue.new
    enum = Enumerator.new do |y|
      10.times { y << _1 }
    ensure
      once = once.succ
    end

    fused_1 = OpenAI::Internal::Util.fused_enum(enum, external: true) { loop { enum.next } }
    fused_2 = OpenAI::Internal::Util.chain_fused(fused_1) { fused_1.each(&_1) }
    fused_3 = OpenAI::Internal::Util.chain_fused(fused_2) { fused_2.each(&_1) }

    th = ::Thread.new do
      que << "🐶"
      fused_3.each { sleep(10) }
    end

    assert_equal("🐶", que.pop)
    th.kill.join
    assert_equal(1, once)
  end

  def test_closing
    arr = [1, 2, 3]
    once = 0
    fused = OpenAI::Internal::Util.fused_enum(arr.to_enum) do
      once = once.succ
    end

    enumerated_1 = fused.to_a
    assert_equal(arr, enumerated_1)
    assert_equal(1, once)

    enumerated_2 = fused.to_a
    assert_equal([], enumerated_2)
    assert_equal(1, once)
  end

  def test_rewind_chain
    once = 0
    fused = OpenAI::Internal::Util
      .fused_enum([1, 2, 3].to_enum) do
        once = once.succ
      end
      .lazy
      .map(&:succ)
      .filter(&:odd?)
    first = fused.next

    assert_equal(3, first)
    assert_equal(0, once)
    assert_raises(StopIteration) { fused.rewind.next }
    assert_equal(1, once)
  end

  def test_external_iteration
    iter = [1, 2, 3].to_enum
    first = iter.next
    fused = OpenAI::Internal::Util.fused_enum(iter, external: true)

    assert_equal(1, first)
    assert_equal([2, 3], fused.to_a)
  end

  def test_close_fused
    once = 0
    fused = OpenAI::Internal::Util.fused_enum([1, 2, 3].to_enum) do
      once = once.succ
    end

    OpenAI::Internal::Util.close_fused!(fused)

    assert_equal(1, once)
    assert_equal([], fused.to_a)
    assert_equal(1, once)
  end

  def test_closed_fused_extern_iteration
    taken = 0
    enum = [1, 2, 3].to_enum.lazy.map do
      taken = taken.succ
      _1
    end

    fused = OpenAI::Internal::Util.fused_enum(enum)
    first = fused.next

    assert_equal(1, first)
    OpenAI::Internal::Util.close_fused!(fused)
    assert_equal(1, taken)
  end

  def test_closed_fused_taken_count
    taken = 0
    enum = [1, 2, 3]
      .to_enum
      .lazy
      .map do
        taken = taken.succ
        _1
      end
      .map(&:succ)
      .filter(&:odd?)
    fused = OpenAI::Internal::Util.fused_enum(enum)

    assert_equal(0, taken)
    OpenAI::Internal::Util.close_fused!(fused)
    assert_equal(0, taken)
  end

  def test_closed_fused_extern_iter_taken_count
    taken = 0
    enum = [1, 2, 3]
      .to_enum
      .lazy
      .map do
        taken = taken.succ
        _1
      end
      .map(&:succ)
      .filter(&:itself)
    first = enum.next
    assert_equal(2, first)
    assert_equal(1, taken)

    fused = OpenAI::Internal::Util.fused_enum(enum)
    OpenAI::Internal::Util.close_fused!(fused)
    assert_equal(1, taken)
  end

  def test_close_fused_sse_chain
    taken = 0
    enum = [1, 2, 3]
      .to_enum
      .lazy
      .map do
        taken = taken.succ
        _1
      end
      .map(&:succ)
      .filter(&:odd?)
      .map(&:to_s)

    fused_1 = OpenAI::Internal::Util.fused_enum(enum)
    fused_2 = OpenAI::Internal::Util.decode_lines(fused_1)
    fused_3 = OpenAI::Internal::Util.decode_sse(fused_2)

    assert_equal(0, taken)
    OpenAI::Internal::Util.close_fused!(fused_3)
    assert_equal(0, taken)
  end
end

class OpenAI::Test::UtilContentDecodingTest < Minitest::Test
  def test_charset
    cases = {
      "application/json" => Encoding::BINARY,
      "application/json; charset=utf-8" => Encoding::UTF_8,
      "charset=uTf-8 application/json; " => Encoding::UTF_8,
      "charset=UTF-8; application/json; " => Encoding::UTF_8,
      "charset=ISO-8859-1 ;application/json; " => Encoding::ISO_8859_1,
      "charset=EUC-KR ;application/json; " => Encoding::EUC_KR
    }
    text = String.new.force_encoding(Encoding::BINARY)
    cases.each do |content_type, encoding|
      OpenAI::Internal::Util.force_charset!(content_type, text: text)
      assert_equal(encoding, text.encoding)
    end
  end
end

class OpenAI::Test::UtilSseTest < Minitest::Test
  def test_decode_lines
    cases = {
      %w[] => %w[],
      %W[\n\n] => %W[\n \n],
      %W[\n \n] => %W[\n \n],
      %w[a] => %w[a],
      %W[a\nb] => %W[a\n b],
      %W[a\nb\n] => %W[a\n b\n],
      %W[\na b\n] => %W[\n ab\n],
      %W[\na b\n\n] => %W[\n ab\n \n],
      %W[\na b] => %W[\n ab],
      %W[\u1F62E\u200D\u1F4A8] => %W[\u1F62E\u200D\u1F4A8],
      %W[\u1F62E \u200D \u1F4A8] => %W[\u1F62E\u200D\u1F4A8],
      ["\xf0\x9f".b, "\xa5\xba".b] => ["\xf0\x9f\xa5\xba".b],
      ["\xf0".b, "\x9f".b, "\xa5".b, "\xba".b] => ["\xf0\x9f\xa5\xba".b]
    }
    eols = %W[\n \r \r\n]
    cases.each do |enum, expected|
      eols.each do |eol|
        lines = OpenAI::Internal::Util.decode_lines(enum.map { _1.gsub("\n", eol) })
        assert_equal(expected.map { _1.gsub("\n", eol) }, lines.to_a, "eol=#{JSON.generate(eol)}")
      end
    end
  end

  def test_mixed_decode_lines
    cases = {
      %w[] => %w[],
      %W[\r\r] => %W[\r \r],
      %W[\r \r] => %W[\r \r],
      %W[\r\r\r] => %W[\r \r \r],
      %W[\r\r \r] => %W[\r \r \r],
      %W[\r \n] => %W[\r\n],
      %W[\r\r\n] => %W[\r \r\n],
      %W[\n\r] => %W[\n \r]
    }
    cases.each do |enum, expected|
      lines = OpenAI::Internal::Util.decode_lines(enum)
      assert_equal(expected, lines.to_a)
    end
  end

  def test_decode_sse
    cases = {
      "empty input" => {
        [] => []
      },
      "single data event" => {
        [
          "data: hello world\n",
          "\n"
        ] => [
          {data: "hello world\n"}
        ]
      },
      "multiple data lines" => {
        [
          "data: line 1\n",
          "data: line 2\n",
          "\n"
        ] => [
          {data: "line 1\nline 2\n"}
        ]
      },
      "complete event" => {
        [
          "id: 123\n",
          "event: update\n",
          "data: hello world\n",
          "retry: 5000\n",
          "\n"
        ] => [
          {
            event: "update",
            id: "123",
            data: "hello world\n",
            retry: 5000
          }
        ]
      },
      "multiple events" => {
        [
          "event: update\n",
          "data: first\n",
          "\n",
          "event: message\n",
          "data: second\n",
          "\n"
        ] => [
          {event: "update", data: "first\n"},
          {event: "message", data: "second\n"}
        ]
      },
      "comments" => {
        [
          ": this is a comment\n",
          "data: actual data\n",
          "\n"
        ] => [
          {data: "actual data\n"}
        ]
      },
      "invalid retry" => {
        [
          "retry: not a number\n",
          "data: hello\n",
          "\n"
        ] => [
          {data: "hello\n"}
        ]
      },
      "invalid id with null" => {
        [
          "id: bad\0id\n",
          "data: hello\n",
          "\n"
        ] => [
          {data: "hello\n"}
        ]
      },
      "leading space in value" => {
        [
          "data: hello world\n",
          "data:  leading space\n",
          "\n"
        ] => [
          {data: "hello world\n leading space\n"}
        ]
      },
      "no final newline" => {
        [
          "data: hello\n",
          "id: 1"
        ] => [
          {data: "hello\n", id: "1"}
        ]
      },
      "multiple empty lines" => {
        [
          "data: first\n",
          "\n",
          "\n",
          "data: second\n",
          "\n"
        ] => [
          {data: "first\n"},
          {data: "second\n"}
        ]
      },
      "multibyte unicode" => {
        [
          "data: \u1F62E\u200D\u1F4A8\n"
        ] => [
          {data: "\u1F62E\u200D\u1F4A8\n"}
        ]
      }
    }

    cases.each do |name, test_cases|
      test_cases.each do |input, expected|
        actual = OpenAI::Internal::Util.decode_sse(input).map(&:compact)
        assert_equal(expected, actual, name)
      end
    end
  end
end
