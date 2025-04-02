# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::UtilDataHandlingTest < Minitest::Test
  def test_left_map
    assert_pattern do
      OpenAI::Util.deep_merge({a: 1}, nil) => nil
    end
  end

  def test_right_map
    assert_pattern do
      OpenAI::Util.deep_merge(nil, {a: 1}) => {a: 1}
    end
  end

  def test_disjoint_maps
    assert_pattern do
      OpenAI::Util.deep_merge({b: 2}, {a: 1}) => {a: 1, b: 2}
    end
  end

  def test_overlapping_maps
    assert_pattern do
      OpenAI::Util.deep_merge({b: 2, c: 3}, {a: 1, c: 4}) => {a: 1, b: 2, c: 4}
    end
  end

  def test_nested
    assert_pattern do
      OpenAI::Util.deep_merge({b: {b2: 1}}, {b: {b2: 2}}) => {b: {b2: 2}}
    end
  end

  def test_nested_left_map
    assert_pattern do
      OpenAI::Util.deep_merge({b: {b2: 1}}, {b: 6}) => {b: 6}
    end
  end

  def test_omission
    merged = OpenAI::Util.deep_merge(
      {b: {b2: 1, b3: {c: 4, d: 5}}},
      {b: {b2: 1, b3: {c: OpenAI::Util::OMIT, d: 5}}}
    )

    assert_pattern do
      merged => {b: {b2: 1, b3: {d: 5}}}
    end
  end

  def test_concat
    merged = OpenAI::Util.deep_merge(
      {a: {b: [1, 2]}},
      {a: {b: [3, 4]}},
      concat: true
    )

    assert_pattern do
      merged => {a: {b: [1, 2, 3, 4]}}
    end
  end

  def test_concat_false
    merged = OpenAI::Util.deep_merge(
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
      OpenAI::Util.dig(1, nil) => 1
      OpenAI::Util.dig({a: 1}, :b) => nil
      OpenAI::Util.dig({a: 1}, :a) => 1
      OpenAI::Util.dig({a: {b: 1}}, [:a, :b]) => 1

      OpenAI::Util.dig([], 1) => nil
      OpenAI::Util.dig([nil, [nil, 1]], [1, 1]) => 1
      OpenAI::Util.dig({a: [nil, 1]}, [:a, 1]) => 1
      OpenAI::Util.dig([], 1.0) => nil

      OpenAI::Util.dig(Object, 1) => nil
      OpenAI::Util.dig([], 1.0, 2) => 2
      OpenAI::Util.dig([], 1.0) { 2 } => 2
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
      parsed = OpenAI::Util.parse_uri(url)
      unparsed = OpenAI::Util.unparse_uri(parsed).to_s

      assert_equal(url, unparsed)
      assert_equal(parsed, OpenAI::Util.parse_uri(unparsed))
    end
  end

  def test_joining
    cases = [
      [
        "h://a.b/c?d=e",
        "h://nope/ignored",
        OpenAI::Util.parse_uri("h://a.b/c?d=e")
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
        OpenAI::Util.join_parsed_uri(
          OpenAI::Util.parse_uri(lhs),
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
        OpenAI::Util.join_parsed_uri(
          OpenAI::Util.parse_uri(base_url),
          {path: path}
        )
      )
    end
  end
end

class OpenAI::Test::UtilFormDataEncodingTest < Minitest::Test
  class FakeCGI < CGI
    def initialize(headers, io)
      @ctype = headers["content-type"]
      # rubocop:disable Lint/EmptyBlock
      @io = OpenAI::Util::ReadIOAdapter.new(io) {}
      # rubocop:enable Lint/EmptyBlock
      @c_len = io.to_a.join.bytesize.to_s
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

  def test_file_encode
    headers = {"content-type" => "multipart/form-data"}
    cases = {
      StringIO.new("abc") => "abc"
    }
    cases.each do |body, val|
      encoded = OpenAI::Util.encode_content(headers, body)
      cgi = FakeCGI.new(*encoded)
      assert_pattern do
        cgi[""] => ^val
      end
    end
  end

  def test_hash_encode
    headers = {"content-type" => "multipart/form-data"}
    cases = {
      {a: 2, b: 3} => {"a" => "2", "b" => "3"},
      {a: 2, b: nil} => {"a" => "2", "b" => "null"},
      {a: 2, b: [1, 2, 3]} => {"a" => "2", "b" => "1"},
      {file: StringIO.new("a")} => {"file" => "a"}
    }
    cases.each do |body, testcase|
      encoded = OpenAI::Util.encode_content(headers, body)
      cgi = FakeCGI.new(*encoded)
      testcase.each do |key, val|
        assert_equal(val, cgi[key])
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
      adapter = OpenAI::Util::ReadIOAdapter.new(input) {}
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
      enum = OpenAI::Util.writable_enum do |y|
        IO.copy_stream(input, y)
      end
      assert_equal(expected, enum.to_a.join)
    end
  end
end

class OpenAI::Test::UtilFusedEnumTest < Minitest::Test
  def test_closing
    arr = [1, 2, 3]
    once = 0
    fused = OpenAI::Util.fused_enum(arr.to_enum) do
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
    fused = OpenAI::Util.fused_enum([1, 2, 3].to_enum) do
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
    it = [1, 2, 3].to_enum
    first = it.next
    fused = OpenAI::Util.fused_enum(it, external: true)

    assert_equal(1, first)
    assert_equal([2, 3], fused.to_a)
  end

  def test_close_fused
    once = 0
    fused = OpenAI::Util.fused_enum([1, 2, 3].to_enum) do
      once = once.succ
    end

    OpenAI::Util.close_fused!(fused)

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
    fused = OpenAI::Util.fused_enum(enum)
    first = fused.next

    assert_equal(1, first)
    OpenAI::Util.close_fused!(fused)
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
    fused = OpenAI::Util.fused_enum(enum)

    assert_equal(0, taken)
    OpenAI::Util.close_fused!(fused)
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

    fused = OpenAI::Util.fused_enum(enum)
    OpenAI::Util.close_fused!(fused)
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

    fused_1 = OpenAI::Util.fused_enum(enum)
    fused_2 = OpenAI::Util.decode_lines(fused_1)
    fused_3 = OpenAI::Util.decode_sse(fused_2)

    assert_equal(0, taken)
    OpenAI::Util.close_fused!(fused_3)
    assert_equal(0, taken)
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
      %W[\u1F62E \u200D \u1F4A8] => %W[\u1F62E\u200D\u1F4A8]
    }
    eols = %W[\n \r \r\n]
    cases.each do |enum, expected|
      eols.each do |eol|
        lines = OpenAI::Util.decode_lines(enum.map { _1.gsub("\n", eol) })
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
      lines = OpenAI::Util.decode_lines(enum)
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
        actual = OpenAI::Util.decode_sse(input).map(&:compact)
        assert_equal(expected, actual, name)
      end
    end
  end
end
