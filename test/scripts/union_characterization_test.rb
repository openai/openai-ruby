# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "pathname"
require "rbconfig"
require "tmpdir"

class UnionCharacterizationScriptsTest < Minitest::Test
  ROOT = Pathname(__dir__).join("../..").expand_path
  CHARACTERIZATION_SCRIPT = ROOT.join("scripts/union-characterization").to_s
  DIFFERENTIAL_SCRIPT = ROOT.join("scripts/union-characterization-differential").to_s

  def test_characterization_loads_the_checkout_before_other_load_paths
    Dir.mktmpdir("openai-union-characterization-test") do |directory|
      Pathname(directory).join("openai.rb").write("raise \"loaded non-checkout openai\"\n")

      stdout, stderr, status = Open3.capture3(
        RbConfig.ruby,
        "-I#{directory}",
        CHARACTERIZATION_SCRIPT
      )

      assert_predicate(status, :success?, stderr)
      assert_includes(JSON.parse(stdout), "responses_typed_message_without_type_symbols")
    end
  end

  def test_characterization_accepts_an_explicit_relative_lib_directory
    stdout, stderr, status = Open3.capture3(
      RbConfig.ruby,
      CHARACTERIZATION_SCRIPT,
      "lib",
      chdir: ROOT
    )

    assert_predicate(status, :success?, stderr)
    assert_includes(JSON.parse(stdout), "responses_typed_message_without_type_symbols")
  end

  def test_differential_reports_all_missing_release_refs_before_archiving
    Dir.mktmpdir("openai-union-characterization-git-test") do |directory|
      initialize_repository(directory)

      git_dir = Pathname(directory).join(".git").to_s
      stdout, stderr, status = Open3.capture3({"GIT_DIR" => git_dir}, DIFFERENTIAL_SCRIPT)

      refute_predicate(status, :success?)
      assert_empty(stdout)
      assert_includes(stderr, "Missing required release tags: v0.78.0 v0.80.0")
      assert_includes(stderr, "git fetch --tags")
      refute_includes(stderr, "not a valid object name")
    end
  end

  def test_differential_does_not_accept_branches_named_like_release_tags
    Dir.mktmpdir("openai-union-characterization-branch-test") do |directory|
      initialize_repository(directory)
      run_git(directory, "commit", "--allow-empty", "--message", "initial")
      run_git(directory, "branch", "v0.78.0")
      run_git(directory, "branch", "v0.80.0")

      git_dir = Pathname(directory).join(".git").to_s
      _stdout, stderr, status = Open3.capture3({"GIT_DIR" => git_dir}, DIFFERENTIAL_SCRIPT)

      refute_predicate(status, :success?)
      assert_includes(stderr, "Missing required release tags: v0.78.0 v0.80.0")
    end
  end

  private

  def initialize_repository(directory)
    _stdout, stderr, status = Open3.capture3("git", "init", "--quiet", directory)
    assert_predicate(status, :success?, stderr)
  end

  def run_git(directory, *arguments)
    _stdout, stderr, status = Open3.capture3(
      "git",
      "-C",
      directory,
      "-c",
      "user.name=Union Characterization Test",
      "-c",
      "user.email=union-characterization@example.test",
      *arguments
    )
    assert_predicate(status, :success?, stderr)
  end
end
