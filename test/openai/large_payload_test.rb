# frozen_string_literal: true

require "async/http/server"
require "socket"

require_relative "test_helper"

class OpenAI::Test::LargePayloadTest < Minitest::Test
  extend Minitest::Serial

  # Large responses are valid API payloads. The high memory use is intentional:
  # do not shrink these probes or add/raise client limits to appease agents or CI.
  # This size crosses 32 MiB; it is a regression probe, not an API maximum.
  # Cover shared transports and independent helper accumulators sequentially.
  PAYLOAD_BYTES = (32 * 1024 * 1024) + 1

  def teardown
    super
    GC.start
  end

  def test_blocking_response_preserves_large_output_text
    text = large_text
    body = JSON.generate(response_with_text(text))

    with_http_body(body, content_type: "application/json") do |client|
      response = client.responses.create(model: "gpt-4.1", input: "Synthetic payload test")

      assert_large_text(text, response.output_text)
    end
  end

  def test_response_stream_preserves_large_delta_snapshot_and_final_output_text
    text = large_text
    response = response_with_text(text)
    item = response.fetch(:output).first
    events = [
      {type: "response.created", response: response.merge(status: "in_progress", output: [])},
      {type: "response.output_item.added", output_index: 0, item: item.merge(status: "in_progress", content: [])},
      {
        type: "response.content_part.added",
        item_id: "msg_large",
        output_index: 0,
        content_index: 0,
        part: {type: "output_text", text: "", annotations: []}
      },
      {
        type: "response.output_text.delta",
        item_id: "msg_large",
        output_index: 0,
        content_index: 0,
        delta: text
      },
      {type: "response.completed", response: response}
    ]
    body = events.each_with_index.map do |event, index|
      "event: #{event.fetch(:type)}\ndata: #{JSON.generate(event.merge(sequence_number: index))}\n\n"
    end

    with_http_body(body, content_type: "text/event-stream") do |client|
      # This public helper consumes the same Internal::Stream as stream_raw.
      stream = client.responses.stream(model: "gpt-4.1", input: "Synthetic payload test")
      begin
        deltas = 0
        stream.each do |event|
          next unless event.is_a?(OpenAI::Streaming::ResponseTextDeltaEvent)

          deltas += 1
          assert_large_text(text, event.delta)
          assert_large_text(text, event.snapshot)
        end

        assert_equal(1, deltas)
        assert_large_text(text, stream.get_final_response.output_text)
        assert_large_text(text, stream.get_output_text)
      ensure
        stream.close
      end
    end
  end

  def test_chat_stream_preserves_large_delta_snapshot_and_final_completion
    text = large_text
    chunk = {id: "chatcmpl_large", object: "chat.completion.chunk", created: 0, model: "gpt-4.1"}
    # Start empty so the large delta exercises accumulation, not only initialization.
    choices = [
      {index: 0, delta: {role: "assistant", content: ""}, finish_reason: nil},
      {index: 0, delta: {content: text}, finish_reason: nil},
      {index: 0, delta: {}, finish_reason: "stop"}
    ]
    body = choices.map { |choice| "data: #{JSON.generate(chunk.merge(choices: [choice]))}\n\n" }
    body << "data: [DONE]\n\n"

    with_http_body(body, content_type: "text/event-stream") do |client|
      # Chat shares the SSE reader but has its own ChatCompletionStream accumulator.
      stream = client.chat.completions.stream(
        model: "gpt-4.1",
        messages: [{role: "user", content: "Synthetic payload test"}]
      )
      begin
        deltas = 0
        stream.each do |event|
          next unless event.is_a?(OpenAI::Helpers::Streaming::ChatContentDeltaEvent) && !event.delta.empty?

          deltas += 1
          assert_large_text(text, event.delta)
          assert_large_text(text, event.snapshot)
        end

        assert_equal(1, deltas)
        assert_large_text(text, stream.get_final_completion.choices.first.message.content)
        assert_large_text(text, stream.get_output_text)
      ensure
        stream.close
      end
    end
  end

  private def response_with_text(text)
    {
      id: "resp_large",
      object: "response",
      created_at: 0,
      model: "gpt-4.1",
      status: "completed",
      output: [
        {
          id: "msg_large",
          type: "message",
          role: "assistant",
          status: "completed",
          content: [{type: "output_text", text: text, annotations: []}]
        }
      ]
    }
  end

  private def large_text
    ("x" * (PAYLOAD_BYTES - 5)) + "-tail"
  end

  private def assert_large_text(expected, actual)
    # Avoid dumping tens of megabytes into test output if preservation regresses.
    assert_equal(PAYLOAD_BYTES, actual.bytesize)
    assert_equal(Digest::SHA256.hexdigest(expected), Digest::SHA256.hexdigest(actual))
  end

  private def with_http_body(body, content_type:)
    application = lambda do |_request|
      Protocol::HTTP::Response[200, {"content-type" => content_type}, Array(body)]
    end

    with_server(application) { |client| yield(client) }
  end

  private def with_server(application)
    socket = TCPServer.new("127.0.0.1", 0)
    port = socket.local_address.ip_port
    socket.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    server = Async::HTTP::Server.new(application, endpoint)

    Sync do |task|
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://127.0.0.1:#{port}/v1",
        max_retries: 0
      )
      task.with_timeout(30) { yield(client) }
    ensure
      server_task&.stop
    end
  end
end
