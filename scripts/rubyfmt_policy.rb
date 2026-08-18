# frozen_string_literal: true

require_relative "rubocop_directive_guard"

module RubyfmtPolicy
  module_function

  def paths(inputs = ["."])
    return [] if inputs.empty?

    RuboCopDirectiveGuard.rubocop_target_paths(inputs).reject { _1.end_with?(".rbi") }
  end

  def violations(paths)
    paths.filter_map do |path|
      # Match rubyfmt's first magic header in the first 500 bytes.
      header = File.binread(path, 500).force_encoding(Encoding::UTF_8).scrub
      enabled = header[/^#\s*rubyfmt:\s*(true|false)\s*$/, 1]
      next unless enabled == "false"

      "#{path}: rubyfmt opt-outs are not allowed"
    end
  end
end
