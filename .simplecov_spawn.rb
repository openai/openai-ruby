# frozen_string_literal: true

require "simplecov"
require "pathname"

load Pathname(ENV.fetch("EXAMPLES_E2E_ROOT")).join(".simplecov")

SimpleCov.command_name("example:#{ENV.fetch('OPENAI_EXAMPLE_PATH')}")
SimpleCov.merging(true)
SimpleCov.finalize_merge(false)
SimpleCov.formatter(false)
SimpleCov.start
