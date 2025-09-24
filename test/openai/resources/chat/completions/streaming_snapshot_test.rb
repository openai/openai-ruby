# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Chat::Completions::StreamingSnapshotTest < Minitest::Test
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

  def load_snapshot(filename)
    snapshot_path = File.join(__dir__, "snapshots", "#{filename}.txt")
    File.read(snapshot_path)
  end

  def stub_streaming_response(request_matcher, response_body)
    stub_request(:post, "http://localhost/chat/completions")
      .with(request_matcher)
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: response_body
      )
  end

  class StreamListener
    attr_reader :stream, :events

    def initialize(stream)
      @stream = stream
      @events = []
    end

    def collect
      @stream.each do |event|
        @events << event
      end
      self
    end

    def get_event_by_type(event_type)
      @events.find { |e| e.type == event_type }
    end
  end

  # Test BaseModel classes
  class LocationWeather < OpenAI::BaseModel
    required :city, String
    required :temperature, Float
    required :units, String # "c" or "f"
  end

  class LocationWeatherMultiple < OpenAI::BaseModel
    required :city, String
    required :temperature, Float
    required :units, String
  end

  class LocationWeatherMaxTokens < OpenAI::BaseModel
    required :city, String
    required :temperature, Float
    required :units, String
  end

  class LocationWeatherRefusal < OpenAI::BaseModel
    required :city, String
    required :temperature, Float
    required :units, String
  end

  class LocationWeatherLogprobs < OpenAI::BaseModel
    required :city, String
    required :temperature, Float
    required :units, String
  end

  class GetWeatherArgs < OpenAI::BaseModel
    required :city, String
    required :country, String
    required :units, String, nil?: true, default: "c"
  end

  class GetWeatherArgsMultiple < OpenAI::BaseModel
    required :city, String
    required :country, String
    required :units, String, nil?: true, default: "c"
  end

  class GetStockPrice < OpenAI::BaseModel
    required :ticker, String
    required :exchange, String
  end

  def make_stream_snapshot_request(params, snapshot_content, &_block)
    # Match minimally to avoid depending on client-side coercions
    expected_body = {
      model: params[:model],
      messages: params[:messages],
      stream: true
    }

    stub_streaming_response({body: hash_including(expected_body)}, snapshot_content)

    stream = @client.chat.completions.stream(**params)
    listener = StreamListener.new(stream)

    if block_given?
      stream.each do |event|
        listener.events << event
        yield(stream, event)
      end
    else
      listener.collect
    end

    listener
  end

  def make_raw_stream_snapshot_request(params, snapshot_content)
    # Match minimally to avoid depending on client-side coercions
    expected_body = {
      model: params[:model],
      messages: params[:messages],
      stream: true
    }

    stub_streaming_response({body: hash_including(expected_body)}, snapshot_content)

    state = OpenAI::Helpers::Streaming::ChatCompletionStreamState.new
    stream = @client.chat.completions.stream(**params)

    stream.each do |chunk|
      state.handle_chunk(chunk)
    end

    state
  end

  def test_parse_nothing
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in SF?"
          }
        ]
      },
      load_snapshot("e2aad469b71d")
    )

    completion = listener.stream.get_final_completion
    choice = completion.choices.first

    assert_equal(:stop, choice.finish_reason)
    assert_equal(0, choice.index)
    assert_nil(choice.logprobs)
    assert_match(/unable to provide real-time weather/i, choice.message.content)
    assert_nil(choice.message.parsed)
    assert_nil(choice.message.refusal)
    assert_equal(:assistant, choice.message.role)

    content_done = listener.events.find { |e| e.type == :"content.done" }
    assert_pattern do
      content_done => OpenAI::Helpers::Streaming::ChatContentDoneEvent[
        type: :"content.done",
        content: /unable to provide real-time weather/i,
        parsed: nil
      ]
    end
  end

  def test_parse_basemodel
    done_snapshots = []

    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in SF?"
          }
        ],
        response_format: LocationWeather
      },
      load_snapshot("7e5ea4d12e7c")
    ) do |stream, event|
      if event.type == :"content.done"
        done_snapshots << stream.current_completion_snapshot.dup
      end
    end

    assert_equal(1, done_snapshots.length)
    assert_kind_of(LocationWeather, done_snapshots.first.choices.first.message.parsed)

    # Check for content.delta events (without parsed data since we don't support partial JSON)
    content_delta_events = listener.events.select { |e| e.type == :"content.delta" }

    # Content delta events should exist but won't have parsed data
    assert(content_delta_events.any?, "Should have content.delta events")

    # Delta events should have nil parsed data since we removed partial JSON support
    content_delta_events.each do |event|
      assert_nil(event.parsed, "Delta events should not have parsed data without partial JSON support")
    end

    completion = listener.stream.get_final_completion
    assert_pattern do
      completion => {
        choices: [
          {
            finish_reason: :stop,
            index: 0,
            logprobs: nil,
            message: {
              annotations: nil,
              audio: nil,
              content: /{.*"city".*"temperature".*"units".*}/,
              function_call: nil,
              parsed: LocationWeather[
                city: "San Francisco",
                temperature: 61.0,
                units: "f"
              ],
              refusal: nil,
              role: :assistant,
              tool_calls: nil
            }
          }
        ],
        created: Integer,
        id: String,
        model: "gpt-4o-2024-08-06",
        object: :"chat.completion",
        service_tier: nil,
        system_fingerprint: String,
        usage: {
          completion_tokens: Integer,
          completion_tokens_details: Object,
          prompt_tokens: Integer,
          prompt_tokens_details: nil,
          total_tokens: Integer
        }
      }
    end

    content_done = listener.events.find { |e| e.type == :"content.done" }
    assert_pattern do
      content_done => OpenAI::Helpers::Streaming::ChatContentDoneEvent[
        type: :"content.done",
        content: /{.*"city".*"temperature".*"units".*}/,
        parsed: LocationWeather[
          city: "San Francisco",
          temperature: 61.0,
          units: "f"
        ]
      ]
    end
  end

  def test_parse_basemodel_multiple_choices
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in SF?"
          }
        ],
        n: 3,
        response_format: LocationWeather
      },
      load_snapshot("a491adda08c3")
    )

    # Check event sequence
    event_types = listener.events.map(&:type)

    # Count event types
    chunk_count = event_types.count(:chunk)
    content_delta_count = event_types.count(:"content.delta")
    content_done_count = event_types.count(:"content.done")

    assert(chunk_count.positive?)
    assert(content_delta_count.positive?)
    assert_equal(3, content_done_count)

    completion = listener.stream.get_final_completion
    assert_equal(3, completion.choices.length)

    # Expected temperatures for each choice index
    expected_temperatures = [65.0, 61.0, 59.0]

    completion.choices.each_with_index do |choice, idx|
      expected_temp = expected_temperatures[idx]
      assert_pattern do
        choice => {
          finish_reason: :stop,
          index: ^idx,
          logprobs: nil,
          message: {
            annotations: nil,
            audio: nil,
            content: /{.*"city".*"temperature".*"units".*}/,
            function_call: nil,
            parsed: LocationWeather[
              city: "San Francisco",
              temperature: ^expected_temp,
              units: "f"
            ],
            refusal: nil,
            role: :assistant,
            tool_calls: nil
          }
        }
      end
    end
  end

  def test_parse_max_tokens_reached
    error = assert_raises(OpenAI::LengthFinishReasonError) do
      make_stream_snapshot_request(
        {
          model: "gpt-4o-2024-08-06",
          messages: [
            {
              role: "user",
              content: "What's the weather like in SF?"
            }
          ],
          max_tokens: 1,
          response_format: LocationWeather
        },
        load_snapshot("4cc50a6135d2")
      )
    end

    assert_match(/length|max_tokens/, error.message.to_s.downcase)
  end

  def test_parse_basemodel_refusal
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "How do I make "
          }
        ],
        response_format: LocationWeather
      },
      load_snapshot("173417d55340")
    )

    refusal_done = listener.events.find { |e| e.type == :"refusal.done" }
    assert_pattern do
      refusal_done => OpenAI::Helpers::Streaming::ChatRefusalDoneEvent[
        type: :"refusal.done",
        refusal: /sorry.*can't assist/i
      ]
    end

    completion = listener.stream.get_final_completion
    choice = completion.choices.first
    assert_pattern do
      choice => {
        finish_reason: :stop,
        index: 0,
        logprobs: nil,
        message: {
          annotations: nil,
          audio: nil,
          content: nil,
          function_call: nil,
          parsed: nil,
          refusal: /sorry.*can't assist/i,
          role: :assistant,
          tool_calls: nil
        }
      }
    end
  end

  def test_content_logprobs_events
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "Say foo"
          }
        ],
        logprobs: true
      },
      load_snapshot("83b060bae42e")
    )

    logprobs_content_delta = listener.events.find { |e| e.type == :"logprobs.content.delta" }
    assert(logprobs_content_delta)
    assert_pattern do
      logprobs_content_delta => OpenAI::Helpers::Streaming::ChatLogprobsContentDeltaEvent[
        type: :"logprobs.content.delta",
        content: Array,
        snapshot: Array
      ]
    end

    logprobs_content_done = listener.events.find { |e| e.type == :"logprobs.content.done" }
    assert(logprobs_content_done)
    assert_pattern do
      logprobs_content_done => OpenAI::Helpers::Streaming::ChatLogprobsContentDoneEvent[
        type: :"logprobs.content.done",
        content: Array
      ]
    end

    assert(logprobs_content_done.content.all? { |lp| lp.respond_to?(:token) && lp.respond_to?(:logprob) })

    completion = listener.stream.get_final_completion
    choice = completion.choices.first
    assert_pattern do
      choice => {
        finish_reason: :stop,
        index: 0,
        logprobs: {
          content: Array,
          refusal: nil
        },
        message: {
          annotations: nil,
          audio: nil,
          content: /Foo/,
          function_call: nil,
          parsed: nil,
          refusal: nil,
          role: :assistant,
          tool_calls: nil
        }
      }
    end
  end

  def test_refusal_logprobs_events
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "How do I make "
          }
        ],
        logprobs: true,
        response_format: LocationWeather
      },
      load_snapshot("569c877e6942")
    )

    logprobs_refusal_delta = listener.events.find { |e| e.type == :"logprobs.refusal.delta" }
    assert(logprobs_refusal_delta)
    assert_pattern do
      logprobs_refusal_delta => OpenAI::Helpers::Streaming::ChatLogprobsRefusalDeltaEvent[
        type: :"logprobs.refusal.delta",
        refusal: Array,
        snapshot: Array
      ]
    end

    logprobs_refusal_done = listener.events.find { |e| e.type == :"logprobs.refusal.done" }
    assert(logprobs_refusal_done)
    assert_pattern do
      logprobs_refusal_done => OpenAI::Helpers::Streaming::ChatLogprobsRefusalDoneEvent[
        type: :"logprobs.refusal.done",
        refusal: Array
      ]
    end

    completion = listener.stream.get_final_completion
    choice = completion.choices.first
    assert_pattern do
      choice => {
        finish_reason: :stop,
        index: 0,
        logprobs: {
          content: nil,
          refusal: Array
        },
        message: {
          annotations: nil,
          audio: nil,
          content: nil,
          function_call: nil,
          parsed: nil,
          refusal: /sorry.*can't assist/i,
          role: :assistant,
          tool_calls: nil
        }
      }
    end
  end

  def test_parse_basemodel_tool
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in Edinburgh?"
          }
        ],
        tools: [
          {
            type: :function,
            function: {
              name: "GetWeatherArgs",
              description: "Function that accepts GetWeatherArgs parameters",
              parameters: GetWeatherArgs,
              strict: true
            }
          }
        ]
      },
      load_snapshot("c6aa7e397b71")
    )

    # Test the function arguments done event
    args_done = listener.events.find { |e| e.type == :"tool_calls.function.arguments.done" }
    assert_pattern do
      args_done => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: String,
        index: 0,
        arguments: /{.*"city".*"Edinburgh".*"country".*}/,
        parsed: GetWeatherArgs[
          city: "Edinburgh",
          country: "UK",
          units: "c"
        ]
      ]
    end

    completion = listener.stream.get_final_completion
    choice = completion.choices.first

    assert_pattern do
      choice => {
        finish_reason: :tool_calls,
        index: 0,
        logprobs: nil,
        message: {
          annotations: nil,
          audio: nil,
          content: nil,
          function_call: nil,
          parsed: nil,
          refusal: nil,
          role: :assistant,
          tool_calls: [
            {
              function: {
                arguments: /{.*"city".*"Edinburgh".*"country".*}/,
                name: String,
                parsed: GetWeatherArgs[
                  city: "Edinburgh",
                  country: "UK",
                  units: "c"
                ]
              },
              id: String,
              type: :function
            }
          ]
        }
      }
    end
  end

  def test_parse_multiple_basemodel_tools
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in Edinburgh?"
          },
          {
            role: "user",
            content: "What's the price of AAPL?"
          }
        ],
        tools: [
          {
            type: :function,
            function: {
              name: "GetWeatherArgs",
              description: "Function that accepts GetWeatherArgs parameters",
              parameters: GetWeatherArgsMultiple,
              strict: true
            }
          },
          {
            type: :function,
            function: {
              name: "get_stock_price",
              description: "Fetch the latest price for a given ticker",
              parameters: GetStockPrice,
              strict: true
            }
          }
        ]
      },
      load_snapshot("f82268f2fefd")
    )

    # Test the function arguments done events
    args_done_events = listener.events.select { |e| e.type == :"tool_calls.function.arguments.done" }
    assert_equal(2, args_done_events.length)

    # First tool call event (weather)
    weather_event = args_done_events[0]
    assert_pattern do
      weather_event => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: /GetWeatherArgs|get_weather_args/i,
        index: 0,
        arguments: /{.*"city".*"Edinburgh".*"country".*}/,
        parsed: GetWeatherArgsMultiple[
          city: "Edinburgh",
          country: "GB"
        ]
      ]
    end

    # Second tool call event (stock)
    stock_event = args_done_events[1]
    assert_pattern do
      stock_event => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: "get_stock_price",
        index: 1,
        arguments: /{.*"ticker".*"AAPL".*"exchange".*}/,
        parsed: GetStockPrice[
          ticker: "AAPL",
          exchange: "NASDAQ"
        ]
      ]
    end

    completion = listener.stream.get_final_completion
    choice = completion.choices.first

    assert_equal(2, choice.message.tool_calls.length)

    # Check first tool call (weather)
    weather_call = choice.message.tool_calls[0]
    assert_pattern do
      weather_call => {
        function: {
          arguments: /{.*"city".*"Edinburgh".*"country".*}/,
          name: /GetWeatherArgs|get_weather_args/i,
          parsed: GetWeatherArgsMultiple[
            city: "Edinburgh",
            country: "GB"
          ]
        },
        id: String,
        type: :function
      }
    end

    # Check second tool call (stock)
    stock_call = choice.message.tool_calls[1]
    assert_pattern do
      stock_call => {
        function: {
          arguments: /{.*"ticker".*"AAPL".*"exchange".*}/,
          name: "get_stock_price",
          parsed: GetStockPrice[
            ticker: "AAPL",
            exchange: "NASDAQ"
          ]
        },
        id: String,
        type: :function
      }
    end
  end

  def test_parse_strict_tools
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in SF?"
          }
        ],
        tools: [
          {
            type: :function,
            function: {
              name: "get_weather",
              parameters: {
                type: "object",
                properties: {
                  city: {type: "string"},
                  state: {type: "string"}
                },
                required: %w[city state],
                additionalProperties: false
              },
              strict: true
            }
          }
        ]
      },
      load_snapshot("a247c49c5fcd")
    )

    completion = listener.stream.get_final_completion
    choice = completion.choices.first

    assert_pattern do
      choice => {
        finish_reason: :tool_calls,
        index: 0,
        logprobs: nil,
        message: {
          annotations: nil,
          audio: nil,
          content: nil,
          function_call: nil,
          parsed: nil,
          refusal: nil,
          role: :assistant,
          tool_calls: [
            {
              function: {
                arguments: /{.*"city".*"San Francisco".*"state".*"CA".*}/,
                name: "get_weather",
                parsed: {
                  city: "San Francisco",
                  state: "CA"
                }
              },
              id: String,
              type: :function
            }
          ]
        }
      }
    end
  end

  def test_non_basemodel_response_format
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in SF? Give me any JSON back"
          }
        ],
        response_format: {type: "json_object"}
      },
      load_snapshot("d61558011839")
    )

    completion = listener.stream.get_final_completion
    choice = completion.choices.first

    assert_pattern do
      choice => {
        finish_reason: :stop,
        index: 0,
        logprobs: nil,
        message: {
          annotations: nil,
          audio: nil,
          content: /{.*"location".*San Francisco.*"weather".*}/m,
          function_call: nil,
          parsed: nil,
          refusal: nil,
          role: :assistant,
          tool_calls: nil
        }
      }
    end
  end

  def test_allows_non_strict_tools_but_no_parsing
    listener = make_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "what's the weather in NYC?"
          }
        ],
        tools: [
          {
            type: :function,
            function: {
              name: "get_weather",
              parameters: {
                type: "object",
                properties: {
                  city: {type: "string"}
                }
              }
            }
          }
        ]
      },
      load_snapshot("2018feb66ae1")
    )

    args_done = listener.events.find { |e| e.type == :"tool_calls.function.arguments.done" }
    assert_pattern do
      args_done => OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent[
        type: :"tool_calls.function.arguments.done",
        name: "get_weather",
        index: 0,
        arguments: /{.*"city".*"New York City".*}/,
        parsed: nil
      ]
    end

    completion = listener.stream.get_final_completion
    choice = completion.choices.first

    assert_pattern do
      choice => {
        finish_reason: :tool_calls,
        index: 0,
        logprobs: nil,
        message: {
          annotations: nil,
          audio: nil,
          content: nil,
          function_call: nil,
          parsed: nil,
          refusal: nil,
          role: :assistant,
          tool_calls: [
            {
              function: {
                arguments: /{.*"city".*"New York City".*}/,
                name: "get_weather",
                parsed: nil
              },
              id: String,
              type: :function
            }
          ]
        }
      }
    end
  end

  def test_chat_completion_state_helper
    state = make_raw_stream_snapshot_request(
      {
        model: "gpt-4o-2024-08-06",
        messages: [
          {
            role: "user",
            content: "What's the weather like in SF?"
          }
        ]
      },
      load_snapshot("e2aad469b71d")
    )

    completion = state.get_final_completion
    choice = completion.choices.first

    assert_pattern do
      choice => {
        finish_reason: :stop,
        index: 0,
        logprobs: nil,
        message: {
          annotations: nil,
          audio: nil,
          content: /unable to provide real-time weather/i,
          function_call: nil,
          parsed: nil,
          refusal: nil,
          role: :assistant,
          tool_calls: nil
        }
      }
    end
  end
end
