# frozen_string_literal: true

require "rbi"

require_relative "test_helper"

class OpenAI::Test::ExportedRBITest < Minitest::Test
  def test_exported_signatures_merge_without_conflicts
    paths = Dir.glob(File.expand_path("../../rbi/**/*.rbi", __dir__))
    refute_empty(paths)

    # Tapioca discards the entire exported tree if this merge has any conflicts.
    conflicts = merge_conflicts(paths.map { RBI::Parser.parse_file(_1) })
    assert_empty(conflicts.map { "#{_1}: #{_1.left.loc} and #{_1.right.loc}" })
  end

  def test_merge_preserves_conflicts_within_and_between_pairs
    trees = [
      "class WithinPair < String; end",
      "class WithinPair < Integer; end",
      "class AcrossPairs < String; end",
      "class Unrelated; end",
      "class AcrossPairs < Integer; end"
    ].map { RBI::Parser.parse_string(_1) }

    conflicts = merge_conflicts(trees)
    assert_equal(2, conflicts.size)
    assert_equal(%w[::AcrossPairs ::WithinPair], conflicts.map { _1.left.fully_qualified_name }.sort)
  end

  private

  def merge_conflicts(trees)
    conflicts = []
    # Each merge indexes its entire accumulated output. A left fold over all
    # 1,300 files repeatedly indexes growing prefixes; adjacent pairs keep the
    # same file order while limiting that work to logarithmically many levels.
    while trees.size > 1
      trees = trees.each_slice(2).map do |pair|
        merger = RBI::Rewriters::Merge.new(keep: RBI::Rewriters::Merge::Keep::NONE)
        pair.each { merger.merge(_1) }
        # Later merges need not retain a child MergeTree's conflict metadata.
        conflicts.concat(merger.tree.conflicts)
        merger.tree
      end
    end

    conflicts
  end
end
