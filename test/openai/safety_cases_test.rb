# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::SafetyCasesTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  CASE_ID = "case/with ?#%"
  CASE_URL = "http://localhost/safety/cases/case%2Fwith%20%3F%23%25"
  HEADERS = {"Authorization" => "Bearer fake-project-key", "X-Case-Trace" => "caller-owned"}.freeze

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def setup
    super
    @openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "fake-project-key",
      admin_api_key: "fake-admin-key",
      max_retries: 0
    )
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_warning_case_with_nullable_reason_and_caller_options
    payload = safety_case("warning", nil)
    stub_case(payload)

    response = @openai.safety.cases.retrieve(
      CASE_ID,
      request_options: {extra_headers: {"X-Case-Trace" => "caller-owned"}, extra_query: {trace: "contract"}}
    )

    assert_instance_of(OpenAI::Safety::SafetyCase, response)
    assert_nil(response.reason)
    assert_equal(:warning, response.notice.type)
    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
    assert_requested(:get, CASE_URL, query: {trace: "contract"}, times: 1)
  end

  def test_deactivation_case_in_async_context
    payload = safety_case("deactivation", "synthetic reason")
    stub_case(payload)

    response = Async do
      @openai.safety.cases.retrieve(
        CASE_ID,
        request_options: {extra_headers: {"X-Case-Trace" => "caller-owned"}, extra_query: {trace: "contract"}}
      )
    end
      .wait

    assert_equal(:deactivation, response.notice.type)
    assert_equal("synthetic reason", response.reason)
    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
    assert_requested(:get, CASE_URL, query: {trace: "contract"}, times: 1)
  end

  def test_future_notice_is_preserved
    payload = safety_case("future-notice", nil)
    stub_request(:get, CASE_URL)
      .with(headers: {"Authorization" => "Bearer fake-project-key"})
      .to_return_json(body: payload)

    response = @openai.safety.cases.retrieve(CASE_ID)

    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
    assert_requested(:get, CASE_URL, times: 1)
  end

  def test_admin_key_is_not_an_ordinary_key_fallback
    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: nil,
      admin_api_key: "fake-admin-key",
      max_retries: 0
    )

    error = assert_raises(ArgumentError) { client.safety.cases.retrieve(CASE_ID) }

    assert_match(/Could not resolve authentication method/, error.message)
    assert_not_requested(:any, /./)
  end

  private def stub_case(payload)
    stub_request(:get, CASE_URL)
      .with(headers: HEADERS, query: {trace: "contract"}) { |request| request.body.to_s.empty? }
      .to_return_json(body: payload)
  end

  private def safety_case(notice_type, reason)
    {
      id: CASE_ID,
      object: "safety.case",
      created_at: 123,
      entity_identifier: "synthetic-entity",
      reason: reason,
      notice: {type: notice_type, future_notice_field: true},
      future_case_field: true
    }
  end
end
