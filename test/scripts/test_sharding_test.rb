# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "yaml"

require_relative "../../scripts/test_sharding"

class TestShardingTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_ci_matrix_covers_every_primary_test_file_exactly_once_per_ruby
    workflow = YAML.load_file(File.join(ROOT, ".github/workflows/ci-checks.yml"))
    job = workflow.fetch("jobs").fetch("test-ruby")
    matrix = job.fetch("strategy").fetch("matrix")
    assert_equal(%w[3.3 3.4 4.0], matrix.fetch("ruby-version"))
    assert_equal("${{ matrix.shard }}/3", job.fetch("env").fetch("TEST_SHARD"))
    assert_equal(false, job.fetch("strategy").fetch("fail-fast"))
    assert_includes(workflow.fetch("jobs").fetch("required").fetch("needs"), "test-ruby")

    files = Dir
      .glob(File.join(ROOT, "test/**/*_test.rb"))
      .reject { _1.match?(%r{/providers/bedrock[^/]*_test\.rb\z}) }
    groups = matrix.fetch("shard").map { TestSharding.select(files, "#{_1}/3") }

    assert_equal(files.sort, groups.flatten.sort)
    assert_equal(files.size, groups.flatten.uniq.size)
    assert(groups.all? { !_1.empty? })
    assert_equal(1, groups.count { |group| group.any? { _1.end_with?("/large_payload_test.rb") } })
  end

  def test_selection_is_independent_of_discovery_order_and_unset_means_all
    files = %w[c.rb a.rb b.rb d.rb]

    assert_equal(TestSharding.select(files, "2/3"), TestSharding.select(files.reverse, "2/3"))
    assert_equal(files, TestSharding.select(files, nil))
  end

  def test_invalid_configuration_fails_instead_of_silently_dropping_tests
    ["", "0/3", "1/0", "4/3", "1", "-1/3", "1/3\n"].each do |shard|
      assert_raises(ArgumentError) { TestSharding.select(["test.rb"], shard) }
    end
  end

  def test_rake_rejects_an_empty_shard
    stdout, stderr, status = Open3.capture3(
      {"TEST" => "test/scripts/test_sharding_test.rb", "TEST_SHARD" => "2/3"},
      "bundle",
      "exec",
      "rake",
      "test",
      chdir: ROOT
    )

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes(stderr, "No test files selected")
  end
end
