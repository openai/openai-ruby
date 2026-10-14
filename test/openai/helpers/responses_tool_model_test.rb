# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponsesToolModelTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class LegacyToolModel < OpenAI::Internal::Type::BaseModel
    def self.to_json_schema = {type: "object"}
  end

  class ToolModel < OpenAI::BaseModel
    required :city, String
  end

  class ResponsesProbe < OpenAI::Resources::Responses
    def convert_tools(tools)
      get_structured_output_models(tools: tools)
    end
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

  def test_legacy_model_tool_is_converted_in_place
    [nil, "explicit_name"].each do |name|
      function = {parameters: LegacyToolModel}
      function[:name] = name if name
      tool = {type: :function, function: function}
      tools = [tool]

      model, tool_models = ResponsesProbe.allocate.convert_tools(tools)

      assert_nil(model)
      assert_equal({(name || "LegacyToolModel") => LegacyToolModel}, tool_models)
      assert_equal({type: "object"}, function[:parameters])
      assert_same(tool, tools.first)
    end
  end

  def test_non_model_parameters_are_left_untouched
    [nil, {}, String, OpenAI::Internal::Type::BaseModel].each do |parameters|
      function = {parameters: parameters}
      tool = {type: :function, function: function}
      tools = [tool]

      model, tool_models = ResponsesProbe.allocate.convert_tools(tools)

      assert_nil(model)
      assert_empty(tool_models)
      assert(parameters.equal?(function[:parameters]))
      assert_same(tool, tools.first)
    end
  end

  def test_create_serializes_flat_function_tools_and_hydrates_arguments
    function_call = {
      type: "function_call",
      call_id: "call_tool",
      name: "lookup",
      arguments: JSON.generate(city: "Paris")
    }
    stub_request(:post, "http://localhost/responses").to_return_json(
      status: 200,
      body: {id: "resp_tool", output: [function_call]}
    )

    tools = [
      {type: :function, name: "lookup", strict: false, description: "Look up a city", parameters: ToolModel},
      OpenAI::Responses::FunctionTool.new(
        name: "lookup",
        strict: false,
        description: "Look up a city",
        parameters: ToolModel
      )
    ]

    tools.each do |tool|
      response = @client.responses.create(model: "test", input: "hi", tools: [tool])

      assert_instance_of(ToolModel, response.output.first.parsed)
      assert_equal("Paris", response.output.first.parsed.city)
    end

    assert_requested(:post, "http://localhost/responses", times: tools.length) do |request|
      assert_equal(
        {
          "type" => "function",
          "name" => "lookup",
          "strict" => false,
          "description" => "Look up a city",
          "parameters" => JSON.parse(JSON.generate(ToolModel.to_json_schema))
        },
        JSON.parse(request.body).fetch("tools").fetch(0)
      )
    end
  end

  def test_stream_serializes_flat_function_tools_and_hydrates_arguments
    function_call = {
      type: "function_call",
      call_id: "call_tool",
      name: "lookup",
      arguments: JSON.generate(city: "Paris")
    }
    response = {id: "resp_tool_stream", status: "in_progress", output: []}
    events = [
      {type: "response.created", sequence_number: 0, response: response},
      {
        type: "response.completed",
        sequence_number: 1,
        response: response.merge(status: "completed", output: [function_call])
      }
    ]
    stub_request(:post, "http://localhost/responses").to_return(
      status: 200,
      headers: {"Content-Type" => "text/event-stream"},
      body: events.map { |event| "data: #{JSON.generate(event)}\n\n" }.join
    )

    stream = @client.responses.stream(
      model: "test",
      input: "hi",
      tools: [{type: :function, name: "lookup", strict: true, description: "Look up a city", parameters: ToolModel}]
    )
    function_call = stream.get_final_response.output.first

    assert_instance_of(ToolModel, function_call.parsed)
    assert_equal("Paris", function_call.parsed.city)
    assert_requested(:post, "http://localhost/responses") do |request|
      body = JSON.parse(request.body)

      assert_equal(true, body.fetch("stream"))
      assert_equal(
        {
          "type" => "function",
          "name" => "lookup",
          "strict" => true,
          "description" => "Look up a city",
          "parameters" => JSON.parse(JSON.generate(ToolModel.to_json_schema))
        },
        body.fetch("tools").fetch(0)
      )
    end
  end
end
