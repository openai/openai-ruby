# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputFieldMetadataTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class SyntheticAddress < OpenAI::BaseModel
    required :city, String
  end

  class SyntheticOrder < OpenAI::BaseModel
    required :billing, SyntheticAddress, doc: "Billing address only"
    required :shipping, SyntheticAddress
    required :pickup, SyntheticAddress
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

  def test_reused_nested_model_keeps_field_metadata_independent
    expected = {
      :$defs => {
        ".billing" => {
          type: "object",
          properties: {city: {type: "string"}},
          required: ["city"],
          additionalProperties: false
        }
      },
      :type => "object",
      :properties => {
        billing: {
          description: "Billing address only",
          type: "object",
          properties: {city: {type: "string"}},
          required: ["city"],
          additionalProperties: false
        },
        shipping: {:$ref => "#/$defs/.billing"},
        pickup: {:$ref => "#/$defs/.billing"}
      },
      :required => %w[billing shipping pickup],
      :additionalProperties => false
    }

    assert_equal(expected, SyntheticOrder.to_json_schema)
    assert_equal(expected, SyntheticOrder.to_json_schema)
  end

  def test_public_chat_completion_request_serializes_independent_field_metadata
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 200,
      body: {
        id: "chatcmpl_field_metadata",
        choices: [
          {
            finish_reason: "stop",
            index: 0,
            message: {
              content: "{\"billing\":{\"city\":\"Paris\"},\"shipping\":{\"city\":\"Rome\"},\"pickup\":{\"city\":\"Lima\"}}",
              role: "assistant"
            }
          }
        ],
        created: 1_700_000_000,
        model: "gpt-4o-mini",
        object: "chat.completion"
      }
    )

    @client.chat.completions.create(
      messages: [{content: "Return addresses", role: :user}],
      model: "gpt-4o-mini",
      response_format: SyntheticOrder
    )

    assert_requested(:post, "http://localhost/chat/completions") do |request|
      properties = JSON.parse(request.body).dig(
        "response_format",
        "json_schema",
        "schema",
        "properties"
      )

      assert_equal("Billing address only", properties.dig("billing", "description"))
      assert_equal({"$ref" => "#/$defs/.billing"}, properties.fetch("shipping"))
      assert_equal({"$ref" => "#/$defs/.billing"}, properties.fetch("pickup"))
    end
  end
end
