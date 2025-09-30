# frozen_string_literal: true

require_relative "../test_helper"

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
      OpenAI::Internal::Util.dig([], ->(_) { 2 }) => 2
      OpenAI::Internal::Util.dig([1], -> { _1 in [1] }) => true
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

class OpenAI::Test::RegexMatchTest < Minitest::Test
  def test_json_content
    cases = {
      "application/json" => true,
      "application/jsonl" => false,
      "application/vnd.github.v3+json" => true,
      "application/vnd.api+json" => true
    }
    cases.each do |header, verdict|
      assert_pattern do
        OpenAI::Internal::Util::JSON_CONTENT.match?(header) => ^verdict
      end
    end
  end

  def test_jsonl_content
    cases = {
      "application/x-ndjson" => true,
      "application/x-ldjson" => true,
      "application/jsonl" => true,
      "application/x-jsonl" => true,
      "application/json" => false,
      "application/vnd.api+json" => false
    }
    cases.each do |header, verdict|
      assert_pattern do
        OpenAI::Internal::Util::JSONL_CONTENT.match?(header) => ^verdict
      end
    end
  end
end

class OpenAI::Test::UtilFormDataEncodingTest < Minitest::Test
  class FakeCGI < CGI
    def initialize(headers, io)
      encoded = io.to_a
      @ctype = headers["content-type"]
      # rubocop:disable Lint/EmptyBlock
      @io = OpenAI::Internal::Util::ReadIOAdapter.new(encoded.to_enum) {}
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
    assert_pattern do
      headers.fetch("content-type") => /boundary=(.+)$/
    end
    field, = Regexp.last_match.captures
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
      OpenAI::FilePart.new(file, filename: "d o g") => ["d%20o%20g", /^class OpenAI/]
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

  def test_hash_encode
    headers = {"content-type" => "multipart/form-data"}
    cases = {
      {a: 2, b: 3} => {"a" => "2", "b" => "3"},
      {a: 2, b: nil} => {"a" => "2", "b" => "null"},
      {a: 2, b: [1, 2, 3]} => {"a" => "2", "b" => "1"},
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
          parsed =
            case (p = cgi[key])
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
      adapter = OpenAI::Internal::Util::ReadIOAdapter.new(input) {}
      # rubocop:enable Lint/EmptyBlock
      IO.copy_stream(adapter, io)
      assert_equal(expected, io.string)
    end
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
    fused = OpenAI::Internal::Util.fused_enum([1, 2, 3].to_enum) do
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
    enum = [1, 2, 3].to_enum.lazy.map do
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
    enum = [1, 2, 3].to_enum.lazy.map do
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
    enum = [1, 2, 3].to_enum.lazy.map do
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
