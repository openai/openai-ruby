# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputConstantTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class ConstantFormat < OpenAI::BaseModel
    required :version, Integer, const: 7, doc: "Schema version"
    required :score, const: 1.5
    required :published, const: true
    required :archived, const: false
    required :status, const: :ready
    required :missing, const: nil
    required :label, String
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
    @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "fake-key")
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_schema_preserves_non_nullable_numeric_and_boolean_constants
    assert_equal(
      {
        type: "object",
        properties: {
          version: {const: 7, description: "Schema version"},
          score: {const: 1.5},
          published: {const: true},
          archived: {const: false},
          status: {const: "ready"},
          missing: {type: "null"},
          label: {type: "string"}
        },
        required: %w[version score published archived status missing label],
        additionalProperties: false
      },
      ConstantFormat.to_json_schema
    )
  end

  def test_non_finite_float_constants_keep_a_serializable_numeric_schema
    [Float::INFINITY, -Float::INFINITY, Float::NAN].each do |literal|
      model = Class.new(OpenAI::BaseModel) { required(:value, const: literal) }
      schema = model.to_json_schema

      assert_equal({type: "number"}, schema.dig(:properties, :value))
      JSON.generate(schema)
    end
  end

  def test_public_chat_request_serializes_constant_schema
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 200,
      body: {
        id: "chatcmpl_constant",
        object: "chat.completion",
        created: 0,
        model: "test",
        choices: [
          {
            index: 0,
            finish_reason: "stop",
            message: {
              role: "assistant",
              content: JSON.generate(
                version: 7,
                score: 1.5,
                published: true,
                archived: false,
                status: "ready",
                missing: nil,
                label: "synthetic"
              )
            }
          }
        ]
      }
    )

    completion = @client.chat.completions.create(
      model: "test",
      messages: [{role: "user", content: "Return the synthetic format"}],
      response_format: ConstantFormat
    )

    assert_requested(:post, "http://localhost/chat/completions") do |request|
      schema = JSON.parse(request.body).dig("response_format", "json_schema", "schema")

      assert_equal(7, schema.dig("properties", "version", "const"))
      assert_equal(1.5, schema.dig("properties", "score", "const"))
      assert_equal(true, schema.dig("properties", "published", "const"))
      assert_equal(false, schema.dig("properties", "archived", "const"))
      assert_equal("ready", schema.dig("properties", "status", "const"))
      assert_equal("null", schema.dig("properties", "missing", "type"))
      assert_equal("string", schema.dig("properties", "label", "type"))
    end

    parsed = completion.choices.first.message.parsed

    assert_instance_of(ConstantFormat, parsed)
    assert_equal(7, parsed.version)
    assert_equal(1.5, parsed.score)
    assert_equal(true, parsed.published)
    assert_equal(false, parsed.archived)
    assert_equal(:ready, parsed.status)
    assert_nil(parsed.missing)
    assert_equal("synthetic", parsed.label)
  end
end
