# frozen_string_literal: true

require "minitest/autorun"
require "json"

require_relative "../../lib/openai/version"

class ReleaseWorkflowTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)
  BEDROCK_LOCKFILE = "gemfiles/bedrock.gemfile.lock"

  def test_release_please_updates_bedrock_lockfile
    config = JSON.parse(File.read(File.join(ROOT, "release-please-config.json")))
    package = config.merge(config.fetch("packages").fetch("."))

    assert_includes(package.fetch("extra-files"), BEDROCK_LOCKFILE)
  end

  def test_bedrock_release_markers_update_only_the_sdk_version
    lockfile = File.read(File.join(ROOT, BEDROCK_LOCKFILE))
    markers = %w[x-release-please-start-version x-release-please-end]
    sdk_entry = "    openai (#{OpenAI::VERSION})"

    assert_equal(markers, lockfile.scan(/x-release-please-[\w-]+/))
    assert_includes(
      lockfile,
      "  # #{markers.first}\n#{sdk_entry}\n  # #{markers.last}\n",
      "Restore the release-please markers around only the openai version after regenerating the lockfile"
    )

    # Simulate the generic updater's stable-version replacement inside marked blocks.
    next_version = "#{OpenAI::VERSION.split(".").first.to_i + 1}.0.0"
    updated = lockfile.gsub(/x-release-please-start-version\n.*?x-release-please-end/m) do |block|
      block.gsub(/\d+\.\d+\.\d+/, next_version)
    end

    assert_equal(lockfile.sub(sdk_entry, "    openai (#{next_version})"), updated)
  end
end
