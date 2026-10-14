# frozen_string_literal: true

require "minitest/autorun"
require "tempfile"

require_relative "../../scripts/rbs_format"

class RBSFormatCommentLossTest < Minitest::Test
  LOSSY_SOURCES = [
    "type label = String # keep explanation\n",
    "Example: String # keep explanation\n",
    "class Example\n  def call: -> String # keep explanation\nend\n"
  ].freeze

  def test_format_refuses_results_that_lose_trailing_comments
    LOSSY_SOURCES.each do |source|
      error = assert_raises(RuntimeError) { RBSFormat.format(source) }

      assert_equal("RBS formatter cannot safely preserve comments; format manually", error.message)
    end
  end

  def test_check_and_write_paths_leave_lossy_source_unchanged
    LOSSY_SOURCES.each do |source|
      Tempfile.create(["rbs-format-comment-loss", ".rbs"]) do |file|
        file.write(source)
        file.flush

        assert_raises(RuntimeError) { RBSFormat.run([file.path], check: true) }
        assert_equal(source, File.read(file.path))

        assert_raises(RuntimeError) { RBSFormat.run([file.path], check: false) }
        assert_equal(source, File.read(file.path))
      end
    end
  end

  def test_preserved_comments_and_literal_hashes_still_format_idempotently
    source = <<~RBS
      # first comment
      # second comment
      # first comment
      %a{# not a comment}
      type label = "# not a comment"
      class   Alias   =   ::String # alias comment
    RBS
    source = source.sub("# first comment\n", "# first comment  \n")

    formatted = RBSFormat.format(source)

    assert_equal(formatted, RBSFormat.format(formatted))
    assert_equal(
      ["# first comment", "# second comment", "# first comment", "# alias comment"],
      comments(formatted)
    )
  end

  def test_crlf_comment_whitespace_does_not_look_lossy
    source = "# keep explanation\r\nclass   Example\r\nend\r\n"

    formatted = RBSFormat.format(source)

    assert_equal("# keep explanation\nclass Example\nend\n", formatted)
    assert_equal(formatted, RBSFormat.format(formatted))
  end

  private

  def comments(source)
    RBS::Parser.lex(source).value.select(&:comment?).map do |token|
      token.value.sub(/[ \t\r]+\z/, "")
    end
  end
end
