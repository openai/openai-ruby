# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::FilePartSerializationCursorTest < Minitest::Test
  def test_string_io_serializers_use_bytes_remaining_at_current_cursor
    [
      [0, "abcdef"],
      [3, "def"],
      [6, ""],
      [10, ""]
    ].each do |position, expected|
      content = StringIO.new("abcdef")
      content.pos = position
      file = OpenAI::FilePart.new(content)

      assert_equal(expected, JSON.parse(file.to_json), "JSON at byte position #{position}")
      assert_equal(expected, YAML.safe_load(file.to_yaml), "YAML at byte position #{position}")
      assert_equal(position, content.pos)
      refute_predicate(content, :closed?)
    end
  end

  def test_string_io_serializers_slice_at_utf8_byte_boundaries_without_consuming
    content = StringIO.new("éx")
    content.pos = "é".bytesize
    file = OpenAI::FilePart.new(content)

    2.times do
      assert_equal("x", JSON.parse(file.to_json))
      assert_equal("x", YAML.safe_load(file.to_yaml))
      assert_equal("é".bytesize, content.pos)
      refute_predicate(content, :closed?)
    end
  end
end
