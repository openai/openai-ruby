# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::FilePartTest < Minitest::Test
  def test_to_json
    text = "gray"
    filepart = OpenAI::FilePart.new(StringIO.new(text))

    assert_equal(text.to_json, filepart.to_json)
    assert_equal(text.to_yaml, filepart.to_yaml)
  end

  def test_with_content_preserves_original_and_effective_multipart_metadata
    original = OpenAI::FilePart.new("contents")
    replacement = Pathname("replacement")

    copy = original.with_content(replacement)

    assert_equal("contents", original.content)
    assert_nil(original.content_type)
    assert_same(replacement, copy.content)
    assert_equal("text/plain", copy.content_type)
    assert_nil(copy.filename)
  end
end
