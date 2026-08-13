# frozen_string_literal: true

require "minitest/autorun"

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

  def test_ignores_directive_text_inside_strings
    source = %(message = "# rubocop:disable all"\n)

    assert_empty(RuboCopDirectiveGuard.violations_for("example.rb", source))
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
    assert_empty(
      violations(
        "todo Lint/EmptyBlock -- temporary exception; owner: @sdk; remove-by: 2026-09-01"
      )
    )
  end

  def test_rejects_malformed_tracking_values
    ["issue: #123abc", "remove-by: 2026-09-011"].each do |tracking|
      errors = violations("todo Lint/EmptyBlock -- owner: @sdk; #{tracking}")

      assert(errors.any? { _1.include?("requires `issue: #123`") }, tracking)
    end
  end

  def test_recognizes_root_and_extensionless_ruby_entry_points
    assert(RuboCopDirectiveGuard.ruby_source_path?("Rakefile", ""))
    assert(RuboCopDirectiveGuard.ruby_source_path?("Steepfile", ""))
    assert(RuboCopDirectiveGuard.ruby_source_path?("openai.gemspec", ""))
    assert(
      RuboCopDirectiveGuard.ruby_source_path?(
        "scripts/check",
        "#!/usr/bin/env ruby\nputs(:ok)\n"
      )
    )
  end

  def test_ignores_dependency_and_generated_tapioca_sources
    refute(RuboCopDirectiveGuard.ruby_source_path?("vendor/example.rb", ""))
    refute(RuboCopDirectiveGuard.ruby_source_path?("sorbet/rbi/gems/example.rbi", ""))
  end

  def test_skips_tracked_sources_missing_from_the_worktree
    status = Minitest::Mock.new
    status.expect(:success?, true)

    Open3.stub(:capture2, ["missing.rb\0", status]) do
      assert_empty(RuboCopDirectiveGuard.tracked_ruby_sources)
    end
    status.verify
  end

  private

  def violations(body)
    directive = "# rubocop:#{body}\n"
    RuboCopDirectiveGuard.violations_for("example.rb", directive)
  end

  def violations_in(directive)
    RuboCopDirectiveGuard.violations_for("example.rb", "#{directive}\n")
  end
end
