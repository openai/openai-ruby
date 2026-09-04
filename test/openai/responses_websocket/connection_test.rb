# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::ResponsesWebSocketConnectionTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  class SerializerMetadataProbe < OpenAI::Internal::Type::BaseModel
    required :type, const: :future
    optional :ruby_name, String, api_name: :apiName
  end

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

  def test_raw_io_helpers_remain_public_private_sdk_plumbing
    socket = FakeSocket.new("raw server message")

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_equal("raw server message", connection.receive_raw)
      assert_nil(connection.send_raw(JSON.generate(type: "response.create")))
    end

    assert_equal({"type" => "response.create"}, JSON.parse(socket.writes.fetch(0)))
  end

  def test_response_create_keeps_its_fixed_discriminator
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.response.create(type: :"response.cancel", model: "gpt-5.2")
      connection.response.create(**{"type" => :"response.cancel", :model => "gpt-5.2"})
    end

    assert_equal(
      {"type" => "response.create", "model" => "gpt-5.2"},
      JSON.parse(socket.writes.fetch(0))
    )
    assert_equal(
      {"type" => "response.create", "model" => "gpt-5.2"},
      JSON.parse(socket.writes.fetch(1))
    )
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

  def test_function_call_output_item_without_computed_parsed_is_received
    socket = FakeSocket.new(
      JSON.generate(
        type: "response.output_item.added",
        sequence_number: 1,
        output_index: 0,
        item: {
          type: "function_call",
          id: "fc_1",
          call_id: "call_1",
          name: "lookup",
          arguments: "{}"
        }
      )
    )
    event = nil

    client.responses.connect(transport: FakeTransport.new(socket)) { |connection| event = connection.receive }

    assert_instance_of(OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded, event)
    assert_instance_of(OpenAI::Responses::ResponseFunctionToolCall, event.item)
    assert_equal("call_1", event.item.call_id)
  end

  def test_replayed_function_call_without_computed_parsed_is_sent
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.response.create(
        model: "gpt-5.2",
        input: [
          {
            type: "function_call",
            id: "fc_1",
            call_id: "call_1",
            name: "lookup",
            arguments: "{}"
          }
        ]
      )
    end

    item = JSON.parse(socket.writes.fetch(0)).fetch("input").fetch(0)
    assert_equal("function_call", item.fetch("type"))
    assert_equal("call_1", item.fetch("call_id"))
    refute(item.key?("parsed"))
  end

  def test_partial_known_event_is_best_effort_typed_without_poisoning
    socket = FakeSocket.new(
      JSON.generate(
        type: "response.content_part.added",
        sequence_number: 1,
        item_id: "item_1",
        output_index: 0,
        content_index: 0,
        part: {type: "output_text", text: ""}
      ),
      text_delta("still-readable")
    )

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      event = connection.receive
      assert_instance_of(OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsAdded, event)
      assert_equal("still-readable", connection.receive.delta)
    end
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

  def test_close_aborts_after_ambiguous_write
    socket = FailingWriteSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesSendError) do
        connection.response.create(model: "gpt-5.2")
      end

      assert_nil(connection.close)
    end

    assert_predicate(socket, :aborted?)
    assert_nil(socket.close_args)
  end

  def test_nested_generated_models_keep_serializer_metadata
    socket = FakeSocket.new
    nested = SerializerMetadataProbe.new(ruby_name: "kept")

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.send_event(type: "response.create", future: nested)
    end

    assert_equal(
      {"type" => "future", "apiName" => "kept"},
      JSON.parse(socket.writes.fetch(0)).fetch("future")
    )
  end

  def test_nested_generated_model_rejects_api_name_collision_before_write
    socket = FakeSocket.new
    nested = SerializerMetadataProbe.new(ruby_name: "good", apiName: "bad")

    assert_raises(OpenAI::Errors::ResponsesClientEventError) do
      client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
        connection.send_event(type: "response.create", future: nested)
      end
    end

    assert_empty(socket.writes)
  end

  def test_raw_hash_without_type_is_forwarded
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.send_event(model: "gpt-5.2")
    end

    assert_equal({"model" => "gpt-5.2"}, JSON.parse(socket.writes.fetch(0)))
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

  def test_newer_fields_are_forwarded
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.response.create(model: "gpt-5.2", multi_agent: true, stream_id: 123)
    end

    payload = JSON.parse(socket.writes.fetch(0))
    assert_equal(true, payload.fetch("multi_agent"))
    assert_equal(123, payload.fetch("stream_id"))
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
    event = OpenAI::Responses::ResponsesClientEvent::ResponseCreate.new(
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

  def test_receive_can_continue_after_malformed_json
    socket = FakeSocket.new("{invalid", text_delta("still-readable"))

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(OpenAI::Errors::ResponsesProtocolError) { connection.receive }
      assert_equal("still-readable", connection.receive.delta)
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

  def test_foreign_owner_send_does_not_write
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      thread = Thread.new do
        assert_raises(OpenAI::Errors::ResponsesConnectionError) do
          connection.response.create(model: "gpt-5.2")
        end
      end

      thread.join
    end

    assert_empty(socket.writes)
  end

  def test_stream_ids_are_forwarded_without_client_policy
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.response.create(model: "gpt-5.2", stream_id: "bad id")
      33.times do |index|
        assert_nil(connection.response.create(model: "gpt-5.2", stream_id: "lane_#{index}"))
      end
    end

    assert_equal(34, socket.writes.size)
  end

  def test_response_fields_are_forwarded
    socket = FakeSocket.new

    client.responses.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_nil(connection.response.create(model: "gpt-5.2", generate: false))
      assert_nil(connection.response.create(model: "gpt-5.2", background: true))
    end

    assert_equal(false, JSON.parse(socket.writes.fetch(0)).fetch("generate"))
    assert_equal(true, JSON.parse(socket.writes.fetch(1)).fetch("background"))
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

  def test_workload_identity_timeout_stays_payload_free
    configured = workload_identity_client(timeout: 0.01)
    transport = FakeTransport.new(FakeSocket.new)
    clock = [100.0, 100.02]

    error = OpenAI::Internal::Util.stub(:monotonic_secs, -> { clock.shift || 100.02 }) do
      get_token = -> (deadline:) {
        assert_equal(100.01, deadline)
        "fresh-token"
      }

      configured.workload_identity_auth.stub(:get_token, get_token) do
        assert_raises(OpenAI::Errors::ResponsesConnectionError) do
          configured.responses.connect(transport: transport) { |_connection| nil }
        end
      end
    end

    assert_nil(error.cause)
    refute_includes(error.full_message, "Timeout::Error")
    assert_nil(transport.open_args)
  end

  def test_inbound_stream_ids_are_forward_compatible
    secret = "secret-stream-id"
    socket = FakeSocket.new(JSON.generate(type: "response.future", stream_id: "bad #{secret}"))

    event = nil
    client.responses.connect(transport: FakeTransport.new(socket)) { |connection| event = connection.receive }

    assert_equal("bad #{secret}", event.stream_id)
  end

  def test_unknown_event_preserves_non_string_stream_id
    socket = FakeSocket.new(JSON.generate(type: "response.future", stream_id: 123))
    event = nil

    client.responses.connect(transport: FakeTransport.new(socket)) { |connection| event = connection.receive }

    assert_equal(123, event.stream_id)
  end

  def test_error_event_is_yielded_without_poisoning_connection
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
      assert_nil(connection.response.create(model: "gpt-5.2"))
    end
  end

  def test_default_transport_preserves_missing_dependency_guidance_without_cause
    transport_class = Class.new(OpenAI::Responses::Transports::AsyncWebSocket) do
      private def load_dependencies(url)
        raise(
          @error_factory.call(
            url: url,
            message: @dependency_message,
            cause: LoadError.new("secret-load-path")
          )
        )
      end
    end

    transport = transport_class.new

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
