# frozen_string_literal: true

require "minitest/autorun"

require_relative "../../scripts/rbs_format"

class RBSFormatTest < Minitest::Test
  def test_preserves_class_alias_with_multiple_spaces
    source = "module Example\n  class   Alias   =   ::String\nend\n"

    assert_equal("module Example\n  class Alias = ::String\nend\n", RBSFormat.format(source))
  end

  def test_preserves_module_alias_with_tabs
    source = "module Example\n\tmodule\tAlias\t=\t::Enumerable\nend\n"

    assert_equal("module Example\n  module Alias = ::Enumerable\nend\n", RBSFormat.format(source))
  end

  def test_does_not_treat_commented_declarations_as_aliases
    source = <<~RBS
      # class Alias = ::String
      # module Other = ::Enumerable
      class Example
      end
    RBS

    assert_equal(SyntaxTree::RBS.format(source), RBSFormat.format(source))
  end

  def test_preserves_ordinary_aliases_and_formats_surrounding_declarations
    source = <<~RBS
      module Example
        class Alias = ::String
        module Other = ::Enumerable
        def call: (String value)->String
      end
    RBS

    expected = <<~RBS
      module Example
        class Alias = ::String

        module Other = ::Enumerable
        def call: (String value) -> String
      end
    RBS

    assert_equal(expected, RBSFormat.format(source))
  end

  def test_formatting_aliases_and_comments_is_idempotent
    source = <<~RBS
      # class Commented = ::String
      module Example
        class   Alias   =   ::String
      \tmodule\tOther\t=\t::Enumerable
        # module Commented = ::Enumerable
        def call: (String value)->String
      end
    RBS

    formatted = RBSFormat.format(source)

    assert_equal(formatted, RBSFormat.format(formatted))
  end
end
