# frozen_string_literal: true

require "json"

module TestSharding
  # These test files require one another. Loading any of them on a second
  # worker would also register tests owned by the first worker.
  AGENT_RESULT_TESTS = %w[
    test/openai/helpers/agent_session_stream_test.rb
    test/openai/helpers/agent_turn_result_test.rb
    test/openai/helpers/agent_typed_result_test.rb
  ]
    .freeze

  def self.select(files, shard)
    return files if shard.nil?

    match = /\A([1-9][0-9]*)\/([1-9][0-9]*)\z/.match(shard)
    raise ArgumentError, "TEST_SHARD must be INDEX/COUNT (for example 1/3)" unless match

    index, count = match.captures.map { Integer(_1, 10) }
    raise ArgumentError, "TEST_SHARD index must not exceed its count" if index > count
    return files.sort if count == 1
    return [] if index > files.size

    # Timings are estimates. Give new files a positive weight so both workers
    # get work even if none of the files has been measured.
    seconds = JSON.parse(File.read(File.join(__dir__, "test_shard_seconds.json")))
    root = File.expand_path("../", __dir__) + "/"
    groups = Array.new([count, files.size].min) { [] }
    totals = Array.new(groups.size, 0)
    units = files.sort.group_by do |file|
      path = file.delete_prefix(root)
      AGENT_RESULT_TESTS.include?(path) ? AGENT_RESULT_TESTS.first : path
    end

    weighted = units.values.map { |unit| [unit, unit.sum { |file| seconds.fetch(file.delete_prefix(root), 1) }] }
    weighted.sort_by { |unit, weight| [-weight, unit.first] }.each do |unit, weight|
      target = totals.each_index.min_by { |i| totals[i] }
      groups[target].concat(unit)
      totals[target] += weight
    end

    # Preserve normal load order and Minitest's scheduling within each file.
    groups.fetch(index - 1).sort
  end
end
