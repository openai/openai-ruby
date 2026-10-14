# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::RawStringIORequestTest < Minitest::Test
  extend Minitest::Serial

  include WebMock::API

  REQUEST_URL = "https://example.test/probe"

  def before_all
    super
    WebMock.enable!
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_request_sends_bytes_remaining_at_current_cursor_without_consuming
    [
      [0, "abcdef"],
      [3, "def"],
      [6, ""],
      [10, ""]
    ].each do |position, expected|
      raw_forms.each do |wrap|
        source = StringIO.new("abcdef")
        source.pos = position

        assert_equal([expected], request_bodies(wrap.call(source)), "byte position #{position}")
        assert_equal(position, source.pos)
        assert_equal("abcdef", source.string)
        assert_equal(Encoding::UTF_8, source.string.encoding)
        refute_predicate(source, :closed?)
      end
    end
  end

  def test_request_slices_at_multibyte_byte_cursor_without_consuming
    raw_forms.each do |wrap|
      source = StringIO.new("éx")
      source.pos = "é".bytesize

      assert_equal(["x"], request_bodies(wrap.call(source)))
      assert_equal("é".bytesize, source.pos)
      assert_equal(Encoding::UTF_8, source.string.encoding)
      refute_predicate(source, :closed?)
    end
  end

  def test_retry_replays_identical_remaining_bytes_for_each_raw_form
    raw_forms.each do |wrap|
      source = StringIO.new("abcdef")
      source.pos = 3

      assert_equal(%w[def def], request_bodies(wrap.call(source), retry_once: true))
      assert_equal(3, source.pos)
      assert_equal("abcdef", source.string)
      assert_equal(Encoding::UTF_8, source.string.encoding)
      refute_predicate(source, :closed?)
    end
  end

  private def raw_forms
    [-> (source) { source }, -> (source) { OpenAI::FilePart.new(source) }]
  end

  private def request_bodies(body, retry_once: false)
    bodies = []
    stub_request(:post, REQUEST_URL).to_return do |request|
      bodies << request.body
      status = retry_once && bodies.one? ? 500 : 200
      {status: status, headers: {"content-type" => "application/json"}, body: "{}"}
    end

    client = OpenAI::Client.new(
      base_url: "https://example.test",
      api_key: "fake-test-key",
      max_retries: retry_once ? 1 : 0,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    client.request(
      method: :post,
      path: "probe",
      headers: {"content-type" => "application/octet-stream"},
      body: body
    )
    bodies
  end
end
