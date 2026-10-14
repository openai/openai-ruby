# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::QueryOverrideKeysTest < Minitest::Test
  class CaptureHTTPClient < OpenAI::HTTPClient
    attr_reader :urls

    def initialize(*bodies)
      super()
      @urls = []
      @bodies = bodies
    end

    def execute(request)
      @urls << request.url.to_s
      body = @bodies.empty? ? {object: "list", data: [], has_more: false} : @bodies.shift
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: [JSON.generate(body)]
      )
    end
  end

  def test_json_keyed_extra_query_overrides_generated_query_once
    transport = CaptureHTTPClient.new
    client = client_with(transport)
    json_query = JSON.parse("{\"purpose\":\"batch\"}")
    symbol_query = {purpose: "batch"}

    client.files.list(purpose: :assistants, request_options: {extra_query: json_query})
    client.files.list(purpose: :assistants, request_options: {extra_query: symbol_query})

    assert_equal(
      ["http://localhost/files?purpose=batch", "http://localhost/files?purpose=batch"],
      transport.urls
    )
    assert_equal({"purpose" => "batch"}, json_query)
    assert_equal({purpose: "batch"}, symbol_query)
  end

  def test_bracket_keys_preserve_colliding_base_query_concatenation
    transport = CaptureHTTPClient.new
    client = client_with(transport, base_url: "http://localhost/v1?purpose=base")
    extra_query = {"trace[]" => ["one", "two"]}

    client.request(
      method: :get,
      path: "/v1",
      query: {purpose: "assistants"},
      options: {extra_query: extra_query}
    )

    assert_equal(
      ["http://localhost/v1?purpose=base&purpose=assistants&trace%5B%5D=one&trace%5B%5D=two"],
      transport.urls
    )
    assert_equal({"trace[]" => ["one", "two"]}, extra_query)
  end

  def test_json_keyed_override_stays_deduplicated_on_next_page
    transport = CaptureHTTPClient.new(
      {object: "list", data: [{id: "file-one"}], has_more: true},
      {object: "list", data: [], has_more: false}
    )
    client = client_with(transport)

    page = client.files.list(
      purpose: :assistants,
      request_options: {extra_query: JSON.parse("{\"purpose\":\"batch\"}")}
    )
    page.next_page

    assert_equal(
      [
        "http://localhost/files?purpose=batch",
        "http://localhost/files?purpose=batch&after=file-one"
      ],
      transport.urls
    )
  end

  def test_exact_override_key_wins_before_counterpart_on_every_page
    cases = [
      [
        {:purpose => "symbol", "purpose" => "string"},
        {purpose: "new"},
        [
          "http://localhost/files?purpose=new&purpose=string",
          "http://localhost/files?purpose=new&purpose=string&after=file-one"
        ]
      ],
      [
        {"purpose" => "string", :purpose => "symbol"},
        {"purpose" => "new"},
        [
          "http://localhost/files?purpose=new&purpose=symbol",
          "http://localhost/files?purpose=new&purpose=symbol&after=file-one"
        ]
      ]
    ]

    cases.each do |query, extra_query, expected_urls|
      transport = CaptureHTTPClient.new(
        {object: "list", data: [{id: "file-one"}], has_more: true},
        {object: "list", data: [], has_more: false}
      )
      client = client_with(transport)

      page = client.request(
        method: :get,
        path: "files",
        query: query,
        page: OpenAI::Internal::CursorPage,
        model: OpenAI::FileObject,
        options: {extra_query: extra_query}
      )
      page.next_page

      assert_equal(expected_urls, transport.urls)
    end
  end

  private def client_with(transport, base_url: "http://localhost")
    OpenAI::Client.new(api_key: "fake-key", base_url: base_url, http_client: transport)
  end
end
