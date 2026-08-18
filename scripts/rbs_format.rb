# frozen_string_literal: true

require "securerandom"
require "syntax_tree/rbs"

module RBSFormat
  module_function

  def format(source)
    marker = SecureRandom.uuid
    # Preserve the existing workaround for Syntax Tree's unsupported class/module aliases.
    protected_source = source.gsub(/(class|module) ([^ \n]+) = (.+$)/) do
      "# #{Regexp.last_match(1)} #{marker}\n#{Regexp.last_match(2)}: #{Regexp.last_match(3)}"
    end

    SyntaxTree::RBS.format(protected_source).gsub(
      /# (class|module) #{Regexp.escape(marker)}\n *([^:\n]+): (.+)$/
    ) do
      "#{Regexp.last_match(1)} #{Regexp.last_match(2)} = #{Regexp.last_match(3)}"
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
