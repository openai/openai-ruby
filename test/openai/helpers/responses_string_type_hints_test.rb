# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponsesStringTypeHintsTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class TypeHintText < OpenAI::BaseModel
    required :value, String
  end

  class TypeHintTool < OpenAI::BaseModel
    required :argument, Integer
  end

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
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

  def test_string_json_schema_tag_matches_symbol_tag
    symbol_wire, symbol_response = create_response(
      text: text_config(:json_schema),
      output: [text_output]
    )
    string_wire, string_response = create_response(
      text: text_config("json_schema"),
      output: [text_output]
    )

    assert_equal(symbol_wire.fetch("text"), string_wire.fetch("text"))
    assert_equal(wire_schema(TypeHintText), string_wire.dig("text", "format", "schema"))
    assert_equal("explicit_text", string_wire.dig("text", "format", "name"))
    assert_equal(false, string_wire.dig("text", "format", "strict"))
    assert_equal("keep", string_wire.dig("text", "format", "description"))
    assert_instance_of(TypeHintText, symbol_response.output.first.content.first.parsed)
    assert_instance_of(TypeHintText, string_response.output.first.content.first.parsed)
    assert_equal("ok", string_response.output.first.content.first.parsed.value)
  end

  def test_string_function_tag_matches_symbol_tag
    symbol_wire, symbol_response = create_response(
      tools: [tool_config(:function)],
      output: [tool_output("lookup")]
    )
    string_wire, string_response = create_response(
      tools: [tool_config("function")],
      output: [tool_output("lookup")]
    )

    assert_equal(symbol_wire.fetch("tools"), string_wire.fetch("tools"))
    assert_equal(wire_schema(TypeHintTool), string_wire.dig("tools", 0, "parameters"))
    assert_equal("lookup", string_wire.dig("tools", 0, "name"))
    assert_equal(false, string_wire.dig("tools", 0, "strict"))
    assert_equal("keep", string_wire.dig("tools", 0, "description"))
    assert_instance_of(TypeHintTool, symbol_response.output.first.parsed)
    assert_instance_of(TypeHintTool, string_response.output.first.parsed)
    assert_equal(7, string_response.output.first.parsed.argument)
  end

  def test_string_tags_register_text_and_tool_models_together
    wire, response = create_response(
      text: text_config("json_schema"),
      tools: [tool_config("function")],
      output: [text_output, tool_output("lookup")]
    )

    assert_equal(wire_schema(TypeHintText), wire.dig("text", "format", "schema"))
    assert_equal(wire_schema(TypeHintTool), wire.dig("tools", 0, "parameters"))
    assert_instance_of(TypeHintText, response.output.fetch(0).content.first.parsed)
    assert_instance_of(TypeHintTool, response.output.fetch(1).parsed)
  end

  def test_string_function_tag_preserves_default_tool_name
    wire, response = create_response(
      tools: [{type: "function", parameters: TypeHintTool}],
      output: [tool_output("TypeHintTool")]
    )

    assert_equal("TypeHintTool", wire.dig("tools", 0, "name"))
    assert_instance_of(TypeHintTool, response.output.first.parsed)
  end

  private

  def wire_schema(model)
    JSON.parse(JSON.generate(model.to_json_schema))
  end

  def create_response(text: nil, tools: nil, output:)
    wire = nil
    stub_request(:post, "http://localhost/responses").to_return do |request|
      wire = JSON.parse(request.body)
      {
        status: 200,
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate(id: "resp_synthetic", object: "response", status: "completed", output: output)
      }
    end

    params = {model: "gpt-4o-mini", input: "synthetic"}
    params.store(:text, text) if text
    params.store(:tools, tools) if tools
    response = @client.responses.create(**params)

    [wire, response]
  end

  def text_config(type)
    {
      format: {
        type: type,
        name: "explicit_text",
        strict: false,
        description: "keep",
        schema: TypeHintText
      }
    }
  end

  def tool_config(type)
    {
      type: type,
      name: "lookup",
      strict: false,
      description: "keep",
      parameters: TypeHintTool
    }
  end

  def text_output
    {
      type: "message",
      id: "msg_synthetic",
      role: "assistant",
      status: "completed",
      content: [{type: "output_text", text: "{\"value\":\"ok\"}", annotations: []}]
    }
  end

  def tool_output(name)
    {
      type: "function_call",
      id: "fc_synthetic",
      call_id: "call_synthetic",
      name: name,
      arguments: "{\"argument\":7}",
      status: "completed"
    }
  end
end
