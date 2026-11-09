# frozen_string_literal: true

require "json"
require "minitest"

# Emit one record per completed case to compare the
# executed IDs (including skips) and refresh per-file timing estimates.
class TestShardReport < Minitest::AbstractReporter
  def self.minitest_plugin_init(_options)
    Minitest.reporter << new
  end

  def initialize
    super
    @rows = []
  end

  def record(result)
    file = result.source_location.first.delete_prefix(File.expand_path("../", __dir__) + "/")
    @rows << [result.klass, result.name, result.result_code, file, result.time]
  end

  def report
    @rows.each { |row| puts("SHARD_TEST #{JSON.generate(row)}") }
  end
end

Minitest.register_plugin(TestShardReport)
