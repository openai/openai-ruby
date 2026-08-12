# frozen_string_literal: true

require "pathname"

project_root = Pathname(ENV.fetch("EXAMPLES_E2E_ROOT", __dir__)).expand_path
report_dir = Pathname(ENV.fetch("EXAMPLES_E2E_REPORT_DIR", project_root.join("tmp/examples-e2e").to_s)).expand_path
coverage_dir = Pathname(ENV.fetch("EXAMPLES_E2E_COVERAGE_DIR", report_dir.join("coverage").to_s)).expand_path

SimpleCov.configure do
  root project_root.to_s
  coverage_path coverage_dir.to_s
  cover "lib/**/*.rb"
  merge_timeout 7_200
  formatters [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::JSONFormatter]

  coverage :line do
    # Raise this baseline whenever example E2E coverage increases. Never lower it.
    minimum 89.96
  end
end
