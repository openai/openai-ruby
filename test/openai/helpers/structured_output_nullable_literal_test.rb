# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputNullableLiteralTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class NullableStatus < OpenAI::BaseModel
    required :status, const: :ready, nil?: true
  end

  class Status < OpenAI::BaseModel
    required :status, const: :ready
  end

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
    @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_nullable_symbol_literal_schema_preserves_literal_or_null
    expected = {
      type: "object",
      properties: {
        status: {anyOf: [{const: "ready"}, {type: "null"}]}
      },
      required: ["status"],
      additionalProperties: false
    }

    schema = NullableStatus.to_json_schema

    assert_equal(expected, schema)
    assert_equal(JSON.parse(JSON.generate(expected)), JSON.parse(JSON.generate(schema)))
    assert_equal({const: "ready"}, Status.to_json_schema.dig(:properties, :status))
  end

  def test_public_chat_completion_request_serializes_nullable_symbol_literal_schema
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 200,
      body: {
        id: "chatcmpl_nullable_literal",
        choices: [
          {
            finish_reason: "stop",
            index: 0,
            message: {content: "{\"status\":null}", role: "assistant"}
          }
        ],
        created: 1_700_000_000,
        model: "gpt-4o-mini",
        object: "chat.completion"
      }
    )

    response = @client.chat.completions.create(
      messages: [{content: "Return the status", role: :user}],
      model: "gpt-4o-mini",
      response_format: NullableStatus
    )

    assert_requested(:post, "http://localhost/chat/completions") do |request|
      schema = JSON.parse(request.body).dig("response_format", "json_schema", "schema")

      assert_equal(
        [{"const" => "ready"}, {"type" => "null"}],
        schema.dig("properties", "status", "anyOf")
      )
    end

    assert_instance_of(NullableStatus, response.choices.first.message.parsed)
    assert_nil(response.choices.first.message.parsed.status)
  end
end
