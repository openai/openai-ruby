# frozen_string_literal: true

# Requiring this file from each test file ensures we always do the following, even
# when running a single-file test:
# - Load the whole gem (as one would in production)
# - Define shared testing namespace so that we don't need to indent test files as much
# - Setting up testing dependencies

require "digest"
require "singleton"

require "async"
require "minitest/autorun"
require "minitest/focus"
require "minitest/hooks/test"
require "minitest/proveit"
require "minitest/rg"
require "webmock"

require_relative "../../lib/openai"
require_relative "resource_namespaces"

module Kernel
  alias_method :_sleep, :sleep

  def sleep(secs)
    case Thread.current.thread_variable_get(:mock_sleep)
    in Array => counter
      counter << secs
      secs
    else
      _sleep(secs)
    end
  end
end

class Time
  class << self
    alias_method :_now, :now
  end

  def self.now = Thread.current.thread_variable_get(:time_now) || _now
end

class OpenAI::Test::SingletonClient < OpenAI::Client
  include Singleton

  TEST_API_BASE_URL = ENV.fetch("TEST_API_BASE_URL", "http://localhost:4010")

  def initialize
    super(base_url: OpenAI::Test::SingletonClient::TEST_API_BASE_URL, api_key: "My API Key")
  end
end

class Minitest::Test
  include Minitest::Hooks

  make_my_diffs_pretty!
  parallelize_me!
  prove_it!
end

class OpenAI::Test::ResourceTest < Minitest::Test
  def async?
    return @async unless @async.nil?
    @async = Digest::SHA256.hexdigest(self.class.name).to_i(16).odd?
  end

  def before_all
    super
    @openai = OpenAI::Test::SingletonClient.instance
  end

  def around_all = async? ? Sync { super } : super

  def around = async? ? Async { super }.wait : super
end

module WebMock
  AssertionFailure.error_class = Minitest::Assertion
end
