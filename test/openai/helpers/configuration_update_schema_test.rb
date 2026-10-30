# frozen_string_literal: true

require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::ConfigurationUpdateSchemaTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  class Answer < OpenAI::BaseModel
    required :answer, String
  end

  class Evidence < OpenAI::BaseModel
    required :source, String
  end

  def test_create_and_stream_parse_the_last_visible_format
    WebMock.enable!
    typed = {"type" => "json_schema", "name" => "evidence", "schema" => Evidence}.freeze
    raw = {type: :json_schema, name: "raw", schema: {type: "object"}}
    reset = {type: :text}
    [
      [[], "{\"answer\":\"short\"}", Answer],
      [[typed, reset], "plain text", nil],
      [[typed, raw], "{\"source\":\"notes\"}", nil],
      [[reset, typed], "{\"source\":\"notes\"}", Evidence]
    ].each do |formats, output, expected_model|
      input = formats.map { |format| {type: :configuration_update, text: {format: format}} }
      input << {type: :configuration_update, reasoning: {effort: :low}}
      content = {type: "output_text", text: output, annotations: []}
      response = {
        id: "resp_1",
        object: "response",
        status: "completed",
        output: [{type: "message", id: "msg_1", role: "assistant", status: "completed", content: [content]}]
      }
      stub_request(:post, "https://example.com/v1/responses").to_return do |request|
        body = JSON.parse(request.body)
        assert_equal(wire_schema, body.dig("text", "format", "schema"))
        if body["stream"]
          events = [
            {type: "response.created", sequence_number: 0, response: response.merge(status: "in_progress", output: [])},
            {type: "response.completed", sequence_number: 1, response: response}
          ]
          {headers: {"Content-Type" => "text/event-stream"}, body: events.map { |e| "data: #{e.to_json}\n\n" }.join}
        else
          {headers: {"Content-Type" => "application/json"}, body: response.to_json}
        end
      end

      params = {model: "test-model", text: Answer, input: input}
      [client.responses.create(params), client.responses.stream(params).get_final_response].each do |result|
        text = result.output.first.content.first
        assert_equal(output, text.text)
        if expected_model
          assert_instance_of(expected_model, text.parsed)
          assert_equal(JSON.parse(output, symbolize_names: true), text.parsed.to_h)
        else
          assert_nil(text.parsed)
        end
      end
    end

    assert_same(Evidence, typed.fetch("schema"))
  ensure
    WebMock.reset!
    WebMock.disable!
  end

  def test_responses_and_conversations_send_schema_objects
    WebMock.enable!
    bodies = []
    stub_request(:post, %r{https://example\.com/v1/}).to_return do |request|
      bodies << JSON.parse(request.body)
      response = case request.uri.path
      when "/v1/conversations"
        {id: "conv_1", object: "conversation", created_at: 0, metadata: {}}
      when "/v1/conversations/conv_1/items"
        {object: "list", data: [], has_more: false}
      else
        {id: "resp_1", object: "response", output: []}
      end

      {status: 200, headers: {"Content-Type" => "application/json"}, body: JSON.generate(response)}
    end

    format = {"type" => "json_schema", "name" => "answer", "strict" => false, "schema" => Answer}.freeze
    item = {"type" => "configuration_update", "text" => {"format" => format}.freeze}.freeze
    raw_schema = {type: "object", properties: {value: {type: "integer"}}}
    items = [
      item,
      OpenAI::Responses::ResponseConfigurationUpdateItemParam.new(text: {format_: format}),
      {type: :configuration_update, text: {format: {type: :json_schema, name: "raw", schema: raw_schema}}},
      {type: :configuration_update, text: {format: {type: :text}}},
      {type: :configuration_update, reasoning: {effort: :low}},
      {type: :configuration_update, text: {format_: {type: :text}}}
    ]
    client.responses.create(model: "test-model", input: items)
    client.beta.responses.create(model: "test-model", input: items)
    client.conversations.create(items: items)
    client.conversations.items.create("conv_1", items: items)

    assert_equal(4, bodies.size)
    bodies.each do |body|
      inputs = body["input"] || body.fetch("items")
      [0, 1].each do |index|
        assert_equal(format.merge("schema" => wire_schema), inputs.fetch(index).dig("text", "format"))
      end

      assert_equal(JSON.parse(JSON.generate(raw_schema)), inputs.fetch(2).dig("text", "format", "schema"))
      assert_equal({"type" => "text"}, inputs.fetch(3).dig("text", "format"))
      refute(inputs.fetch(4).key?("text"))
      assert_equal({"format" => {"type" => "text"}}, inputs.fetch(5).fetch("text"))
    end

    assert_same(Answer, format.fetch("schema"))
  ensure
    WebMock.reset!
    WebMock.disable!
  end

  def test_websockets_send_schema_objects_in_input_arrays_and_single_items
    item = {type: :configuration_update, text: {format: {type: :json_schema, name: "answer", schema: Answer}}}
    [
      [client.responses, {type: "response.create", model: "test-model", input: [item]}, ["input", 0]],
      [client.beta.responses, {type: "response.inject", response_id: "resp_1", input: [item]}, ["input", 0]],
      [client.live, {type: "response.item.create", item: item}, ["item"]]
    ].each do |resource, event, path|
      socket = FakeSocket.new
      resource.connect(transport: FakeTransport.new(socket)) { |connection| connection.send_event(event) }
      assert_equal(wire_schema, JSON.parse(socket.writes.fetch(0)).dig(*path, "text", "format", "schema"))
    end

    assert_same(Answer, item.dig(:text, :format, :schema))
  end

  private def wire_schema = JSON.parse(JSON.generate(Answer.to_json_schema))
end
