#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "pathname"

root = Pathname(ENV.fetch("EXAMPLES_E2E_ROOT", Pathname(__dir__).parent.to_s)).expand_path
report_dir = Pathname(ENV.fetch("EXAMPLES_E2E_REPORT_DIR", root.join("tmp/examples-e2e").to_s)).expand_path
coverage_dir = report_dir.join("coverage")
resultset = report_dir.join("resultsets/.resultset.json")

abort("Example E2E coverage result not found: #{resultset}") unless resultset.file?

Dir.chdir(root)
ENV["EXAMPLES_E2E_COVERAGE_DIR"] = coverage_dir.to_s

require "simplecov"

status = 0
begin
  SimpleCov.collate([resultset.to_s])
rescue SystemExit => e
  status = e.status
end

coverage_json = coverage_dir.join("coverage.json")
if coverage_json.file?
  coverage = JSON.parse(coverage_json.read)
  lines = coverage.fetch("total").fetch("lines")
  percentage = lines.fetch("percent").floor(2)
  summary = format(
    "Ruby example E2E line coverage: %<percentage>.2f%% (%<covered>d/%<total>d lines)",
    percentage: percentage,
    covered: lines.fetch("covered"),
    total: lines.fetch("total")
  )
  puts(summary)

  step_summary = ENV["GITHUB_STEP_SUMMARY"]
  File.open(step_summary, "a") { _1.puts("\n## Code coverage\n\n#{summary}\n") } if step_summary && !step_summary.empty?
end

exit(status)
