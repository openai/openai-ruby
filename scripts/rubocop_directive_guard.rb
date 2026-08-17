# frozen_string_literal: true

require "date"
require "ripper"
require "rubocop"

module RuboCopDirectiveGuard
  DirectiveText = Data.define(:text)
  TODO_OWNER = /(?:\A|;)\s*owner:\s*[^;\s]+/
  TODO_ISSUE = %r{
    (?:\A|;)\s*issue:\s*(?:\#\d+|https?://[^;\s]+)
    (?=\s*(?:;|\z))
  }x
  TODO_REMOVE_BY = /(?:\A|;)\s*remove-by:\s*(\d{4}-\d{2}-\d{2})(?=\s*(?:;|\z))/

  module_function

  def violations_for(path, source)
    violations = []
    Ripper.lex(source).each do |(line_number, _column), token, comment, _state|
      next unless token == :on_comment

      directive = RuboCop::DirectiveComment.new(DirectiveText.new(comment), nil)
      next if directive.mode.nil?

      action = directive.mode
      cops = directive.raw_cop_names
      metadata = comment.partition("--").then { |_, marker, text| text if marker == "--" }
      next if action == "enable"

      if cops.any? { _1.casecmp("all").zero? }
        violations << "#{path}:#{line_number}: rubocop:#{action} all is forbidden"
      end
      cops.reject { _1.include?("/") }.each do |department|
        violations <<
          "#{path}:#{line_number}: department-wide rubocop:#{action} #{department} is forbidden"
      end
      next unless action == "todo"

      unless metadata&.match?(TODO_OWNER)
        violations << "#{path}:#{line_number}: rubocop:todo requires `owner: ...` metadata"
      end
      unless valid_todo_removal?(metadata)
        violations <<
          "#{path}:#{line_number}: rubocop:todo requires `issue: #123` or `remove-by: YYYY-MM-DD` metadata"
      end
    end
    violations
  end

  def valid_todo_removal?(metadata)
    return false if metadata.nil?
    return true if metadata.match?(TODO_ISSUE)

    metadata.scan(TODO_REMOVE_BY).flatten.any? { valid_iso_date?(_1) }
  end

  def valid_iso_date?(value)
    Date.iso8601(value) >= Date.today
  rescue Date::Error
    false
  end

  def ruby_sources
    root = File.expand_path(".")
    root_prefix = "#{root}/"
    rubocop_target_paths.map do |target|
      path = File.expand_path(target).delete_prefix(root_prefix)
      [path, File.read(target)]
    end
  end

  def rubocop_target_paths(root = ".")
    RuboCop::TargetFinder
      .new(RuboCop::ConfigStore.new)
      .find([root], :only_recognized_file_types)
  end

  def validate
    ruby_sources.flat_map { |path, source| violations_for(path, source) }
  end
end
