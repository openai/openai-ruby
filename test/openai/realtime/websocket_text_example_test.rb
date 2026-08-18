# frozen_string_literal: true

require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/websocket_text"

class OpenAI::Test::RealtimeWebSocketTextExampleTest < Minitest::Test
  class RecordingResource
    attr_reader :calls

    def initialize = @calls = []
    def create(**params) = @calls << params
    def update(**params) = @calls << params
  end

  class RecordingConversation
    attr_reader :items

    def initialize = @items = RecordingResource.new
  end

  class RecordingConnection
    attr_reader :conversation, :response, :session

    def initialize(events)
      @events = events
      @conversation = RecordingConversation.new
      @response = RecordingResource.new
      @session = RecordingResource.new
    end

    def each(&block) = @events.each(&block)
  end

  class RecordingRealtime
    attr_reader :models

    def initialize(connection)
      @connection = connection
      @models = []
    end

    def connect(model:)
      @models << model
      yield(@connection)
    end
  end

  RecordingClient = Data.define(:realtime)

  def test_example_runs_the_text_lifecycle_without_echoing_the_prompt
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::SessionCreatedEvent.new(
          event_id: "event_created",
          session: {type: :realtime}
        ),
        OpenAI::Realtime::SessionUpdatedEvent.new(
          event_id: "event_updated",
          session: {type: :realtime, output_modalities: [:text]}
        ),
        OpenAI::Realtime::ResponseTextDeltaEvent.new(
          content_index: 0,
          delta: "Hello from Ruby.",
          event_id: "event_delta",
          item_id: "item_1",
          output_index: 0,
          response_id: "response_1"
        ),
        completed_response
      ]
    )
    realtime = RecordingRealtime.new(connection)
    output = StringIO.new
    secret_prompt = "customer-secret-prompt"

    OpenAI::Examples::Realtime::WebSocketText.run(
      client: RecordingClient.new(realtime: realtime),
      model: "gpt-realtime-2.1",
      prompt: secret_prompt,
      output: output
    )

    assert_equal(["gpt-realtime-2.1"], realtime.models)
    assert_equal([:text], connection.session.calls.fetch(0).fetch(:output_modalities))
    assert_equal(secret_prompt, connection.conversation.items.calls.fetch(0).dig(:content, 0, :text))
    assert_equal([{}], connection.response.calls)
    assert_includes(output.string, "Hello from Ruby.")
    assert_includes(output.string, "smoke test passed")
    refute_includes(output.string, secret_prompt)
  end

  def test_example_rejects_eof_or_a_completed_response_without_text
    eof_error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketText.stream_response(
        RecordingConnection.new([]),
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before response.done", eof_error.message)

    empty_error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketText.stream_response(
        RecordingConnection.new([completed_response]),
        output: StringIO.new
      )
    end

    assert_equal("Realtime response completed without text output", empty_error.message)
  end

  def test_example_keeps_server_error_details_out_of_the_exception_message
    customer_text = "private prompt echoed by the service"
    event = OpenAI::Realtime::RealtimeErrorEvent.new(
      event_id: "event_error",
      error: OpenAI::Realtime::RealtimeError.new(
        message: customer_text,
        type: "invalid_request_error"
      )
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketText.stream_response(
        RecordingConnection.new([event]),
        output: StringIO.new
      )
    end

    assert_equal("Realtime API error.", error.message)
    refute_includes(error.message, customer_text)
  end

  private def completed_response
    OpenAI::Realtime::ResponseDoneEvent.new(
      event_id: "event_done",
      response: OpenAI::Realtime::RealtimeResponse.new(
        id: "response_1",
        status: :completed,
        output: []
      )
    )
  end
end
