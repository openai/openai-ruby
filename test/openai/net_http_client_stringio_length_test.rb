# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::NetHTTPClientStringIOLengthTest < Minitest::Test
  include WebMock::API

  REQUEST_URL = "https://example.test/probe"

  def setup
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.reset!
    WebMock.disable!
    super
  end

  def test_automatic_content_length_matches_bytes_remaining_at_current_cursor
    observations = [
      [0, "6", "abcdef"],
      [3, "3", "def"],
      [6, "0", ""],
      [10, "0", ""]
    ].map do |position, expected_length, expected_body|
      source = StringIO.new("abcdef")
      source.pos = position

      observation = execute(source)

      assert_equal(expected_length, observation.fetch(:content_length))
      assert_equal(expected_body, observation.fetch(:body))
      refute_predicate(source, :closed?)
      observation
    end

    assert_equal(%w[6 3 0 0], observations.map { _1.fetch(:content_length) })
  end

  def test_automatic_content_length_counts_remaining_multibyte_bytes
    source = StringIO.new("éx")
    source.pos = "é".bytesize

    observation = execute(source)

    assert_equal("1", observation.fetch(:content_length))
    assert_equal("x", observation.fetch(:body))
    refute_predicate(source, :closed?)
  end

  def test_explicit_framing_headers_remain_caller_owned
    content_length_source = StringIO.new("abcdef").tap { _1.pos = 3 }
    transfer_encoding_source = StringIO.new("abcdef").tap { _1.pos = 3 }
    content_length = execute(content_length_source, headers: {"Content-Length" => "6"})
    transfer_encoding = execute(
      transfer_encoding_source,
      headers: {"Transfer-Encoding" => "chunked"}
    )

    assert_equal("6", content_length.fetch(:content_length))
    assert_nil(content_length.fetch(:transfer_encoding))
    assert_equal("def", content_length.fetch(:body))
    assert_nil(transfer_encoding.fetch(:content_length))
    assert_equal("chunked", transfer_encoding.fetch(:transfer_encoding))
    assert_equal("def", transfer_encoding.fetch(:body))
    refute_predicate(content_length_source, :closed?)
    refute_predicate(transfer_encoding_source, :closed?)
  end

  private def execute(source, headers: {})
    observed = nil
    stub_request(:post, REQUEST_URL).to_return do |request|
      observed = {
        content_length: request.headers["Content-Length"],
        transfer_encoding: request.headers["Transfer-Encoding"],
        body: request.body
      }
      {status: 200, body: "ok"}
    end

    client = OpenAI::NetHTTPClient.new
    request = OpenAI::HTTPClient::Request.new(
      method: :post,
      url: URI(REQUEST_URL),
      headers: headers,
      body: source,
      timeout: 1
    )

    response = client.execute(request)
    assert_equal("ok", response.body.to_a.join)
    observed
  ensure
    client&.close
  end
end
