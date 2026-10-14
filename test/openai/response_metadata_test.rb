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
    assert_nil(response.body)
  end

  def test_optional_response_body_is_immutable_and_redacted_from_inspection
    source = +"sensitive response body"
    response = OpenAI::ResponseMetadata.new(status: 200, headers: {}, body: source)

    source.replace("changed")

    assert_equal("sensitive response body", response.body)
    assert_predicate(response.body, :frozen?)
    assert_raises(FrozenError) { response.body.replace("changed") }
    refute_includes(response.inspect, "sensitive response body")
  end

  def test_frozen_response_body_is_retained_without_copying
    body = "large response body".b.freeze
    response = OpenAI::ResponseMetadata.new(status: 200, headers: {}, body: body)

    assert_same(body, response.body)
  end

  def test_serialization_omits_retained_response_bodies
    response = OpenAI::ResponseMetadata.new(
      status: 200,
      headers: {"x-request-id" => "req_serialized"},
      body: "sensitive response body"
    )

    [YAML.dump(response), Marshal.dump(response)].each do |serialized|
      refute_includes(serialized, "sensitive response body")
    end

    [YAML.unsafe_load(YAML.dump(response)), Marshal.load(Marshal.dump(response))].each do |copy|
      assert_equal(200, copy.status)
      assert_equal("req_serialized", copy.request_id)
      assert_nil(copy.body)
      assert_predicate(copy, :frozen?)
    end
  end
end
