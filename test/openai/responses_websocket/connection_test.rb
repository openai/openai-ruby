# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::ResponsesWebSocketConnectionTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_connect_opens_a_block_scoped_connection_and_sends_response_create
    socket = FakeSocket.new(text_delta("hello", stream_id: "turn_1"))
    transport = FakeTransport.new(socket)
    event = nil

    result = client
      .responses
      .connect(
        request_options: {extra_headers: {"X-Trace-ID" => "trace_1"}, timeout: 12},
        transport: transport,
        transport_options: {max_frame_size: 1_024}
      ) do |connection|
        assert_instance_of(OpenAI::Responses::Connection, connection)
        assert_nil(connection.response.create(model: "gpt-5.2", input: "hi", stream_id: "turn_1"))
        event = connection.receive
        :block_result
      end

    assert_equal(:block_result, result)
    assert_instance_of(OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDelta, event)
    assert_equal("hello", event.delta)
    assert_equal("turn_1", event.stream_id)
    assert_equal("wss://example.com/v1/responses", transport.open_args.fetch(:url).to_s)
    assert_equal("Bearer test-key", transport.open_args.fetch(:headers).fetch("authorization"))
    assert_equal("trace_1", transport.open_args.fetch(:headers).fetch("x-trace-id"))
    assert_equal(12.0, transport.open_args.fetch(:timeout))
    assert_equal({max_frame_size: 1_024}, transport.open_args.fetch(:options))
    assert_equal(
      {"type" => "response.create", "model" => "gpt-5.2", "input" => "hi", "stream_id" => "turn_1"},
      JSON.parse(socket.writes.fetch(0))
    )
    assert_predicate(socket, :closed?)
  end

  def test_connect_requires_a_block
    error = assert_raises(ArgumentError) { client.responses.connect }

    assert_equal("A block is required to open a Responses WebSocket.", error.message)
  end

  def test_unknown_event_is_observable_without_exposing_payload_in_inspect
    secret = "secret-event-payload"
    socket = FakeSocket.new(JSON.generate(type: "response.future", stream_id: "turn_1", secret: secret))
    event = nil

    client.responses.connect(transport: FakeTransport.new(socket)) { |connection| event = connection.receive }

    assert_instance_of(OpenAI::Responses::UnknownServerEvent, event)
    assert_equal(:"response.future", event.type)
    assert_equal(secret, event.data.fetch(:secret))
    refute_includes(event.inspect, secret)
  end

  def test_parse_failures_are_payload_free
    secret = "secret-invalid-json"
    socket = FakeSocket.new("{#{secret}")

    error = assert_raises(OpenAI::Errors::ResponsesProtocolError) do
      client.responses.connect(transport: FakeTransport.new(socket)) { |connection| connection.receive }
    end

    assert_equal("Invalid Responses WebSocket event.", error.message)
    refute_includes(error.full_message, secret)
    assert_nil(error.cause)
  end

  def test_outbound_validation_is_payload_free_and_happens_before_write
    secret = "secret-prompt-value"
    socket = FakeSocket.new

    error = assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(model: secret, stream: true)
      end
    end

    assert_equal("Invalid Responses WebSocket client event.", error.message)
    refute_includes(error.full_message, secret)
    assert_empty(socket.writes)
  end

  def test_failed_write_poisons_connection_and_reports_unknown_outcome
    socket = FailingWriteSocket.new
    connection = nil

    error = assert_raises(OpenAI::Errors::ResponsesSendError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |opened|
        connection = opened
        opened.response.create(model: "gpt-5.2", input: "sensitive-body")
      end
    end

    assert_equal(:unknown, error.outcome)
    assert_nil(error.cause)
    assert_predicate(socket, :aborted?)
    assert_raises(OpenAI::Errors::ResponsesConnectionError) do
      connection.response.create(model: "gpt-5.2", input: "again")
    end
  end

  def test_generated_event_validation_stays_payload_free
    secret = "secret-invalid-model"
    socket = FakeSocket.new

    error = assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(model: [secret])
      end
    end

    refute_includes(error.full_message, secret)
    assert_empty(socket.writes)
  end

  def test_string_keyed_known_fields_still_receive_generated_validation
    secret = "secret-invalid-string-model"
    socket = FakeSocket.new

    error = assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.send_event("type" => "response.create", "model" => [secret])
      end
    end

    refute_includes(error.full_message, secret)
    assert_empty(socket.writes)
  end

  def test_nested_string_keys_receive_generated_validation
    secret = "secret-invalid-nested-mode"
    socket = FakeSocket.new

    error = assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.send_event(
          "type" => "response.create",
          "model" => "gpt-5.2",
          "prompt_cache_options" => {"mode" => [secret]}
        )
      end
    end

    refute_includes(error.full_message, secret)
    assert_empty(socket.writes)
  end

  def test_nested_mixed_keys_are_rejected_before_write
    socket = FakeSocket.new

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.send_event(
          type: "response.create",
          model: "gpt-5.2",
          prompt_cache_options: {:mode => "in_memory", "mode" => "24h"}
        )
      end
    end

    assert_empty(socket.writes)
  end

  def test_non_string_json_object_keys_are_rejected_before_write
    socket = FakeSocket.new

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(model: "gpt-5.2", future: {1 => "first", "1" => "second"})
      end
    end

    assert_empty(socket.writes)
  end

  def test_mixed_discriminators_and_beta_fields_are_rejected_before_write
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.send_event(:type => "response.create", "type" => "response.inject", :model => "gpt-5.2")
      end

      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", multi_agent: true)
      end
    end

    assert_empty(socket.writes)
  end

  def test_nested_known_beta_multi_agent_fields_are_rejected_before_write
    socket = FakeSocket.new

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(
          model: "gpt-5.2",
          input: [{type: "message", role: "user", agent: {agent_name: "researcher"}}]
        )
      end
    end

    assert_empty(socket.writes)
  end

  def test_non_message_input_items_reject_known_beta_agent_fields
    socket = FakeSocket.new

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(
          model: "gpt-5.2",
          input: [{type: "function_call_output", call_id: "call_1", output: "ok", agent: {}}]
        )
      end
    end

    assert_empty(socket.writes)
  end

  def test_typed_beta_input_items_are_rejected_after_dumping
    socket = FakeSocket.new
    item = OpenAI::Beta::BetaResponseInputItem::Message.new(
      content: [{type: :input_text, text: "hello"}],
      role: :user,
      agent: {agent_name: "researcher"},
      type: :message
    )

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(model: "gpt-5.2", input: [item])
      end
    end

    assert_empty(socket.writes)
  end

  def test_opaque_input_maps_can_use_beta_looking_names
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_nil(
        connection.response.create(
          model: "gpt-5.2",
          input: [
            {
              type: "tool_search_call",
              arguments: {type: "agent_message", agent: "opaque-value"}
            }
          ]
        )
      )
    end

    assert_equal(
      "opaque-value",
      JSON.parse(socket.writes.fetch(0)).dig("input", 0, "arguments", "agent")
    )
  end

  def test_opaque_maps_can_use_agent_keys_without_becoming_beta_events
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_nil(connection.response.create(model: "gpt-5.2", metadata: {agent: "ordinary-tag"}))
    end

    assert_equal("ordinary-tag", JSON.parse(socket.writes.fetch(0)).dig("metadata", "agent"))
  end

  def test_explicit_nil_websocket_fields_are_rejected_before_write
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", stream_id: nil)
      end

      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", generate: nil)
      end
    end

    assert_empty(socket.writes)
  end

  def test_non_string_stream_ids_and_non_boolean_generate_are_rejected_before_coercion
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", stream_id: 123)
      end

      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", generate: "false")
      end
    end

    assert_empty(socket.writes)
  end

  def test_cyclic_client_event_data_is_rejected_without_writing
    socket = FakeSocket.new
    cycle = {}
    cycle[:self] = cycle

    error = assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.response.create(model: "gpt-5.2", metadata: cycle)
      end
    end

    assert_equal("Invalid Responses WebSocket client event.", error.message)
    assert_empty(socket.writes)
  end

  def test_cyclic_typed_client_event_data_is_rejected_without_writing
    socket = FakeSocket.new
    cycle = {}
    cycle[:self] = cycle
    event = OpenAI::Responses::ResponsesClientEvent.new(
      type: :"response.create",
      model: "gpt-5.2",
      future: cycle
    )

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.send_event(event)
      end
    end

    assert_empty(socket.writes)
  end

  def test_each_owns_the_read_lease_and_rejects_nested_receive
    socket = FakeSocket.new(text_delta("hello"))

    error = assert_raises(OpenAI::Errors::ResponsesConnectionError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.each { |_event| connection.receive }
      end
    end

    assert_equal("Responses WebSocket already has an active reader.", error.message)
  end

  def test_each_enumerator_can_read_on_rubys_internal_fiber
    socket = FakeSocket.new(text_delta("hello"))

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      event = connection.each.next
      assert_equal("hello", event.delta)
    end
  end

  def test_receive_returns_nil_after_local_close_without_reading_queued_data
    socket = FakeSocket.new(text_delta("should-not-be-read"))

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.close
      assert_nil(connection.receive)
    end
  end

  def test_receive_rejects_reads_after_protocol_poisoning
    socket = FakeSocket.new("{invalid", text_delta("should-not-be-read"))

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesProtocolError) { connection.receive }
      error = assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
      assert_equal("Cannot read from a poisoned Responses WebSocket.", error.message)
    end
  end

  def test_foreign_owner_failure_does_not_release_the_active_read_lease
    socket = FakeSocket.new(text_delta("hello"), text_delta("nested"))

    error = assert_raises(OpenAI::Errors::ResponsesConnectionError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.each do |_event|
          thread = Thread.new do
            assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          end

          thread.join
          connection.receive
        end
      end
    end

    assert_equal("Responses WebSocket already has an active reader.", error.message)
  end

  def test_foreign_owner_close_and_abort_do_not_change_owner_state
    %i[close abort].each do |operation|
      socket = FakeSocket.new

      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        thread = Thread.new do
          assert_raises(OpenAI::Errors::ResponsesConnectionError) do
            operation == :close ? connection.close : connection.abort
          end
        end

        thread.join

        assert_nil(connection.response.create(model: "gpt-5.2"))
      end

      assert_equal(1, socket.writes.size)
    end
  end

  def test_rejects_invalid_or_too_many_named_stream_ids_before_writing
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", stream_id: "bad id")
      end

      32.times do |index|
        assert_nil(connection.response.create(model: "gpt-5.2", stream_id: "lane_#{index}"))
      end

      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", stream_id: "lane_32")
      end
    end

    assert_equal(32, socket.writes.size)
  end

  def test_generate_false_is_forwarded_but_http_only_fields_are_rejected
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_nil(connection.response.create(model: "gpt-5.2", generate: false))

      assert_raises(OpenAI::Errors::ResponsesClientEventError) do
        connection.response.create(model: "gpt-5.2", background: true)
      end
    end

    assert_equal(false, JSON.parse(socket.writes.fetch(0)).fetch("generate"))
    assert_equal(1, socket.writes.size)
  end

  def test_explicit_base_url_is_validated_and_proxy_authorization_is_stripped
    endpoint = +"wss://socket.example.test/custom/v2"
    transport = FakeTransport.new(FakeSocket.new)
    configured = client(default_headers: {"Proxy-Authorization" => "Basic configured-secret"})

    configured
      .responses
      .connect(
        websocket_base_url: endpoint,
        request_options: {extra_headers: {"proxy-authorization" => "Basic request-secret"}},
        transport: transport
      ) do |_connection|
        endpoint.replace("wss://attacker.invalid/v1")
      end

    assert_equal("wss://socket.example.test/custom/v2/responses", transport.open_args.fetch(:url).to_s)
    refute(transport.open_args.fetch(:headers).key?("proxy-authorization"))
  end

  def test_unsafe_base_urls_and_unsupported_request_options_fail_before_open
    [
      "/socket",
      "ftp://socket.example.test/v1",
      "wss://user:secret@socket.example.test/v1",
      "wss://socket.example.test/v1?tenant=one",
      "wss://socket.example.test/v1#fragment"
    ].each do |url|
      transport = FakeTransport.new(FakeSocket.new)
      assert_raises(ArgumentError) do
        client.responses.connect(websocket_base_url: url, transport: transport) { |_connection| nil }
      end

      assert_nil(transport.open_args)
    end

    [{max_retries: 1}, {extra_query: {"token" => "secret"}}].each do |request_options|
      transport = FakeTransport.new(FakeSocket.new)
      assert_raises(ArgumentError) do
        client.responses.connect(request_options: request_options, transport: transport) { |_connection| nil }
      end

      assert_nil(transport.open_args)
    end
  end

  def test_provider_clients_are_rejected_before_open
    azure = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://resource.openai.azure.com",
        api_key: "azure-key"
      )
    )
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(OpenAI::Errors::Error) do
      azure.responses.connect(transport: transport) { |_connection| nil }
    end

    assert_equal("Responses WebSocket connections are not supported by providers.", error.message)
    assert_nil(transport.open_args)
  end

  def test_workload_identity_refreshes_once_after_pre_yield_401
    configured = workload_identity_client
    transport = RejectOnceTransport.new
    tokens = ["stale-token", "fresh-token"]
    invalidations = 0

    configured.workload_identity_auth.stub(
      :get_token,
      -> (deadline:) {
        refute_nil(deadline)
        tokens.shift
      }
    ) do
      configured.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        configured.responses.connect(transport: transport) { |_connection| nil }
      end
    end

    assert_equal(1, invalidations)
    assert_equal(2, transport.attempts.length)
    assert_equal("Bearer stale-token", transport.attempts.fetch(0).dig(:headers, "authorization"))
    assert_equal("Bearer fresh-token", transport.attempts.fetch(1).dig(:headers, "authorization"))
  end

  def test_inbound_invalid_stream_id_is_a_payload_free_protocol_error
    secret = "secret-stream-id"
    socket = FakeSocket.new(JSON.generate(type: "response.future", stream_id: "bad #{secret}"))

    error = assert_raises(OpenAI::Errors::ResponsesProtocolError) do
      client.responses.connect(transport: FakeTransport.new(socket)) { |connection| connection.receive }
    end

    refute_includes(error.full_message, secret)
  end

  def test_connection_limit_event_is_yielded_and_then_rejects_sends
    limit = JSON.generate(
      type: "error",
      error: {
        type: "invalid_request_error",
        code: "websocket_connection_limit_reached",
        message: "Connection reached its limit.",
        param: nil
      }
    )
    socket = FakeSocket.new(limit)

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      event = connection.receive
      assert_instance_of(OpenAI::Responses::ResponsesServerEvent::ResponseWsError, event)
      assert_raises(OpenAI::Errors::ResponsesConnectionError) do
        connection.response.create(model: "gpt-5.2")
      end
    end
  end

  def test_default_transport_preserves_missing_dependency_guidance_without_cause
    transport = OpenAI::Responses::Transports::AsyncWebSocket.allocate
    missing = OpenAI::Errors::RealtimeConnectionError.new(
      url: URI("wss://example.com/v1/responses"),
      cause: LoadError.new("secret-load-path")
    )
    delegate = Object.new
    delegate.define_singleton_method(:open) { |**_kwargs| raise missing }
    transport.instance_variable_set(:@transport, delegate)

    error = assert_raises(OpenAI::Errors::ResponsesConnectionError) do
      transport.open(url: URI("wss://example.com/v1/responses"), headers: {}, timeout: 1) do
        nil
      end
    end

    assert_equal(
      "Responses WebSockets require the async-websocket gem. Add it to your Gemfile.",
      error.message
    )
    assert_nil(error.cause)
    refute_includes(error.full_message, "secret-load-path")
  end
end
