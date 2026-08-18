# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ContentTypeMatcherTest < Minitest::Test
  def test_json_content
    cases = {
      "application/json" => true,
      "application/json; charset=utf-8" => true,
      "APPLICATION/JSON" => true,
      "application/json " => true,
      "application/jsonl" => false,
      "application/arbitrary+json" => true,
      "application/ARBITRARY+json" => true,
      "application/vnd.github.v3+json" => true,
      "application/vnd.api+json" => true,
      "application/jsonL" => false,
      "application/json-seq" => false,
      "application/jsonlines" => false,
      "application/jsonfoo" => false
    }
    cases.each do |header, verdict|
      assert_pattern do
        OpenAI::Internal::Util::JSON_CONTENT.match?(header) => ^verdict
      end
    end
  end

  def test_jsonl_content
    cases = {
      "application/x-ndjson" => true,
      "application/x-ldjson" => true,
      "application/jsonl" => true,
      "application/x-jsonl" => true,
      "application/jsonl; charset=utf-8" => true,
      "APPLICATION/JSONL" => true,
      "application/jsonL" => true,
      "application/jsonl " => true,
      "application/json" => false,
      "application/vnd.api+json" => false,
      "application/jsonlines" => false,
      "application/jsonl+zip" => false,
      "application/vnd.api+jsonl" => false,
      "application/jsonl, text/plain" => false,
      " application/jsonl" => false,
      "application/jsonl\n" => false,
      "text/plain; name=jsonl" => false,
      "foojsonlbar" => false,
      "application/notjsonlbutjsonl" => false
    }
    cases.each do |header, verdict|
      assert_pattern do
        OpenAI::Internal::Util::JSONL_CONTENT.match?(header) => ^verdict
      end
    end
  end
end

class OpenAI::Test::ContentTypeDispatchTest < Minitest::Test
  def test_mixed_case_jsonl_is_encoded_as_individual_records
    _headers, encoded = OpenAI::Internal::Util.encode_content(
      {"content-type" => "application/jsonL"},
      [{id: 1}, {id: 2}]
    )

    assert_equal(["{\"id\":1}", "{\"id\":2}"], encoded.to_a)
  end

  def test_mixed_case_jsonl_is_decoded_as_individual_records
    decoded = OpenAI::Internal::Util.decode_content(
      {"content-type" => "application/jsonL"},
      stream: ["{\"id\":1}\n{\"id\":2}\n".b]
    )

    assert_equal([{id: 1}, {id: 2}], decoded.to_a)
  end

  def test_unrelated_content_types_remain_raw
    content_types = [
      "text/plain; name=jsonl",
      "foojsonlbar",
      "application/notjsonlbutjsonl"
    ]

    content_types.each do |content_type|
      decoded = OpenAI::Internal::Util.decode_content(
        {"content-type" => content_type},
        stream: ["not json\n".b]
      )

      assert_instance_of(StringIO, decoded)
      assert_equal("not json\n", decoded.read)
    end
  end

  def test_sse_content_type_with_jsonl_parameter_is_decoded_as_sse
    decoded = OpenAI::Internal::Util.decode_content(
      {"content-type" => "text/event-stream; name=jsonl"},
      stream: ["data: {\"id\"".b, ":1}\n\n".b]
    )

    assert_equal(
      [{event: nil, data: "{\"id\":1}\n", id: nil, retry: nil}],
      decoded.to_a
    )
  end

  def test_mixed_case_sse_content_type_is_decoded_as_sse
    decoded = OpenAI::Internal::Util.decode_content(
      {"content-type" => "TEXT/EVENT-STREAM; charset=utf-8"},
      stream: ["data: {\"id\"".b, ":1}\n\n".b]
    )

    assert_equal(
      [{event: nil, data: "{\"id\":1}\n", id: nil, retry: nil}],
      decoded.to_a
    )
  end

  def test_unrelated_sse_prefix_remains_raw
    decoded = OpenAI::Internal::Util.decode_content(
      {"content-type" => "text/event-streaming"},
      stream: ["not an event stream\n".b]
    )

    assert_instance_of(StringIO, decoded)
    assert_equal("not an event stream\n", decoded.read)
  end
end
