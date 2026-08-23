# frozen_string_literal: true

require "securerandom"
require "syntax_tree/rbs"

module RBSFormat
  module_function

  def format(source)
    marker = SecureRandom.uuid
    # Preserve the existing workaround for Syntax Tree's unsupported class/module aliases.
    protected_source = source.dup
    alias_declarations(RBS::Parser.parse_signature(source).last).reverse_each do |declaration|
      location = declaration.location
      kind = location.source.split.first
      protected_source[location.start_pos...location.end_pos] = "# #{kind} #{marker}\n#{declaration.new_name}: #{declaration.old_name}"
    end

    SyntaxTree::RBS.format(protected_source).gsub(
      /# (class|module) #{Regexp.escape(marker)}\n *([^ \n]+): (.+)$/
    ) do
      "#{Regexp.last_match(1)} #{Regexp.last_match(2)} = #{Regexp.last_match(3)}"
    end
  end

  def alias_declarations(declarations)
    declarations.flat_map do |declaration|
      case declaration
      when RBS::AST::Declarations::AliasDecl
        declaration
      when RBS::AST::Declarations::Class, RBS::AST::Declarations::Module
        alias_declarations(declaration.each_decl.to_a)
      else
        []
      end
    end
  end

  def run(paths, check:)
    paths.sort.uniq.filter_map do |path|
      source = File.read(path)
      formatted = format(source)
      next if source == formatted

      File.write(path, formatted) unless check
      path
    end
  end
end
