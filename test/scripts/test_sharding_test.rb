# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "yaml"

require_relative "../../scripts/test_sharding"

class TestShardingTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_ci_matrix_covers_every_primary_test_file_exactly_once_per_ruby
    workflow = YAML.safe_load_file(File.join(ROOT, ".github/workflows/ci-checks.yml"))
    job = workflow.fetch("jobs").fetch("test-ruby")
    matrix = job.fetch("strategy").fetch("matrix")
    assert_equal(%w[3.3 3.4 4.0], matrix.fetch("ruby-version"))
    assert_equal("${{ matrix.shard }}", job.fetch("env").fetch("TEST_SHARD"))
    assert_equal(false, job.fetch("strategy").fetch("fail-fast"))
    assert_includes(workflow.fetch("jobs").fetch("required").fetch("needs"), "test-ruby")

    files = Dir
      .glob(File.join(ROOT, "test/**/*_test.rb"))
      .reject { _1.match?(%r{/providers/bedrock[^/]*_test\.rb\z}) }
    assert_equal(files.sort, TestSharding.select(files, "1/1"))
    inputs = workflow.fetch(true).fetch("workflow_call").fetch("inputs")
    shards = JSON.parse(inputs.fetch("review-shards").fetch("default"))
    groups = shards.map { TestSharding.select(files, _1) }

    assert_equal(files.sort, groups.flatten.sort)
    assert_equal(files.size, groups.flatten.uniq.size)
    assert(groups.all? { !_1.empty? })
    assert_equal(1, groups.count { |group| group.any? { _1.end_with?("/large_payload_test.rb") } })
    dependent_files = %w[agent_session_stream_test.rb agent_turn_result_test.rb agent_typed_result_test.rb]
    assert(groups.any? { |group| (dependent_files - group.map { File.basename(_1) }).empty? })
  end

  def test_selection_is_independent_of_discovery_order_and_unset_means_all
    files = %w[c.rb a.rb b.rb d.rb]

    assert_equal(TestSharding.select(files, "2/3"), TestSharding.select(files.reverse, "2/3"))
    assert_equal(files, TestSharding.select(files, nil))

    slow = "test/openai/exported_rbi_test.rb"
    sample = [slow, *files]
    assert_equal([slow], TestSharding.select(sample, "1/2"))
    assert_equal(files.sort, TestSharding.select(sample.reverse, "2/2"))
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
