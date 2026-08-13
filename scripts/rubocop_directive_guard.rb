# frozen_string_literal: true

require "open3"
require "ripper"

module RuboCopDirectiveGuard
  DIRECTIVE = /#\s*rubocop:(disable|todo)\s+(.+?)(?:\s+--\s+(.+))?\s*$/
  EXCLUDED_PREFIXES = %w[
    sorbet/rbi/annotations/
    sorbet/rbi/gems/
    sorbet/tapioca/
    vendor/
  ].freeze
  ROOT_RUBY_FILES = %w[Gemfile Rakefile Steepfile].freeze
  RUBY_EXTENSIONS = %w[.gemspec .rake .rb .rbi].freeze
  TODO_OWNER = /(?:\A|;)\s*owner:\s*[^;\s]+/
  TODO_REMOVAL = %r{
    (?:\A|;)\s*
    (?:issue:\s*(?:\#\d+|https?://[^;\s]+)|remove-by:\s*\d{4}-\d{2}-\d{2})
    (?=\s*(?:;|\z))
  }x

  module_function

  def ruby_source_path?(path, source = "")
    return false if EXCLUDED_PREFIXES.any? { path.start_with?(_1) }
    return true if ROOT_RUBY_FILES.include?(path)
    return true if RUBY_EXTENSIONS.include?(File.extname(path))

    path.start_with?("scripts/") && source.start_with?("#!/usr/bin/env ruby")
  end

  def violations_for(path, source)
    violations = []
    Ripper.lex(source).each do |(line_number, _column), token, comment, _state|
      next unless token == :on_comment

      match = DIRECTIVE.match(comment)
      next if match.nil?

      action, cop_text, metadata = match.captures
      cops = cop_text.split(",").map(&:strip)
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
      unless metadata&.match?(TODO_REMOVAL)
        violations <<
          "#{path}:#{line_number}: rubocop:todo requires `issue: #123` or `remove-by: YYYY-MM-DD` metadata"
      end
    end
    violations
  end

  def tracked_ruby_sources
    paths, status = Open3.capture2("git", "ls-files", "-z")
    raise "git ls-files failed" unless status.success?

    paths.split("\0").filter_map do |path|
      next unless ROOT_RUBY_FILES.include?(path) ||
                  RUBY_EXTENSIONS.include?(File.extname(path)) ||
                  path.start_with?("scripts/")

      source = File.read(path)
      [path, source] if ruby_source_path?(path, source)
    end
  end

  def validate
    tracked_ruby_sources.flat_map { |path, source| violations_for(path, source) }
  end
end
