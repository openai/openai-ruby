# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::FilePartTest < Minitest::Test
  def test_to_json
    text = "gray"
    filepart = OpenAI::FilePart.new(StringIO.new(text))

    assert_equal(text.to_json, filepart.to_json)
  end
end
