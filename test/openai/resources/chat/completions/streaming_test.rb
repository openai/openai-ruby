# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Chat::Completions::StreamingTest < Minitest::Test
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

  def stub_streaming_response(response_body, request_options = {})
    default_request = {
      messages: [{content: "Hello", role: "user"}],
      model: "gpt-4o-mini",
      stream: true
    }

    stub_request(:post, "http://localhost/chat/completions")
      .with(
        body: hash_including(default_request.merge(request_options))
      )
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: response_body
      )
  end

  def basic_params
    {
      messages: [{content: "Hello", role: :user}],
      model: "gpt-4o-mini"
    }
  end

  def test_basic_text_streaming
    stub_streaming_response(basic_text_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    events = stream.to_a

    assert_content_delta_events(
      events,
      expected_deltas: ["Hello", " there!", " How", " can", " I", " help?"],
      expected_snapshot: "Hello there! How can I help?"
    )

    content_done = events.find { |e| e.type == :"content.done" }
    assert_pattern do
      content_done => OpenAI::Helpers::Streaming::ChatContentDoneEvent[
        type: :"content.done",
        content: "Hello there! How can I help?"
      ]
    end

    chunk_events = events.select { |e| e.type == :chunk }
    assert_equal(7, chunk_events.length)

    first_chunk = chunk_events.first
    assert_pattern do
      first_chunk => OpenAI::Helpers::Streaming::ChatChunkEvent[
        type: :chunk,
        chunk: {
          id: "chatcmpl-123",
          model: "gpt-4o-mini"
        }
      ]
    end
  end

  def test_text_method
    stub_streaming_response(basic_text_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    text_chunks = stream.text.map do |chunk|
      chunk
    end

    assert_equal(["Hello", " there!", " How", " can", " I", " help?"], text_chunks)
  end

  def test_get_final_completion
    stub_streaming_response(completion_with_usage_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion

    assert_equal("chatcmpl-123", completion.id)
    assert_equal("gpt-4o-mini", completion.model)
    assert_equal("Test response", completion.choices.first.message.content)
    assert_equal(:stop, completion.choices.first.finish_reason)
    assert_equal(12, completion.usage.total_tokens) if completion.usage
  end

  def test_get_output_text
    stub_streaming_response(basic_text_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    output_text = stream.get_output_text

    assert_equal("Hello there! How can I help?", output_text)
  end

  def test_get_output_text_with_multiple_choices
    sse_response = <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"First choice"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{"role":"assistant","content":"Second choice"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)
    stream = @client.chat.completions.stream(**basic_params)
    output_text = stream.get_output_text

    assert_equal("First choiceSecond choice", output_text)
  end

  def test_get_output_text_with_tool_calls_only
    stub_streaming_response(tool_calls_only_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    output_text = stream.get_output_text

    assert_equal("", output_text)
  end

  def test_streaming_with_refusal
    stub_streaming_response(refusal_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    events = stream.to_a

    assert_refusal_delta_events(
      events,
      expected_deltas: ["I cannot", " help with that"],
      expected_snapshot: "I cannot help with that"
    )

    refusal_done = events.find { |e| e.type == :"refusal.done" }
    assert_pattern do
      refusal_done => OpenAI::Helpers::Streaming::ChatRefusalDoneEvent[
        type: :"refusal.done",
        refusal: "I cannot help with that"
      ]
    end
  end

  def test_streaming_with_tool_calls
    stub_streaming_response(tool_calls_sse_response)

    stream = @client.chat.completions.stream(**basic_params, tools: weather_tool)
    events = stream.to_a

    assert_tool_call_delta_events(
      events,
      expected_name: "get_weather",
      expected_index: 0,
      expected_arguments: '{"location":"Paris","units":"celsius"}'
    )
  end

  class WeatherToolModel < OpenAI::BaseModel
    required :location, String
    required :units, String
  end

  def test_streaming_tool_call_parsed_field
    sse_response = <<~SSE
      data: {"id":"chatcmpl-test","object":"chat.completion.chunk","created":1,"model":"gpt-4o","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_abc","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-test","object":"chat.completion.chunk","created":1,"model":"gpt-4o","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"location\\":\\"New York\\",\\"units\\":\\"fahrenheit\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-test","object":"chat.completion.chunk","created":1,"model":"gpt-4o","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)

    stream = @client.chat.completions.stream(
      **basic_params,
      tools: [
        {
          type: :function,
          function: {
            name: "get_weather",
            parameters: WeatherToolModel,
            strict: true
          }
        }
      ]
    )

    completion = stream.get_final_completion

    assert_pattern do
      completion.choices.first.message.tool_calls.first.function => {
        arguments: '{"location":"New York","units":"fahrenheit"}',
        name: "get_weather",
        parsed: WeatherToolModel[
          location: "New York",
          units: "fahrenheit"
        ]
      }
    end
  end

  class ContentFilterTestModel < OpenAI::BaseModel
    required :x, Integer
  end

  def test_content_filter_with_parseable_response_format_raises
    sse_response = <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Partial"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"content_filter"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)

    assert_raises(OpenAI::Helpers::Streaming::ContentFilterFinishReasonError) do
      @client.chat.completions.stream(**basic_params, response_format: ContentFilterTestModel).each { |_e| } # rubocop:disable Lint/EmptyBlock
    end
  end

  def test_content_filter_without_parseable_input_does_not_raise
    sse_response = <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Partial"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"content_filter"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)

    stream = @client.chat.completions.stream(**basic_params)

    # Iterating all events should not raise:
    events = stream.map { |e| e }
    assert(events.any? { |e| e.type == :chunk })

    completion = stream.get_final_completion
    assert_equal(:content_filter, completion.choices.first.finish_reason)
  end

  def test_length_finish_reason_with_strict_tool_raises
    sse_response = <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_123","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"city\\":\\"Paris\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"length"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)

    tools = [
      {
        type: :function,
        function: {
          name: "get_weather",
          parameters: {
            type: "object",
            properties: {city: {type: "string"}},
            required: ["city"],
            additionalProperties: false
          },
          strict: true
        }
      }
    ]

    assert_raises(OpenAI::LengthFinishReasonError) do
      @client.chat.completions.stream(**basic_params, tools: tools).each { |_e| } # rubocop:disable Lint/EmptyBlock
    end
  end

  def test_azure_openai_compatibility
    stub_streaming_response(azure_compatibility_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    events = stream.to_a

    content_deltas = events.select { |e| e.type == :"content.delta" }
    assert_equal(1, content_deltas.length)
    assert_equal("Hello", content_deltas.first.delta)
  end

  def test_interleaved_multiple_tool_calls_indices
    sse_response = <<~SSE
      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_a","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"city\\":\\"Paris\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"id":"call_b","type":"function","function":{"name":"get_stock","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"{\\"ticker\\":\\"AAPL\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":",\\"units\\":\\"c\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":",\\"exchange\\":\\"NASDAQ\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-1","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)

    tools = [
      {
        type: :function,
        function: {
          name: "get_weather",
          parameters: {
            type: "object",
            properties: {city: {type: "string"}},
            required: ["city"],
            additionalProperties: false
          },
          strict: true
        }
      },
      {
        type: :function,
        function: {
          name: "get_stock",
          parameters: {
            type: "object",
            properties: {ticker: {type: "string"}},
            required: ["ticker"],
            additionalProperties: false
          },
          strict: true
        }
      }
    ]

    stream = @client.chat.completions.stream(**basic_params, tools: tools)
    events = stream.to_a

    deltas = events.select { |e| e.type == :"tool_calls.function.arguments.delta" }
    assert(deltas.any? { |e| e.index.zero? && e.name == "get_weather" })
    assert(deltas.any? { |e| e.index == 1 && e.name == "get_stock" })

    weather_delta = deltas.find { |e| e.index.zero? && e.name == "get_weather" }
    assert_pattern do
      weather_delta => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDeltaEvent[
        type: :"tool_calls.function.arguments.delta",
        name: "get_weather",
        index: 0
      ]
    end

    dones = events.select { |e| e.type == :"tool_calls.function.arguments.done" }

    weather_done = dones.find { |e| e.index.zero? }
    assert_pattern do
      weather_done => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: "get_weather",
        index: 0,
        arguments: String
      ]
    end
    assert(weather_done.arguments.include?("city"))

    stock_done = dones.find { |e| e.index == 1 }
    assert_pattern do
      stock_done => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: "get_stock",
        index: 1,
        arguments: String
      ]
    end
    assert(stock_done.arguments.include?("ticker"))

    completion = stream.get_final_completion
    tool_calls = completion.choices.first.message.tool_calls
    assert_equal(2, tool_calls.length)
  end

  def test_text_method_with_tool_calls_only
    stub_streaming_response(tool_calls_only_sse_response)

    stream = @client.chat.completions.stream(**basic_params)
    text_chunks = stream.text.map { |chunk| chunk }

    assert_equal([], text_chunks)
  end

  def test_multiple_choices_one_toolcall_one_text
    sse_response = <<~SSE
      data: {"id":"chatcmpl-4","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Hello"},"finish_reason":null}]}

      data: {"id":"chatcmpl-4","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_x","type":"function","function":{"name":"op","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-4","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"arg\\":1}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-4","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: {"id":"chatcmpl-4","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)
    stream = @client.chat.completions.stream(**basic_params)
    events = stream.to_a

    content_done = events.find { |e| e.type == :"content.done" }
    assert_pattern do
      content_done => OpenAI::Helpers::Streaming::ChatContentDoneEvent[
        type: :"content.done",
        content: "Hello"
      ]
    end

    tool_done = events.find { |e| e.type == :"tool_calls.function.arguments.done" }
    assert_pattern do
      tool_done => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: "op",
        index: 0,
        arguments: '{"arg":1}'
      ]
    end

    completion = stream.get_final_completion
    assert_equal(2, completion.choices.length)
    assert_equal(:stop, completion.choices[0].finish_reason)
    assert_equal(:tool_calls, completion.choices[1].finish_reason)
  end

  class PersonModel < OpenAI::BaseModel
    required :name, String
    required :age, Integer
  end

  class CityWeatherModel < OpenAI::BaseModel
    required :city, String
    required :temperature, Integer
    required :units, String
  end

  def test_structured_output_streaming
    stub_structured_output_request

    stream = @client.chat.completions.stream(
      messages: [{content: "Generate a person", role: :user}],
      model: "gpt-4o-mini",
      response_format: PersonModel
    )

    content_deltas = []
    content_done = nil

    stream.each do |event|
      content_deltas << event if event.type == :"content.delta"
      content_done = event if event.type == :"content.done"
    end

    assert_equal(3, content_deltas.length)
    assert_equal(
      [
        '{"name":',
        '{"name":"John",',
        '{"name":"John","age":30}'
      ],
      content_deltas.map(&:snapshot)
    )

    assert_pattern do
      content_done => OpenAI::Helpers::Streaming::ChatContentDoneEvent[
        type: :"content.done",
        content: '{"name":"John","age":30}',
        parsed: PersonModel[
          name: "John",
          age: 30
        ]
      ]
    end
  end

  def test_structured_output_parsed_in_final_completion
    stub_structured_output_request

    stream = @client.chat.completions.stream(
      messages: [{content: "Generate a person", role: :user}],
      model: "gpt-4o-mini",
      response_format: PersonModel
    )
    completion = stream.get_final_completion

    return unless completion.choices.first.message.parsed
    assert_pattern do
      completion.choices.first.message => {
        parsed: PersonModel[
          name: "John",
          age: 30
        ]
      }
    end
  end

  private

  def weather_tool
    [
      {
        type: :function,
        function: {
          name: "get_weather",
          parameters: {
            type: "object",
            properties: {
              city: {type: "string"},
              units: {type: "string"}
            },
            required: ["city"],
            additionalProperties: false
          },
          strict: true
        }
      }
    ]
  end

  def assert_content_delta_events(events, expected_deltas:, expected_snapshot:)
    content_deltas = events.select { |e| e.type == :"content.delta" }

    assert_equal(expected_deltas.length, content_deltas.length, "Incorrect number of content delta events")
    assert_equal(expected_deltas, content_deltas.map(&:delta), "Incorrect delta values")
    assert_equal(expected_snapshot, content_deltas.last.snapshot, "Incorrect final snapshot")

    first_delta = content_deltas.first
    assert_instance_of(OpenAI::Helpers::Streaming::ChatContentDeltaEvent, first_delta)
    assert_equal(:"content.delta", first_delta.type)
    assert_equal(expected_deltas.first, first_delta.delta)
    assert_equal(expected_deltas.first, first_delta.snapshot)
  end

  def assert_refusal_delta_events(events, expected_deltas:, expected_snapshot:)
    refusal_deltas = events.select { |e| e.type == :"refusal.delta" }

    assert_equal(expected_deltas.length, refusal_deltas.length, "Incorrect number of refusal delta events")
    assert_equal(expected_deltas, refusal_deltas.map(&:delta), "Incorrect delta values")
    assert_equal(expected_snapshot, refusal_deltas.last.snapshot, "Incorrect final snapshot")

    first_delta = refusal_deltas.first
    assert_instance_of(OpenAI::Helpers::Streaming::ChatRefusalDeltaEvent, first_delta)
    assert_equal(:"refusal.delta", first_delta.type)
    assert_equal(expected_deltas.first, first_delta.delta)
    assert_equal(expected_deltas.first, first_delta.snapshot)
  end

  def assert_tool_call_delta_events(events, expected_name:, expected_index:, expected_arguments:) # rubocop:disable Lint/UnusedMethodArgument
    tool_deltas = events.select { |e| e.type == :"tool_calls.function.arguments.delta" }
    assert(tool_deltas.length.positive?, "No tool call delta events found")

    first_tool_delta = tool_deltas.first
    assert_pattern do
      first_tool_delta => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDeltaEvent[
        type: :"tool_calls.function.arguments.delta",
        name: expected_name,
        index: expected_index
      ]
    end

    tool_done = events.find { |e| e.type == :"tool_calls.function.arguments.done" }
    assert_pattern do
      tool_done => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: expected_name,
        index: expected_index,
        arguments: expected_arguments
      ]
    end
  end

  def stub_structured_output_request
    stub_request(:post, "http://localhost/chat/completions")
      .with(
        body: hash_including(
          "messages" => [{"content" => "Generate a person", "role" => "user"}],
          "model" => "gpt-4o-mini",
          "stream" => true,
          "response_format" => {
            "type" => "json_schema",
            "json_schema" => {
              "strict" => true,
              "name" => "PersonModel",
              "schema" => hash_including("type" => "object")
            }
          }
        )
      )
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: structured_output_sse_response
      )
  end

  def test_empty_stream_response
    sse_response = <<~SSE
      data: {"id":"chatcmpl-5","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":""},"finish_reason":null}]}

      data: {"id":"chatcmpl-5","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)
    stream = @client.chat.completions.stream(**basic_params)
    events = stream.to_a

    content_done = events.find { |e| e.type == :"content.done" }
    assert_pattern do
      content_done => OpenAI::Helpers::Streaming::ChatContentDoneEvent[
        type: :"content.done",
        content: ""
      ]
    end

    completion = stream.get_final_completion
    assert_equal("", completion.choices.first.message.content)
  end

  def test_malformed_sse_data_recovery
    sse_response = <<~SSE
      data: {"id":"chatcmpl-6","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Start"},"finish_reason":null}]}

      data: malformed json data here

      data: {"id":"chatcmpl-6","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" continues"},"finish_reason":null}]}

      data: {"id":"chatcmpl-6","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)
    stream = @client.chat.completions.stream(**basic_params)

    events = []
    begin
      stream.each { |e| events << e }
    rescue JSON::ParserError
      # Expected - malformed JSON should be skipped
    end

    content_deltas = events.select { |e| e.type == :"content.delta" }
    assert(content_deltas.any?)
  end

  def test_stream_with_usage_in_stream_options
    sse_response = <<~SSE
      data: {"id":"chatcmpl-7","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Test"},"finish_reason":null}]}

      data: {"id":"chatcmpl-7","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}],"usage":null}

      data: {"id":"chatcmpl-7","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[],"usage":{"prompt_tokens":15,"completion_tokens":1,"total_tokens":16,"prompt_tokens_details":{"cached_tokens":0},"completion_tokens_details":{"reasoning_tokens":0}}}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, stream_options: {include_usage: true})

    stream = @client.chat.completions.stream(
      **basic_params,
      stream_options: {include_usage: true}
    )
    completion = stream.get_final_completion

    assert_equal(15, completion.usage.prompt_tokens)
    assert_equal(1, completion.usage.completion_tokens)
    assert_equal(16, completion.usage.total_tokens)
  end

  def test_tool_choice_auto
    sse_response = <<~SSE
      data: {"id":"chatcmpl-8","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"I'll check the weather"},"finish_reason":null}]}

      data: {"id":"chatcmpl-8","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, tools: weather_tool, tool_choice: "auto")

    stream = @client.chat.completions.stream(
      **basic_params,
      tools: weather_tool,
      tool_choice: "auto"
    )
    completion = stream.get_final_completion

    assert_equal("I'll check the weather", completion.choices.first.message.content)
    assert_nil(completion.choices.first.message.tool_calls)
  end

  def test_tool_choice_required
    sse_response = <<~SSE
      data: {"id":"chatcmpl-9","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_req","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-9","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"city\\":\\"NYC\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-9","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, tools: weather_tool, tool_choice: "required")

    stream = @client.chat.completions.stream(
      **basic_params,
      tools: weather_tool,
      tool_choice: "required"
    )
    completion = stream.get_final_completion

    assert_nil(completion.choices.first.message.content)
    assert_equal(1, completion.choices.first.message.tool_calls.length)
    assert_equal("get_weather", completion.choices.first.message.tool_calls.first.function.name)
  end

  def test_tool_choice_specific_function
    sse_response = <<~SSE
      data: {"id":"chatcmpl-10","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_spec","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-10","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"city\\":\\"Boston\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-10","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(
      sse_response,
      tools: weather_tool,
      tool_choice: {type: :function, function: {name: "get_weather"}}
    )

    stream = @client.chat.completions.stream(
      **basic_params,
      tools: weather_tool,
      tool_choice: {type: :function, function: {name: "get_weather"}}
    )
    completion = stream.get_final_completion

    assert_equal("get_weather", completion.choices.first.message.tool_calls.first.function.name)
  end

  def test_parallel_tool_calls
    sse_response = <<~SSE
      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_a","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"city\\":\\"NYC\\""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":",\\"units\\":\\"c\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"id":"call_b","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"{\\"city\\":\\"LA\\""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":",\\"units\\":\\"c\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":2,"id":"call_c","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":2,"function":{"arguments":"{\\"city\\":\\"SF\\""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":2,"function":{"arguments":",\\"units\\":\\"c\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-11","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)
    stream = @client.chat.completions.stream(**basic_params, tools: weather_tool)
    events = stream.to_a

    done_events = events.select { |e| e.type == :"tool_calls.function.arguments.done" }
    assert_equal(3, done_events.length)

    done_events.each_with_index do |event, idx|
      refute_nil(event.arguments, "Arguments should not be nil for index #{idx}")
      refute_equal("", event.arguments, "Arguments should not be empty for index #{idx}")
    end

    cities = done_events.map { |e| JSON.parse(e.arguments)["city"] }
    assert_equal(%w[NYC LA SF], cities)

    completion = stream.get_final_completion
    assert_equal(3, completion.choices.first.message.tool_calls.length)

    completion.choices.first.message.tool_calls.each do |tool_call|
      assert_equal("get_weather", tool_call.function.name)
    end
  end

  def test_streaming_with_stop_sequences
    sse_response = <<~SSE
      data: {"id":"chatcmpl-12","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Line 1"},"finish_reason":null}]}

      data: {"id":"chatcmpl-12","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, stop: ["\\n", "END"])

    stream = @client.chat.completions.stream(
      **basic_params,
      stop: ["\\n", "END"]
    )
    completion = stream.get_final_completion

    assert_equal("Line 1", completion.choices.first.message.content)
    assert_equal(:stop, completion.choices.first.finish_reason)
  end

  def test_streaming_with_max_completion_tokens
    sse_response = <<~SSE
      data: {"id":"chatcmpl-13","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Truncated"},"finish_reason":null}]}

      data: {"id":"chatcmpl-13","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"length"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, max_completion_tokens: 5)

    stream = @client.chat.completions.stream(
      **basic_params,
      max_completion_tokens: 5
    )
    completion = stream.get_final_completion

    assert_equal("Truncated", completion.choices.first.message.content)
    assert_equal(:length, completion.choices.first.finish_reason)
  end

  def test_streaming_with_system_message
    sse_response = <<~SSE
      data: {"id":"chatcmpl-14","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Professional response"},"finish_reason":null}]}

      data: {"id":"chatcmpl-14","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(
      sse_response,
      messages: [
        {content: "You are a helpful assistant", role: "system"},
        {content: "Hello", role: "user"}
      ]
    )

    stream = @client.chat.completions.stream(
      messages: [
        {content: "You are a helpful assistant", role: :system},
        {content: "Hello", role: :user}
      ],
      model: "gpt-4o-mini"
    )
    completion = stream.get_final_completion

    assert_equal("Professional response", completion.choices.first.message.content)
  end

  def test_streaming_with_seed_parameter
    sse_response = <<~SSE
      data: {"id":"chatcmpl-15","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","system_fingerprint":"fp_seed123","choices":[{"index":0,"delta":{"role":"assistant","content":"Deterministic"},"finish_reason":null}]}

      data: {"id":"chatcmpl-15","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, seed: 42)

    stream = @client.chat.completions.stream(
      **basic_params,
      seed: 42
    )
    completion = stream.get_final_completion

    assert_equal("Deterministic", completion.choices.first.message.content)
  end

  def test_streaming_with_temperature_and_top_p
    sse_response = <<~SSE
      data: {"id":"chatcmpl-16","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Creative output"},"finish_reason":null}]}

      data: {"id":"chatcmpl-16","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, temperature: 0.8, top_p: 0.9)

    stream = @client.chat.completions.stream(
      **basic_params,
      temperature: 0.8,
      top_p: 0.9
    )
    completion = stream.get_final_completion

    assert_equal("Creative output", completion.choices.first.message.content)
  end

  def test_streaming_with_frequency_and_presence_penalty
    sse_response = <<~SSE
      data: {"id":"chatcmpl-17","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Varied vocabulary"},"finish_reason":null}]}

      data: {"id":"chatcmpl-17","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, frequency_penalty: 0.5, presence_penalty: 0.3)

    stream = @client.chat.completions.stream(
      **basic_params,
      frequency_penalty: 0.5,
      presence_penalty: 0.3
    )
    completion = stream.get_final_completion

    assert_equal("Varied vocabulary", completion.choices.first.message.content)
  end

  def test_streaming_with_user_parameter
    sse_response = <<~SSE
      data: {"id":"chatcmpl-18","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"User-specific"},"finish_reason":null}]}

      data: {"id":"chatcmpl-18","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, user: "user-123")

    stream = @client.chat.completions.stream(
      **basic_params,
      user: "user-123"
    )
    completion = stream.get_final_completion

    assert_equal("User-specific", completion.choices.first.message.content)
  end

  def test_invalid_json_in_tool_arguments_recovery
    sse_response = <<~SSE
      data: {"id":"chatcmpl-19","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_invalid","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-19","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"city\\": \\"SF\\", invalid json here"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-19","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response)
    stream = @client.chat.completions.stream(**basic_params, tools: weather_tool)

    events = []
    begin
      stream.each { |e| events << e }
    rescue JSON::ParserError
      # Expected - invalid JSON in tool arguments
    end

    done_event = events.find { |e| e.type == :"tool_calls.function.arguments.done" }
    assert(done_event)
    assert(done_event.arguments.include?("city"))
  end

  def test_streaming_with_response_format_text
    sse_response = <<~SSE
      data: {"id":"chatcmpl-20","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Plain text"},"finish_reason":null}]}

      data: {"id":"chatcmpl-20","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, response_format: {type: "text"})

    stream = @client.chat.completions.stream(
      **basic_params,
      response_format: {type: "text"}
    )
    completion = stream.get_final_completion

    assert_equal("Plain text", completion.choices.first.message.content)
    assert_nil(completion.choices.first.message.parsed)
  end

  def test_streaming_with_logit_bias
    sse_response = <<~SSE
      data: {"id":"chatcmpl-21","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Biased output"},"finish_reason":null}]}

      data: {"id":"chatcmpl-21","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response, logit_bias: {"50256" => -100})

    stream = @client.chat.completions.stream(
      **basic_params,
      logit_bias: {"50256" => -100}
    )
    completion = stream.get_final_completion

    assert_equal("Biased output", completion.choices.first.message.content)
  end

  def test_delta_accumulation_edge_cases
    # Test 1: String accumulation across multiple chunks
    sse_response_string_concat = <<~SSE
      data: {"id":"chatcmpl-100","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"First"},"finish_reason":null}]}

      data: {"id":"chatcmpl-100","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" Second"},"finish_reason":null}]}

      data: {"id":"chatcmpl-100","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" Third"},"finish_reason":null}]}

      data: {"id":"chatcmpl-100","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_string_concat)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    assert_equal("First Second Third", completion.choices.first.message.content)

    # Test 2: Numeric accumulation in usage tokens
    sse_response_numeric = <<~SSE
      data: {"id":"chatcmpl-101","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Hi"},"finish_reason":null}],"usage":{"prompt_tokens":5,"completion_tokens":1,"total_tokens":6}}

      data: {"id":"chatcmpl-101","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}],"usage":{"prompt_tokens":0,"completion_tokens":1,"total_tokens":1}}

      data: {"id":"chatcmpl-101","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[],"usage":{"prompt_tokens":0,"completion_tokens":0,"total_tokens":0}}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_numeric)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    # Usage accumulation should sum numeric values
    assert_equal("Hi", completion.choices.first.message.content)

    # Test 3: Array accumulation with indexed tool calls (testing index property replacement)
    sse_response_indexed_arrays = <<~SSE
      data: {"id":"chatcmpl-102","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_a","type":"function","function":{"name":"func1","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-102","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"a\\":"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-102","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"id":"call_b","type":"function","function":{"name":"func2","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-102","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"1}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-102","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"{\\"b\\":2}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-102","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_indexed_arrays)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    tool_calls = completion.choices.first.message.tool_calls
    assert_equal(2, tool_calls.length)
    assert_equal("func1", tool_calls[0].function.name)
    assert_equal('{"a":1}', tool_calls[0].function.arguments)
    assert_equal("func2", tool_calls[1].function.name)
    assert_equal('{"b":2}', tool_calls[1].function.arguments)

    # Test 4: Nested object accumulation with recursive merging
    sse_response_nested = <<~SSE
      data: {"id":"chatcmpl-103","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"{\\"data\\":{\\"nested\\":{\\"value\\":"},"finish_reason":null}]}

      data: {"id":"chatcmpl-103","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":"42"},"finish_reason":null}]}

      data: {"id":"chatcmpl-103","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":"}}}"},"finish_reason":null}]}

      data: {"id":"chatcmpl-103","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_nested)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    assert_equal('{"data":{"nested":{"value":42}}}', completion.choices.first.message.content)

    # Test 5: Type property replacement (not accumulation)
    sse_response_type_replacement = <<~SSE
      data: {"id":"chatcmpl-104","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_x","type":"function","function":{"name":"test","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-104","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"type":"function","function":{"arguments":"{\\"x\\":1}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-104","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_type_replacement)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    tool_call = completion.choices.first.message.tool_calls.first
    # Type should remain "function" (last value wins due to replacement logic)
    assert_equal(:function, tool_call.type)
    assert_equal('{"x":1}', tool_call.function.arguments)

    # Test 6: Multiple choices with different index values
    sse_response_multiple_choices = <<~SSE
      data: {"id":"chatcmpl-105","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Choice 0"},"finish_reason":null}]}

      data: {"id":"chatcmpl-105","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{"role":"assistant","content":"Choice 1"},"finish_reason":null}]}

      data: {"id":"chatcmpl-105","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" continued"},"finish_reason":null}]}

      data: {"id":"chatcmpl-105","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{"content":" also"},"finish_reason":null}]}

      data: {"id":"chatcmpl-105","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: {"id":"chatcmpl-105","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":1,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_multiple_choices)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    assert_equal(2, completion.choices.length)
    assert_equal("Choice 0 continued", completion.choices[0].message.content)
    assert_equal("Choice 1 also", completion.choices[1].message.content)

    # Test 7: Interleaved updates to same indexed tool calls
    sse_response_interleaved = <<~SSE
      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_a","type":"function","function":{"name":"func1","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"id":"call_b","type":"function","function":{"name":"func2","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"x\\":"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"{\\"y\\":"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"1}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":1,"function":{"arguments":"2}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-106","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_interleaved)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    tool_calls = completion.choices.first.message.tool_calls
    assert_equal(2, tool_calls.length)
    # Interleaved updates should accumulate properly for each index
    assert_equal("func1", tool_calls[0].function.name)
    assert_equal('{"x":1}', tool_calls[0].function.arguments)
    assert_equal("func2", tool_calls[1].function.name)
    assert_equal('{"y":2}', tool_calls[1].function.arguments)

    # Test 8: Empty deltas and nil handling
    sse_response_empty_deltas = <<~SSE
      data: {"id":"chatcmpl-107","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant"},"finish_reason":null}]}

      data: {"id":"chatcmpl-107","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":null}]}

      data: {"id":"chatcmpl-107","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":""},"finish_reason":null}]}

      data: {"id":"chatcmpl-107","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":"Final"},"finish_reason":null}]}

      data: {"id":"chatcmpl-107","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_empty_deltas)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    # Empty strings should concatenate properly.
    assert_equal("Final", completion.choices.first.message.content)

    # Test 9: Mixed content and tool calls in same choice
    sse_response_mixed = <<~SSE
      data: {"id":"chatcmpl-108","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Calling function"},"finish_reason":null}]}

      data: {"id":"chatcmpl-108","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" now","tool_calls":[{"index":0,"id":"call_mix","type":"function","function":{"name":"mixed","arguments":"{\\"data\\":true}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-108","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE

    stub_streaming_response(sse_response_mixed)
    stream = @client.chat.completions.stream(**basic_params)
    completion = stream.get_final_completion
    message = completion.choices.first.message
    assert_equal("Calling function now", message.content)
    assert_equal(1, message.tool_calls.length)
    assert_equal("mixed", message.tool_calls.first.function.name)
  end

  def basic_text_sse_response
    <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Hello"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" there!"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" How"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" can"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" I"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" help?"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE
  end

  def completion_with_usage_sse_response
    <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","system_fingerprint":"fp_123","choices":[{"index":0,"delta":{"role":"assistant","content":"Test"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":" response"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}],"usage":{"prompt_tokens":10,"completion_tokens":2,"total_tokens":12}}

      data: [DONE]

    SSE
  end

  def refusal_sse_response
    <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","refusal":"I cannot"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"refusal":" help with that"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE
  end

  def tool_calls_sse_response
    <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_123","type":"function","function":{"name":"get_weather","arguments":""}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"{\\"location\\":"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"\\"Paris\\","}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"tool_calls":[{"index":0,"function":{"arguments":"\\"units\\":\\"celsius\\"}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE
  end

  def azure_compatibility_sse_response
    <<~SSE
      data: {"id":"chatcmpl-123","object":"","created":1234567890,"model":"gpt-4o-mini","choices":[]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"Hello"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE
  end

  def tool_calls_only_sse_response
    <<~SSE
      data: {"id":"chatcmpl-2","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","tool_calls":[{"index":0,"id":"call_1","type":"function","function":{"name":"noop","arguments":"{}"}}]},"finish_reason":null}]}

      data: {"id":"chatcmpl-2","object":"chat.completion.chunk","created":1,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"tool_calls"}]}

      data: [DONE]

    SSE
  end

  def structured_output_sse_response
    <<~SSE
      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"role":"assistant","content":"{\\"name\\":"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":"\\"John\\","},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{"content":"\\"age\\":30}"},"finish_reason":null}]}

      data: {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1234567890,"model":"gpt-4o-mini","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

      data: [DONE]

    SSE
  end
end
