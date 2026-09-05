# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ExtraBodyMergeTest < Minitest::Test
  class Capture < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(statuses: [200])
      super()
      @statuses = statuses
      @requests = []
    end

    def execute(request)
      @requests << request
      OpenAI::HTTPClient::Response.new(
        status: @statuses.fetch(@requests.length - 1, 200),
        headers: {"content-type" => "application/json"},
        body: [JSON.generate(response_body)]
      )
    end

    private def response_body
      {
        id: "resp_test",
        object: "response",
        output: [],
        status: "completed"
      }
    end
  end

  class EnumerableLeaf
    include Enumerable

    attr_reader :each_count

    def initialize
      @each_count = 0
    end

    def each
      @each_count += 1
      yield("unused")
    end

    def to_json(*) = "\"leaf\""
  end

  def test_json_derived_override_deep_merges_with_generated_symbol_keys
    body = create_response_body(
      extra_body: JSON.parse("{\"text\":{\"format\":{\"strict\":true}}}")
    )

    assert_equal(
      {
        "type" => "json_schema",
        "name" => "Answer",
        "schema" => schema,
        "strict" => true
      },
      body.fetch("text").fetch("format")
    )
  end

  def test_request_options_merges_top_level_and_nested_collisions_in_both_key_directions
    options = OpenAI::RequestOptions.new(
      extra_body: {
        "metadata" => {"source" => "override", "added" => "yes"},
        "text" => {"format" => {"strict" => true}}
      }
    )
    generated = create_response_body(
      metadata: {source: "generated", retained: "yes"},
      request_options: options
    )

    assert_equal({"source" => "override", "retained" => "yes", "added" => "yes"}, generated.fetch("metadata"))
    assert_equal("Answer", generated.fetch("text").fetch("format").fetch("name"))

    direct = direct_request_body(
      body: {"outer" => {"left" => "kept"}},
      extra_body: {outer: {right: "added"}}
    )

    assert_equal({"left" => "kept", "right" => "added"}, direct.fetch("outer"))
  end

  def test_override_preserves_scalar_array_and_case_sensitive_semantics_without_mutation
    base = {
      "Config" => {"kept" => true}.freeze,
      "config" => {"items" => [1, 2].freeze, "value" => "base"}.freeze
    }.freeze
    override_items = [3].freeze
    override = {config: {items: override_items, value: "override"}.freeze}.freeze

    body = direct_request_body(body: base, extra_body: override)

    assert_equal({"kept" => true}, body.fetch("Config"))
    assert_equal([3], body.fetch("config").fetch("items"))
    assert_equal("override", body.fetch("config").fetch("value"))
    assert_equal({"Config" => {"kept" => true}, "config" => {"items" => [1, 2], "value" => "base"}}, base)
    assert_equal({config: {items: [3], value: "override"}}, override)
  end

  def test_merge_does_not_consume_enumerable_leaves_or_make_them_replayable
    leaf = EnumerableLeaf.new
    transport = Capture.new(statuses: [500, 200])
    client = new_client(transport)

    assert_raises(OpenAI::Errors::APIStatusError) do
      client.request(
        method: :post,
        path: "synthetic",
        body: {"payload" => {"base" => true}},
        options: {extra_body: {payload: {leaf: leaf}}}
      )
    end

    assert_equal(0, leaf.each_count)
    assert_equal(1, transport.requests.length)
  end

  def test_merge_does_not_read_missing_keys_from_hash_default_procs
    reads = []
    body = Hash.new { |_hash, key| reads << key }
    body["kept"] = true

    merged = direct_request_body(body: body, extra_body: {added: true})

    assert_equal({"kept" => true, "added" => true}, merged)
    assert_empty(reads)
  end

  private def create_response_body(extra_body: nil, metadata: nil, request_options: nil)
    transport = Capture.new
    client = new_client(transport)
    options = request_options || {extra_body: extra_body}
    params = {
      model: "gpt-4o-mini",
      input: "Give a synthetic answer",
      text: {
        format: {
          type: :json_schema,
          name: "Answer",
          schema: schema
        }
      },
      request_options: options
    }
    params[:metadata] = metadata if metadata
    client.responses.create(**params)
    JSON.parse(transport.requests.fetch(0).body)
  end

  def direct_request_body(body:, extra_body:)
    transport = Capture.new
    client = new_client(transport)
    client.request(
      method: :post,
      path: "synthetic",
      body: body,
      options: {extra_body: extra_body}
    )
    JSON.parse(transport.requests.fetch(0).body)
  end

  def new_client(transport)
    OpenAI::Client.new(
      api_key: "fake-key",
      base_url: "https://sdk.example.test/v1",
      http_client: transport,
      max_retries: 2
    )
  end

  def schema
    {
      "type" => "object",
      "properties" => {"answer" => {"type" => "string"}},
      "required" => ["answer"],
      "additionalProperties" => false
    }
  end
end
