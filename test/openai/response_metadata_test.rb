# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ResponseMetadataTest < Minitest::Test
  def test_normalizes_and_immutably_copies_headers
    request_id = +"req_123"
    source = {"X-Request-ID" => request_id, :"X-Custom" => :value}

    response = OpenAI::ResponseMetadata.new(status: "201", headers: source)
    request_id.replace("changed")
    source["X-New"] = "new"

    assert_equal(201, response.status)
    assert_equal(
      {"x-request-id" => "req_123", "x-custom" => "value"},
      response.headers
    )
    assert_equal("req_123", response.request_id)
    assert_predicate(response, :frozen?)
    assert_predicate(response.headers, :frozen?)
    assert(response.headers.all? { |name, value| name.frozen? && value.frozen? })

    assert_raises(FrozenError) { response.headers["x-new"] = "new" }
    assert_raises(FrozenError) { response.headers.fetch("x-request-id").replace("changed") }
  end

  def test_request_id_is_optional
    response = OpenAI::ResponseMetadata.new(status: 204, headers: {})

    assert_nil(response.request_id)
  end
end
