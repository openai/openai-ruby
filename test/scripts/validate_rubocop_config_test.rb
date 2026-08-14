# frozen_string_literal: true

require "minitest/autorun"
require "fileutils"
require "tmpdir"

require_relative "../../scripts/rubocop_config_guard"

class ValidateRuboCopConfigTest < Minitest::Test
  def test_rejects_disabled_lint_cops
    errors = violations(<<~YAML)
      Lint/EmptyBlock:
        Enabled: false
    YAML

    assert_includes(errors.first, "Lint/EmptyBlock must not set `Enabled: false`")
  end

  def test_rejects_lint_cop_exclusions
    errors = violations(<<~YAML)
      Lint/EmptyBlock:
        Exclude:
          - test/generated/**/*
    YAML

    assert_includes(errors.first, "Lint/EmptyBlock must not define `Exclude` paths")
  end

  def test_rejects_department_wide_lint_exceptions
    errors = violations(<<~YAML)
      Lint:
        Enabled: false
        Exclude: lib/generated/**/*
    YAML

    assert(errors.any? { _1.include?("Lint must not set `Enabled: false`") })
    assert(errors.any? { _1.include?("Lint must not define `Exclude` paths") })
  end

  def test_allows_non_suppression_lint_settings
    assert_empty(
      violations(<<~YAML)
        Lint/UnusedMethodArgument:
          AutoCorrect: false
          Exclude: []
      YAML
    )
  end

  def test_ignores_other_departments
    assert_empty(
      violations(<<~YAML)
        Layout/EmptyLineAfterGuardClause:
          Enabled: false
      YAML
    )
  end

  def test_discovers_nested_rubocop_configs
    Dir.mktmpdir do |directory|
      path = File.join(directory, "nested", ".rubocop_todo.yml")
      FileUtils.mkdir_p(File.dirname(path))
      File.write(path, "Lint/EmptyBlock:\n  Enabled: false\n")

      assert_equal(["nested/.rubocop_todo.yml"], RuboCopConfigGuard.config_paths(directory))
      assert_includes(RuboCopConfigGuard.validate(directory).first, "Lint/EmptyBlock")
    end
  end

  def test_ignores_bundled_dependency_configs
    Dir.mktmpdir do |directory|
      repository_path = File.join(directory, ".rubocop.yml")
      dependency_path = File.join(directory, "vendor", "bundle", "gem", ".rubocop.yml")
      FileUtils.mkdir_p(File.dirname(dependency_path))
      File.write(repository_path, "AllCops:\n  NewCops: enable\n")
      File.write(dependency_path, "plugins:\n  - unavailable-plugin\n")

      assert_equal([".rubocop.yml"], RuboCopConfigGuard.config_paths(directory))
      assert_empty(RuboCopConfigGuard.validate(directory))
    end
  end

  def test_follows_local_inherit_from_paths_with_arbitrary_names
    Dir.mktmpdir do |directory|
      inherited_path = File.join(directory, "config", "lint_policy.yml")
      FileUtils.mkdir_p(File.dirname(inherited_path))
      File.write(File.join(directory, ".rubocop.yml"), "inherit_from: config/lint_policy.yml\n")
      File.write(inherited_path, "Lint/EmptyBlock:\n  Exclude:\n    - test/generated/**/*\n")

      assert_equal([".rubocop.yml"], RuboCopConfigGuard.config_paths(directory))
      assert_includes(RuboCopConfigGuard.validate(directory).first, "Lint/EmptyBlock")
    end
  end

  def test_current_repository_config_has_no_lint_suppressions
    assert_empty(RuboCopConfigGuard.validate)
  end

  private

  def violations(source)
    RuboCopConfigGuard.violations_for(".rubocop.yml", source)
  end
end
