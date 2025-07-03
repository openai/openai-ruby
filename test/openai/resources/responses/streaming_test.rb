# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Responses::StreamingTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

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

  def stub_streaming_response(response_body)
    stub_request(:post, "http://localhost/responses")
      .with(
        body: hash_including(
          instructions: "You are a helpful assistant",
          messages: [{content: "Hello", role: "user"}],
          model: "gpt-4",
          stream: true
        )
      )
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: response_body
      )
  end

  def basic_params
    {
      instructions: "You are a helpful assistant",
      messages: [{content: "Hello", role: :user}],
      model: "gpt-4"
    }
  end

  def test_basic_text_streaming
    stub_streaming_response(basic_text_sse_response)

    stream = @client.responses.stream(**basic_params)
    events = stream.to_a

    assert_text_delta_events(
      events,
      expected_deltas: ["Hello there! ", "How can I help you ", "today?"],
      expected_snapshot: "Hello there! How can I help you today?"
    )

    text_done = events.find { |e| e.type == :"response.output_text.done" }
    assert_pattern do
      text_done => OpenAI::Streaming::ResponseTextDoneEvent[
        text: "Hello there! How can I help you today?"
      ]
    end

    completed = events.find { |e| e.type == :"response.completed" }
    assert_pattern do
      completed => OpenAI::Streaming::ResponseCompletedEvent[
        response: {
          id: "msg_001",
          status: :completed
        }
      ]
    end
  end

  def test_get_final_response
    stub_streaming_response(basic_text_sse_response)

    stream = @client.responses.stream(**basic_params)
    response = stream.get_final_response

    assert_pattern do
      response => OpenAI::Models::Responses::Response[
        id: "msg_001",
        status: :completed,
        output: [
          {
            content: [{text: "Hello there! How can I help you today?"}]
          }
        ]
      ]
    end
  end

  def test_get_output_text
    stub_streaming_response(basic_text_sse_response)

    stream = @client.responses.stream(**basic_params)
    text = stream.get_output_text

    assert_equal("Hello there! How can I help you today?", text)
  end

  def test_get_output_text_with_multiple_parts
    stub_streaming_response(multi_part_text_sse_response)

    stream = @client.responses.stream(**basic_params)
    text = stream.get_output_text

    assert_equal("First part of text. Second part of text.", text)
  end

  def test_get_output_text_with_no_text_content
    stub_streaming_response(function_calling_sse_response)

    stream = @client.responses.stream(**function_tool_params)
    text = stream.get_output_text

    assert_equal("", text)
  end

  def test_early_stream_close
    stub_streaming_response(basic_text_sse_response)

    events = []
    stream = @client.responses.stream(**basic_params)
    stream.each do |event|
      events << event
      break if event.type == :"response.output_text.delta" && event.delta == "How can I help you "
    end

    assert_equal(2, events.count { |e| e.type == :"response.output_text.delta" })
    refute(events.any? { |e| e.type == :"response.completed" })
  end

  class WeatherModel < OpenAI::BaseModel
    required :location, String
    required :temperature, Integer
  end

  def test_structured_output_streaming
    stub_streaming_response(structured_output_sse_response)

    text_deltas = []
    text_done = nil

    stream = @client.responses.stream(**basic_params, text: WeatherModel)
    stream.each do |event|
      text_deltas << event if event.type == :"response.output_text.delta"
      text_done = event if event.type == :"response.output_text.done"
    end

    assert_equal(3, text_deltas.length)
    assert_equal(
      [
        '{"location":"',
        '{"location":"San Francisco","temperature":',
        '{"location":"San Francisco","temperature":72}'
      ],
      text_deltas.map(&:snapshot)
    )

    assert_pattern do
      text_done => OpenAI::Streaming::ResponseTextDoneEvent[
        parsed: WeatherModel[
          location: "San Francisco",
          temperature: 72
        ]
      ]
    end
  end

  def test_structured_output_streaming_with_malformed_json
    stub_streaming_response(malformed_json_sse_response)

    error = assert_raises(RuntimeError) do
      stream = @client.responses.stream(**basic_params, text: WeatherModel)
      stream.each { |_event| } # Consume the stream to trigger the error.
    end

    assert_match(/Failed to parse structured text as JSON/, error.message)
    assert_match(/Raw text:/, error.message)
  end

  def test_function_calling_streaming
    stub_streaming_response(function_calling_sse_response)

    stream = @client.responses.stream(**function_tool_params)
    events = stream.to_a

    assert_function_delta_events(
      events,
      expected_deltas: ['{"location":"', "San Francisco", '"}'],
      expected_snapshot: '{"location":"San Francisco"}'
    )
  end

  def test_incomplete_streaming
    stub_streaming_response(incomplete_sse_response)

    stream = @client.responses.stream(**basic_params)
    assert_raises(RuntimeError, "Didn't receive a 'response.completed' event") do
      stream.get_final_response
    end
  end

  def test_text_method
    stub_streaming_response(basic_text_sse_response)

    stream = @client.responses.stream(**basic_params)
    text_chunks = stream.text.map do |chunk|
      chunk
    end

    assert_equal(["Hello there! ", "How can I help you ", "today?"], text_chunks)
  end

  def test_text_method_with_structured_output
    stub_streaming_response(structured_output_sse_response)

    stream = @client.responses.stream(**basic_params, text: WeatherModel)
    text_chunks = stream.text.map do |chunk|
      chunk
    end

    assert_equal(['{"location":"', 'San Francisco","temperature":', "72}"], text_chunks)
  end

  def test_resume_stream_with_response_id
    # Stub the GET request to retrieve the response.
    stub_request(:get, "http://localhost/responses/msg_123?stream=true")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: resume_stream_sse_response
      )

    stream = @client.responses.stream(previous_response_id: "msg_123")
    events = stream.to_a

    text_done = events.find { |e| e.type == :"response.output_text.done" }
    assert_equal("Hello there! How can I help you today?", text_done.text)

    completed = events.find { |e| e.type == :"response.completed" }
    assert_pattern do
      completed => OpenAI::Streaming::ResponseCompletedEvent[
        response: {
          id: "msg_123",
          status: :completed
        }
      ]
    end
  end

  def test_starting_after_without_response_id_errors
    assert_raises(ArgumentError) do
      @client.responses.stream(**basic_params, starting_after: 5)
    end
  end

  def test_resume_stream_with_response_id_and_starting_after
    # Stub the GET request to retrieve the response.
    stub_request(:get, "http://localhost/responses/msg_456?stream=true")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: resume_stream_with_starting_after_sse_response
      )

    stream = @client.responses.stream(previous_response_id: "msg_456", starting_after: 7)
    events = stream.to_a

    # Should only get events after sequence 7.
    assert(events.all? { |e| e.sequence_number > 7 })
    assert_equal(4, events.length)

    text_delta = events.find { |e| e.type == :"response.output_text.delta" }
    assert_equal("today?", text_delta.delta)
    assert_equal(8, text_delta.sequence_number)

    # Verify with assert_pattern that we get the correct event class and properties.
    assert_pattern do
      text_delta => OpenAI::Streaming::ResponseTextDeltaEvent[
        type: :"response.output_text.delta",
        delta: "today?",
        sequence_number: 8
      ]
    end

    text_done = events.find { |e| e.type == :"response.output_text.done" }
    assert_equal("Hello there! How can I help you today?", text_done.text)
    assert_equal(9, text_done.sequence_number)

    completed = events.find { |e| e.type == :"response.completed" }
    assert_equal("msg_456", completed.response[:id])
    assert_equal(11, completed.sequence_number)
  end

  def test_resume_stream_with_structured_output
    # Stub the GET request to retrieve the response (streaming).
    stub_request(:get, "http://localhost/responses/msg_structured?stream=true")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: resume_stream_structured_output_sse_response
      )

    stream = @client.responses.stream(previous_response_id: "msg_structured", text: WeatherModel)
    events = stream.to_a

    text_done = events.find { |e| e.type == :"response.output_text.done" }
    assert_equal("{\"location\":\"San Francisco\",\"temperature\":72}", text_done.text)

    # Verify the parsed content is available.
    assert_pattern do
      text_done => OpenAI::Streaming::ResponseTextDoneEvent[
        parsed: WeatherModel[
          location: "San Francisco",
          temperature: 72
        ]
      ]
    end

    completed = events.find { |e| e.type == :"response.completed" }
    assert_pattern do
      completed => OpenAI::Streaming::ResponseCompletedEvent[
        response: {
          id: "msg_structured",
          status: :completed
        }
      ]
    end
  end

  def test_structured_output_parsed_in_final_response
    stub_streaming_response(structured_output_sse_response)

    stream = @client.responses.stream(**basic_params, text: WeatherModel)
    final_response = stream.get_final_response

    assert_pattern do
      final_response => OpenAI::Models::Responses::Response[
        output: [
          {
            content: [
              {
                text: "{\"location\":\"San Francisco\",\"temperature\":72}",
                parsed: WeatherModel[
                  location: "San Francisco",
                  temperature: 72
                ]
              }
            ]
          }
        ]
      ]
    end
  end

  private

  def function_tool_params
    basic_params.merge(
      tools: [
        {
          type: "function",
          function: {
            name: "get_weather",
            description: "Get weather for a location",
            strict: true,
            parameters: WeatherModel
          }
        }
      ]
    )
  end

  def assert_text_delta_events(events, expected_deltas:, expected_snapshot:)
    text_deltas = events.select { |e| e.is_a?(OpenAI::Streaming::ResponseTextDeltaEvent) }

    assert_equal(expected_deltas.length, text_deltas.length, "Incorrect number of text delta events")
    assert_equal(expected_deltas, text_deltas.map(&:delta), "Incorrect delta values")
    assert_equal(expected_snapshot, text_deltas.last.snapshot, "Incorrect final snapshot")
  end

  def assert_function_delta_events(events, expected_deltas:, expected_snapshot:)
    function_deltas = events.select do |e|
      e.is_a?(OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent)
    end

    assert_equal(expected_deltas.length, function_deltas.length, "Incorrect number of function delta events")
    assert_equal(expected_deltas, function_deltas.map(&:delta), "Incorrect delta values")
    assert_equal(expected_snapshot, function_deltas.last.snapshot, "Incorrect final snapshot")
  end

  def basic_text_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_001","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.in_progress
      data: {"type":"response.in_progress","sequence_number":2,"response":{"id":"msg_001","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":3,"response_id":"msg_001","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"in_progress","role":"assistant","content":[]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":4,"response_id":"msg_001","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":5,"response_id":"msg_001","item_id":"item_001","output_index":0,"content_index":0,"delta":"Hello there! "}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":6,"response_id":"msg_001","item_id":"item_001","output_index":0,"content_index":0,"delta":"How can I help you "}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":7,"response_id":"msg_001","item_id":"item_001","output_index":0,"content_index":0,"delta":"today?"}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":8,"response_id":"msg_001","item_id":"item_001","output_index":0,"content_index":0,"text":"Hello there! How can I help you today?"}

      event: response.content_part.done
      data: {"type":"response.content_part.done","sequence_number":9,"response_id":"msg_001","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"Hello there! How can I help you today?"}}

      event: response.output_item.done
      data: {"type":"response.output_item.done","sequence_number":10,"response_id":"msg_001","item_id":"item_001","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":11,"response":{"id":"msg_001","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def resume_stream_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_123","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_123","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"msg_123","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"Hello there! How can I help you today?"}}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":4,"response_id":"msg_123","item_id":"item_001","output_index":0,"content_index":0,"text":"Hello there! How can I help you today?"}

      event: response.content_part.done
      data: {"type":"response.content_part.done","sequence_number":5,"response_id":"msg_123","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"Hello there! How can I help you today?"}}

      event: response.output_item.done
      data: {"type":"response.output_item.done","sequence_number":6,"response_id":"msg_123","item_id":"item_001","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":7,"response":{"id":"msg_123","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def resume_stream_with_starting_after_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_456","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_456","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"in_progress","role":"assistant","content":[]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":4,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"delta":"Hello there! "}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":5,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"delta":"How can I help you "}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":6,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"delta":"today?"}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":8,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"delta":"today?"}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":9,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"text":"Hello there! How can I help you today?"}

      event: response.content_part.done
      data: {"type":"response.content_part.done","sequence_number":10,"response_id":"msg_456","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"Hello there! How can I help you today?"}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":11,"response":{"id":"msg_456","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hello there! How can I help you today?"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def structured_output_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_002","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_002","output_index":0,"item":{"id":"item_002","object":"realtime.item","type":"message","status":"in_progress","role":"assistant","content":[]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"msg_002","item_id":"item_002","output_index":0,"content_index":0,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":4,"response_id":"msg_002","item_id":"item_002","output_index":0,"content_index":0,"delta":"{\\"location\\":\\""}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":5,"response_id":"msg_002","item_id":"item_002","output_index":0,"content_index":0,"delta":"San Francisco\\",\\"temperature\\":"}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":6,"response_id":"msg_002","item_id":"item_002","output_index":0,"content_index":0,"delta":"72}"}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":7,"response_id":"msg_002","item_id":"item_002","output_index":0,"content_index":0,"text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}

      event: response.output_item.done
      data: {"type":"response.output_item.done","sequence_number":8,"response_id":"msg_002","item_id":"item_002","output_index":0,"item":{"id":"item_002","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}]}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":9,"response":{"id":"msg_002","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_002","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def function_calling_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_003","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_003","output_index":0,"item":{"id":"item_003","object":"realtime.item","type":"function_call","status":"in_progress","name":"get_weather","arguments":"","call_id":"call_001"}}

      event: response.function_call_arguments.delta
      data: {"type":"response.function_call_arguments.delta","sequence_number":3,"item_id":"item_003","output_index":0,"delta":"{\\"location\\":\\""}

      event: response.function_call_arguments.delta
      data: {"type":"response.function_call_arguments.delta","sequence_number":4,"item_id":"item_003","output_index":0,"delta":"San Francisco"}

      event: response.function_call_arguments.delta
      data: {"type":"response.function_call_arguments.delta","sequence_number":5,"item_id":"item_003","output_index":0,"delta":"\\"}"}

      event: response.function_call_arguments.done
      data: {"type":"response.function_call_arguments.done","sequence_number":6,"item_id":"item_003","output_index":0,"arguments":"{\\"location\\":\\"San Francisco\\"}"}

      event: response.output_item.done
      data: {"type":"response.output_item.done","sequence_number":7,"response_id":"msg_003","item_id":"item_003","output_index":0,"item":{"id":"item_003","object":"realtime.item","type":"function_call","status":"completed","name":"get_weather","arguments":"{\\"location\\":\\"San Francisco\\"}","call_id":"call_001"}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":8,"response":{"id":"msg_003","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_003","object":"realtime.item","type":"function_call","status":"completed","name":"get_weather","arguments":"{\\"location\\":\\"San Francisco\\"}","call_id":"call_001"}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def incomplete_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_005","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","response_id":"msg_005","item_id":"item_005","output_index":0,"content_index":0,"delta":"Hello"}

    SSE
  end

  def malformed_json_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_malformed","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_malformed","output_index":0,"item":{"id":"item_malformed","object":"realtime.item","type":"message","status":"in_progress","role":"assistant","content":[]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"msg_malformed","item_id":"item_malformed","output_index":0,"content_index":0,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":4,"response_id":"msg_malformed","item_id":"item_malformed","output_index":0,"content_index":0,"delta":"{\\"location\\":\\""}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":5,"response_id":"msg_malformed","item_id":"item_malformed","output_index":0,"content_index":0,"delta":"San Francisco\\", malformed JSON"}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":6,"response_id":"msg_malformed","item_id":"item_malformed","output_index":0,"content_index":0,"text":"{\\"location\\":\\"San Francisco\\", malformed JSON"}

      event: response.completed
      data: {"type":"response.completed","sequence_number":7,"response":{"id":"msg_malformed","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_malformed","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\", malformed JSON"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def multi_part_text_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_multi","object":"realtime.response","status":"in_progress","status_details":null,"output":[],"usage":null,"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_multi","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"in_progress","role":"assistant","content":[]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":4,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":0,"delta":"First part of text."}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":5,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":0,"text":"First part of text."}

      event: response.content_part.done
      data: {"type":"response.content_part.done","sequence_number":6,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"First part of text."}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":7,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":1,"part":{"type":"output_text","text":""}}

      event: response.output_text.delta
      data: {"type":"response.output_text.delta","sequence_number":8,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":1,"delta":" Second part of text."}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":9,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":1,"text":" Second part of text."}

      event: response.content_part.done
      data: {"type":"response.content_part.done","sequence_number":10,"response_id":"msg_multi","item_id":"item_001","output_index":0,"content_index":1,"part":{"type":"output_text","text":" Second part of text."}}

      event: response.output_item.done
      data: {"type":"response.output_item.done","sequence_number":11,"response_id":"msg_multi","item_id":"item_001","output_index":0,"item":{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"First part of text."},{"type":"output_text","text":" Second part of text."}]}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":12,"response":{"id":"msg_multi","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_001","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"First part of text."},{"type":"output_text","text":" Second part of text."}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end

  def resume_stream_structured_output_sse_response
    <<~SSE
      event: response.created
      data: {"type":"response.created","sequence_number":1,"response":{"id":"msg_structured","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_002","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

      event: response.output_item.added
      data: {"type":"response.output_item.added","sequence_number":2,"response_id":"msg_structured","output_index":0,"item":{"id":"item_002","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}]}}

      event: response.content_part.added
      data: {"type":"response.content_part.added","sequence_number":3,"response_id":"msg_structured","item_id":"item_002","output_index":0,"content_index":0,"part":{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}}

      event: response.output_text.done
      data: {"type":"response.output_text.done","sequence_number":4,"response_id":"msg_structured","item_id":"item_002","output_index":0,"content_index":0,"text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}

      event: response.content_part.done
      data: {"type":"response.content_part.done","sequence_number":5,"response_id":"msg_structured","item_id":"item_002","output_index":0,"content_index":0,"part":{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}}

      event: response.output_item.done
      data: {"type":"response.output_item.done","sequence_number":6,"response_id":"msg_structured","item_id":"item_002","output_index":0,"item":{"id":"item_002","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}]}}

      event: response.completed
      data: {"type":"response.completed","sequence_number":7,"response":{"id":"msg_structured","object":"realtime.response","status":"completed","status_details":null,"output":[{"id":"item_002","object":"realtime.item","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"{\\"location\\":\\"San Francisco\\",\\"temperature\\":72}"}]}],"usage":{"total_tokens":20,"input_tokens":10,"output_tokens":10},"metadata":null}}

    SSE
  end
end
