# frozen_string_literal: true

require "minitest/autorun"
require "tempfile"

require_relative "../../scripts/rbs_format"

class RBSFormatTest < Minitest::Test
  def test_preserves_optional_record_fields_and_their_value_types
    source = <<~RBS
      type record = { required: String, nullable: String?, ?optional: String, ?maybe: String?, ?"str-key" => { ?nested: Integer }, ?item_1: bool }
    RBS
    formatted = RBSFormat.format(source)
    before = RBS::Parser.parse_signature(source).last.first.type
    after = RBS::Parser.parse_signature(formatted).last.first.type

    assert_equal(before, after)
    assert_equal(formatted, RBSFormat.format(formatted))
    assert_equal([:required, :nullable], after.fields.keys)
    assert_equal([:optional, :maybe, "str-key", :item_1], after.optional_fields.keys)
  end

  def test_preserves_optional_only_records_in_method_returns
    source = "class Example\n  def to_hash: -> { ?name: String }\nend\n"
    formatted = RBSFormat.format(source)

    assert_includes(formatted, "?name: String")
    assert_equal(formatted, RBSFormat.format(formatted))
  end

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

  def test_does_not_treat_multiline_annotation_contents_as_aliases
    source = <<~RBS
      %a{metadata
      class   Alias   =   Original
      module\tOther\t=\tTarget
      }
      class Example
      end
    RBS

    assert_equal(SyntaxTree::RBS.format(source), RBSFormat.format(source))
  end

  def test_preserves_qualified_and_absolute_class_and_module_aliases
    {
      "class   Foo::Bar   =   Baz\n" => "class Foo::Bar = Baz\n",
      "class   ::Foo   =   Bar\n" => "class ::Foo = Bar\n",
      "module\tFoo::Bar\t=\tBaz\n" => "module Foo::Bar = Baz\n",
      "module\t::Foo\t=\tBar\n" => "module ::Foo = Bar\n"
    }.each do |source, expected|
      assert_equal(expected, RBSFormat.format(source))
    end
  end

  def test_preserves_comments_within_multiline_alias_declarations
    [
      "class Foo # compatibility alias\n  = Bar\n",
      "class # alias kind\n  Foo = Bar\n",
      "class Foo = # alias target\n  Bar\n",
      "module Foo # first comment\n  # second comment\n  = Bar\n",
      "module ::Foo # qualified alias\n  = ::Bar\n"
    ].each do |source|
      assert_equal(source, RBSFormat.format(source))
    end
  end

  def test_preserves_class_alias_with_adjacent_keyword_comment
    source = "class# compatibility note\n  Foo::Bar = ::Baz\n"
    formatted = RBSFormat.format(source)

    assert_equal(source, formatted)
    assert_equal(formatted, RBSFormat.format(formatted))
  end

  def test_preserves_module_alias_with_adjacent_keyword_comment
    source = "module# compatibility note\n  ::Foo = ::Bar\n"
    formatted = RBSFormat.format(source)

    assert_equal(source, formatted)
    assert_equal(formatted, RBSFormat.format(formatted))
  end

  def test_write_mode_preserves_aliases_with_adjacent_keyword_comments
    %w[class module].each do |kind|
      source = "#{kind}# compatibility note\n  Alias = Target\n"

      Tempfile.create(["rbs-format", ".rbs"]) do |file|
        file.write(source)
        file.flush

        assert_empty(RBSFormat.run([file.path], check: false))
        assert_equal(source, File.read(file.path))
      end
    end
  end

  def test_preserves_each_nested_alias_comment_and_formats_ordinary_aliases
    source = <<~RBS
      module Example
        class First # first compatibility alias
          = One
        module ::Second # second compatibility alias
          = ::Two
        class   Third   =   Three
      end
    RBS

    formatted = RBSFormat.format(source)

    assert_includes(formatted, "  class First # first compatibility alias\n    = One")
    assert_includes(formatted, "  module ::Second # second compatibility alias\n    = ::Two")
    assert_includes(formatted, "  class Third = Three")
    assert_equal(formatted, RBSFormat.format(formatted))
  end

  def test_preserves_nested_aliases_without_rewriting_annotation_contents
    source = <<~RBS
      module Outer
        %a{metadata
      class   Fake   =   Original
      }
        class Inner
          class   Foo::Bar   =   ::Baz
          module\t::Other\t=\tTarget
        end
      end
    RBS

    formatted = RBSFormat.format(source)

    assert_includes(formatted, "class   Fake   =   Original")
    assert_includes(formatted, "    class Foo::Bar = ::Baz")
    assert_includes(formatted, "    module ::Other = Target")
    assert_equal(formatted, RBSFormat.format(formatted))
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
