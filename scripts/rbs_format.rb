# frozen_string_literal: true

require "securerandom"
require "syntax_tree/rbs"

module RBSFormat
  # Syntax Tree currently visits only Record#fields, which excludes optional
  # keys. Keep the full record and format its value types with the normal visitor.
  class Format < SyntaxTree::RBS::Format
    def visit_record_type(node)
      separator = lambda do
        q.text(",")
        q.breakable
      end

      q.group do
        q.text("{")
        q.indent do
          q.breakable
          q.seplist(node.all_fields, separator, :each_pair) do |key, (type, required)|
            q.text("?") unless required
            if key.is_a?(Symbol) && key.match?(/\A[A-Za-z_][A-Za-z_]*\z/)
              q.text("#{key}: ")
            else
              q.text("#{key.inspect} => ")
            end

            visit(type)
          end
        end

        q.breakable
        q.text("}")
      end
    end
  end

  module_function

  def format(source)
    marker = SecureRandom.uuid
    restorations = {}
    # Preserve the existing workaround for Syntax Tree's unsupported class/module aliases.
    protected_source = source.dup
    alias_declarations(RBS::Parser.parse_signature(source).last).reverse_each do |declaration|
      location = declaration.location
      kind = location[:keyword].source
      restorations[location.start_pos] = if location.source.include?("#")
        location.source
      else
        "#{kind} #{declaration.new_name} = #{declaration.old_name}"
      end

      protected_source[location.start_pos...location.end_pos] = "# #{kind} #{marker}-#{location.start_pos}\n#{declaration.new_name}: #{declaration.old_name}"
    end

    formatter = SyntaxTree::RBS::Formatter.new(protected_source, [], 80)
    Format.new(formatter).visit(SyntaxTree::RBS.parse(protected_source))
    formatter.flush
    formatter.output.join.gsub(
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
