# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::BaseQueryIsolationTest < Minitest::Test
  class Capture < OpenAI::HTTPClient
    attr_reader :urls

    def initialize
      super
      @urls = []
    end

    def execute(request)
      @urls << request.url.to_s
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: ["{}"]
      )
    end
  end

  def test_base_query_values_do_not_accumulate_between_public_requests
    transport = Capture.new
    client = OpenAI::Client.new(
      api_key: "fake-key",
      base_url: "https://sdk.example.test/v1?label=base",
      http_client: transport
    )
    one = ["one"]
    two = ["two"]

    client.request(method: :get, path: "/v1", query: {"label" => one})
    client.request(method: :get, path: "/v1", query: {"label" => two})
    client.request(method: :get, path: "/v1")

    assert_equal(
      [
        "https://sdk.example.test/v1?label=base&label=one",
        "https://sdk.example.test/v1?label=base&label=two",
        "https://sdk.example.test/v1?label=base"
      ],
      transport.urls
    )
    assert_equal(["one"], one)
    assert_equal(["two"], two)
  end

  def test_concatenating_deep_merge_does_not_mutate_input_arrays
    left = ["base"]
    right = ["request"]

    merged = OpenAI::Internal::Util.deep_merge(
      {label: left},
      {label: right},
      concat: true
    )

    assert_equal({label: ["base", "request"]}, merged)
    assert_equal(["base"], left)
    assert_equal(["request"], right)
  end
end
