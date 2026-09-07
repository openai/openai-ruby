# frozen_string_literal: true

require "rbi"

require_relative "test_helper"

class OpenAI::Test::ExportedRBITest < Minitest::Test
  def test_exported_signatures_merge_without_conflicts
    paths = Dir.glob(File.expand_path("../../rbi/**/*.rbi", __dir__))
    refute_empty(paths)

    # Tapioca discards the entire exported tree if this merge has any conflicts.
    merger = RBI::Rewriters::Merge.new(keep: RBI::Rewriters::Merge::Keep::NONE)
    paths.each { merger.merge(RBI::Parser.parse_file(_1)) }

    conflicts = merger.tree.conflicts.map { "#{_1}: #{_1.left.loc} and #{_1.right.loc}" }
    assert_empty(conflicts)
  end
end
