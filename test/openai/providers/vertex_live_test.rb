# frozen_string_literal: true

require_relative "../test_helper"
require "open3"
require "time"

# Explicit opt-in on an entitled machine. Do not print URLs, project IDs,
# credentials, raw errors or response bodies in this acceptance test.
class OpenAI::Test::VertexLiveTest < Minitest::Test
  extend Minitest::Serial

  def setup
    super
    skip("opt-in live acceptance") unless ENV["OPENAI_VERTEX_LIVE"] == "1"
    @project, @location, @model = ENV.values_at("GOOGLE_CLOUD_PROJECT", "GOOGLE_CLOUD_LOCATION", "OPENAI_VERTEX_MODEL")
    assert(@project && @location && @model, "configure Google project/location and OPENAI_VERTEX_MODEL")
    assert_match(/\A[a-zA-Z0-9._:\/-]+\z/, @model, "model must be safe for acceptance output")
    sha, success = Open3.capture2("git", "rev-parse", "HEAD", chdir: File.expand_path("../../..", __dir__))
    assert(success.success? && /\A[a-f0-9]{40,64}\s*\z/.match?(sha), "unable to record source revision")
    environment = ENV.fetch("OPENAI_VERTEX_ENVIRONMENT", "unspecified")
    assert(/\A[a-zA-Z0-9_-]{1,64}\z/.match?(environment), "environment must be a short non-sensitive alias")
    @client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(
        project: @project,
        location: @location,
        base_url: ENV["OPENAI_VERTEX_BASE_URL"]
      ),
      timeout: 30,
      max_retries: 0
    )
    puts(
      "utc=#{Time.now.utc.iso8601} source_sha=#{sha.strip} sdk=#{OpenAI::VERSION} model=#{@model} environment=#{environment}"
    )
  rescue OpenAI::Errors::Error, LoadError => e
    live_failure("ADC setup", e)
  end

  def test_create_stream_and_function_tools
    params = {model: @model, input: "Reply with the word ready.", store: false}
    first = @client.responses.create(**params)
    assert(first.id && first.status == :completed && !first.output.empty?, "create did not return completed output")
    stream = @client.responses.stream(**params)
    begin
      completed = false
      stream.each { completed = true if _1.type == :"response.completed" }
      assert(completed, "stream did not complete")
    ensure
      stream.close
    end

    result = @client.responses.create(
      **params,
      tools: [
        {
          type: :function,
          name: "lookup",
          parameters: {type: :object, properties: {}, required: [], additionalProperties: false}
        }
      ],
      tool_choice: {type: :function, name: "lookup"}
    )
    assert(result.status == :completed, "function request did not complete")
    calls = result.output.select { |item| item.type.to_s == "function_call" }
    assert(
      !calls.empty? && calls.all? { |call| call.name == "lookup" && call.call_id },
      "expected a lookup function call"
    )
    # Preserve reasoning and all other output context for this stateless turn.
    # Execute only the known synthetic probe, never evaluate model output.
    input = result.output.map(&:to_h)
    input.concat(calls.map { |call| {type: :function_call_output, call_id: call.call_id, output: "probe-ok"} })
    followup = @client.responses.create(model: @model, input: input, store: false)
    assert(followup.status == :completed && !followup.output.empty?, "function output roundtrip did not complete")
  rescue OpenAI::Errors::Error => e
    live_failure("create/stream/tools", e)
  end

  def test_stateful
    unless ENV["OPENAI_VERTEX_LIVE_STATEFUL"] == "1"
      skip("set OPENAI_VERTEX_LIVE_STATEFUL=1 for a deployment with storage")
    end

    result = @client.responses.create(model: @model, input: "Reply ready.", store: true)
    response_id = result.id
    has_response_id = response_id.is_a?(String) && !response_id.empty?
    begin
      assert(has_response_id && result.status == :completed, "stored create did not complete")
      retrieved = @client.responses.retrieve(response_id)
      assert(
        retrieved.id == response_id && retrieved.status == :completed,
        "retrieve did not return the stored response"
      )
      next_turn = @client
        .responses
        .create(model: @model, input: "Continue.", previous_response_id: response_id, store: false)
      assert(next_turn.status == :completed, "previous_response_id did not complete")
    ensure
      @client.responses.delete(response_id) if has_response_id
    end

  rescue OpenAI::Errors::Error => e
    live_failure("storage or cleanup", e)
  end

  def test_compact
    unless ENV["OPENAI_VERTEX_LIVE_COMPACT"] == "1"
      skip("set OPENAI_VERTEX_LIVE_COMPACT=1 for a deployment with compaction")
    end

    result = @client.responses.compact(model: @model, input: "Reply ready.")
    assert(
      result.id && result.object == :"response.compaction" && !result.output.empty?,
      "compact did not return compaction output"
    )
  rescue OpenAI::Errors::Error => e
    live_failure("compact", e)
  end

  private

  # Error text and request/response bodies may contain sensitive values.
  def live_failure(operation, error)
    status = error.is_a?(OpenAI::Errors::APIStatusError) ? " status=#{error.status}" : ""
    flunk("#{operation} failed class=#{error.class.name}#{status}")
  end
end
