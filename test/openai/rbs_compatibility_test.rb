# frozen_string_literal: true

require "fileutils"
require "open3"
require "tmpdir"
require "yaml"

require_relative "test_helper"

class OpenAI::Test::RBSCompatibilityTest < Minitest::Test
  extend Minitest::Serial

  ROOT = File.expand_path("../..", __dir__)
  FIXTURES = File.join(ROOT, "test/fixtures/rbs_compatibility")

  def test_shipped_signatures_accept_valid_consumers_and_reject_invalid_consumers
    fixtures = Dir.glob(File.join(FIXTURES, "*.rb.txt"))
    expectations = YAML.safe_load_file(File.join(FIXTURES, "expectations.yml"))
    assert_equal(
      fixtures.select { |path| path.end_with?("_invalid.rb.txt") }.map { |path| File.basename(path, ".txt") },
      expectations.map { |entry| entry.fetch("file") }.sort
    )

    Dir.mktmpdir("rbs-compatibility") do |directory|
      # All consumers use the same unchanged shipped signature tree. Each source
      # remains a separate file, so local variables cannot leak between cases.
      FileUtils.cp_r(File.join(ROOT, "sig"), directory)
      fixtures.each { |path| FileUtils.cp(path, File.join(directory, File.basename(path, ".txt"))) }
      FileUtils.cp(File.join(FIXTURES, "expectations.yml"), directory)
      File.write(
        File.join(directory, "Steepfile"),
        <<~RUBY
          target :consumers do
            signature "sig"
            library "net-http"
            check "*.rb"
          end
        RUBY
      )
      stdout, stderr, status = Open3.capture3(
        "steep",
        "check",
        "--no-daemon",
        "--jobs=1",
        "--validate=skip",
        "--with-expectations=expectations.yml",
        chdir: directory
      )

      # Steep fails for both unexpected errors and missing expected errors.
      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end
end
