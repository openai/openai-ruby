# frozen_string_literal: true

require "minitest/autorun"
require "fileutils"
require "open3"
require "tmpdir"

require_relative "../../scripts/rubocop_directive_guard"

class ValidateRuboCopDirectivesTest < Minitest::Test
  def test_allows_narrow_disable_directives
    assert_empty(violations("disable Lint/EmptyBlock"))
  end

  def test_rejects_disable_all
    assert_includes(violations("disable all").first, "disable all is forbidden")
  end

  def test_matches_rubocop_directive_marker_whitespace
    [
      "# rubocop : disable all",
      "# rubocop: disable all"
    ].each do |directive|
      assert_includes(violations_in(directive).first, "disable all is forbidden")
    end

    errors = violations_in("# rubocop : todo Lint/EmptyBlock")
    assert(errors.any? { _1.include?("requires `owner: ...`") })
    assert(errors.any? { _1.include?("requires `issue: #123`") })
  end

  def test_rejects_broad_disable_with_unspaced_trailing_explanation
    errors = violations_in(
      "# rubocop:disable all --https://github.com/openai/openai-ruby/issues/123"
    )

    assert_includes(errors.first, "disable all is forbidden")
  end

  def test_rejects_department_wide_disables
    assert_includes(violations("disable Lint").first, "department-wide")
  end

  def test_allows_broad_enable_directives
    assert_empty(violations("enable all"))
    assert_empty(violations("enable Metrics"))
  end

  def test_ignores_directive_text_inside_strings
    source = "message = \"# rubocop:disable all\"\n"

    assert_empty(RuboCopDirectiveGuard.violations_for("example.rb", source))
  end

  def test_rejects_prefixed_directives_that_rubocop_applies
    errors = violations_in("puts('bad') # rationale # rubocop:disable all")
    assert_includes(errors.first, "disable all is forbidden")

    errors = violations_in(
      "puts('bad') # rationale # rubocop:todo Style/StringLiterals"
    )
    assert(errors.any? { _1.include?("requires `owner: ...`") })
    assert(errors.any? { _1.include?("requires `issue: #123`") })
  end

  def test_rejects_unowned_todos
    errors = violations("todo Lint/EmptyBlock -- temporary exception; issue: #123")

    assert(errors.any? { _1.include?("requires `owner: ...`") })
  end

  def test_rejects_untracked_todos
    errors = violations("todo Lint/EmptyBlock -- temporary exception; owner: @sdk")

    assert(errors.any? { _1.include?("requires `issue: #123`") })
  end

  def test_allows_owned_and_tracked_todos
    Date.stub(:today, Date.new(2026, 8, 13)) do
      assert_empty(
        violations(
          "todo Lint/EmptyBlock -- temporary exception; owner: @sdk; remove-by: 2026-09-01"
        )
      )
    end
  end

  def test_rejects_malformed_tracking_values
    ["issue: #123abc", "remove-by: 2026-09-011"].each do |tracking|
      errors = violations("todo Lint/EmptyBlock -- owner: @sdk; #{tracking}")

      assert(errors.any? { _1.include?("requires `issue: #123`") }, tracking)
    end
  end

  def test_validates_remove_by_calendar_dates
    Date.stub(:today, Date.new(2026, 1, 1)) do
      %w[2026-99-99 2026-02-30].each do |date|
        errors = violations("todo Lint/EmptyBlock -- owner: @sdk; remove-by: #{date}")
        assert(errors.any? { _1.include?("requires `issue: #123`") }, date)
      end

      assert_empty(
        violations("todo Lint/EmptyBlock -- owner: @sdk; remove-by: 2028-02-29")
      )
    end
  end

  def test_rejects_expired_remove_by_dates
    Date.stub(:today, Date.new(2026, 8, 13)) do
      errors = violations("todo Lint/EmptyBlock -- owner: @sdk; remove-by: 2026-08-12")
      assert(errors.any? { _1.include?("requires `issue: #123`") })

      assert_empty(
        violations("todo Lint/EmptyBlock -- owner: @sdk; remove-by: 2026-08-13")
      )
    end
  end

  def test_uses_rubocop_source_discovery
    Dir.mktmpdir do |directory|
      paths = %w[config.ru nested/Rakefile nested/Gemfile nested/example.gemfile]
      paths.each do |path|
        full_path = File.join(directory, path)
        FileUtils.mkdir_p(File.dirname(full_path))
        File.write(full_path, "puts(:ok)\n")
      end

      targets = RuboCopDirectiveGuard.rubocop_target_paths(directory)
      paths.each { assert_includes(targets, File.join(directory, _1)) }
    end
  end

  def test_validates_source_trees_without_git
    Dir.mktmpdir do |directory|
      FileUtils.cp(File.expand_path("../../.rubocop.yml", __dir__), directory)
      %w[lib/generated.rb vendor/bundle/dependency.rb sorbet/rbi/gems/dependency.rbi].each do |path|
        full_path = File.join(directory, path)
        FileUtils.mkdir_p(File.dirname(full_path))
        File.write(full_path, "# rubocop:disable Lint\n")
      end

      _stdout, stderr, status = validate_directory(directory)
      refute(status.success?)
      assert_equal("lib/generated.rb:1: department-wide rubocop:disable Lint is forbidden\n", stderr)
    end
  end

  def test_validates_new_untracked_sources
    Dir.mktmpdir do |directory|
      assert(system("git", "init", "--quiet", directory))
      File.write(File.join(directory, "new.rb"), "# rubocop:disable Lint\n")

      _stdout, stderr, status = validate_directory(directory)
      refute(status.success?)
      assert_equal("new.rb:1: department-wide rubocop:disable Lint is forbidden\n", stderr)
    end
  end

  private

  def validate_directory(directory)
    script = File.expand_path("../../scripts/validate-rubocop-directives", __dir__)
    Open3.capture3(RbConfig.ruby, script, chdir: directory)
  end

  def violations(body)
    directive = "# rubocop:#{body}\n"
    RuboCopDirectiveGuard.violations_for("example.rb", directive)
  end

  def violations_in(directive)
    RuboCopDirectiveGuard.violations_for("example.rb", "#{directive}\n")
  end
end
