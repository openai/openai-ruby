# frozen_string_literal: true

require "securerandom"
require "syntax_tree/rbs"

module RBSFormat
  module_function

  def format(source)
    marker = SecureRandom.uuid
    restorations = {}
    # Preserve the existing workaround for Syntax Tree's unsupported class/module aliases.
    protected_source = source.dup
    alias_declarations(RBS::Parser.parse_signature(source).last).reverse_each do |declaration|
      location = declaration.location
      kind = location.source.split.first
      restorations[location.start_pos] = if location.source.include?("#")
        location.source
      else
        "#{kind} #{declaration.new_name} = #{declaration.old_name}"
      end

      protected_source[location.start_pos...location.end_pos] = "# #{kind} #{marker}-#{location.start_pos}\n#{declaration.new_name}: #{declaration.old_name}"
    end

    SyntaxTree::RBS.format(protected_source).gsub(
      /# (?:class|module) #{Regexp.escape(marker)}-(\d+)\n *[^\n]+$/
    ) do
      restorations.fetch(Regexp.last_match(1).to_i)
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
