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

  def test_merge_preserves_conflicts_before_later_typed_declarations
    trees = [
      "class A; def m(x); end; end",
      "class A; def m(x); end; end",
      "class A; def m(y); end; end",
      "class A; sig {params(x: String).void}; def m(x); end; end"
    ].map { RBI::Parser.parse_string(_1) }

    conflicts = merge_conflicts(trees)
    assert_equal(1, conflicts.size)
    assert_equal("Conflicting definitions for `::A#m(x)`", conflicts.first.to_s)
  end

  private

  def merge_conflicts(trees)
    # Match Tapioca's ordered merge: regrouping trees can hide a conflict when
    # a later typed declaration replaces an earlier untyped method's parameters.
    merger = RBI::Rewriters::Merge.new(keep: RBI::Rewriters::Merge::Keep::NONE)
    trees.each { merger.merge(_1) }
    merger.tree.conflicts
  end
end
