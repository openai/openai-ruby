# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::RequestOptionsExtraQueryTest < Minitest::Test
  class CaptureHTTPClient < OpenAI::HTTPClient
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
        body: [JSON.generate(object: "list", data: [], has_more: false)]
      )
    end
  end

  def test_constructor_reads_documented_value_forms_without_replacing_raw_input
    extra_query = {"purpose" => "batch", "tags" => ["one", "two"], "cursor" => nil}
    options = OpenAI::RequestOptions.new(extra_query: extra_query)

    assert_same(extra_query, options[:extra_query])
    assert_equal(extra_query, options.extra_query)
  end

  def test_setter_reads_documented_value_forms
    options = OpenAI::RequestOptions.new
    extra_query = {"purpose" => "batch", "tags" => ["one", "two"], "cursor" => nil}

    options.extra_query = extra_query

    assert_same(extra_query, options[:extra_query])
    assert_equal(extra_query, options.extra_query)
  end

  def test_native_request_preserves_scalar_array_and_nil_wire_values
    transport = CaptureHTTPClient.new
    client = OpenAI::Client.new(api_key: "fake-key", base_url: "http://localhost", http_client: transport)
    options = OpenAI::RequestOptions.new(
      extra_query: {"purpose" => "batch", "tags" => ["one", "two"], "cursor" => nil}
    )

    client.files.list(request_options: options)

    assert_equal(
      ["http://localhost/files?purpose=batch&tags=one&tags=two&cursor"],
      transport.urls
    )
  end
end
