# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RealtimeConnectionTest < Minitest::Test
  class FakeSocket
    attr_reader :writes, :close_args

    def initialize(*reads)
      @reads = reads
      @writes = []
      @closed = false
    end

    def read = @reads.shift
    def write(message) = @writes << message
    def closed? = @closed

    def close(code: 1000, reason: "")
      @closed = true
      @close_args = {code: code, reason: reason}
    end
  end

  class FakeTransport
    attr_reader :open_args

    def initialize(socket)
      @socket = socket
    end

    def open(url:, headers:, timeout:, **options)
      @open_args = {url: url, headers: headers, timeout: timeout, options: options}
      yield(@socket)
    end
  end

  class FailingCloseSocket < FakeSocket
    def close(code: 1000, reason: "")
      super
      raise IOError, "close failed"
    end
  end

  def client(**options)
    OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      **options
    )
  end

  def test_connect_opens_a_typed_block_scoped_connection
    socket = FakeSocket.new(
      JSON.generate(
        type: "response.output_text.delta",
        event_id: "event_1",
        response_id: "response_1",
        item_id: "item_1",
        output_index: 0,
        content_index: 0,
        delta: "hello"
      )
    )
    transport = FakeTransport.new(socket)
    event = nil

    result = client.realtime.connect(
      model: "gpt-realtime",
      request_options: {
        extra_query: {trace: "yes"},
        extra_headers: {"X-Trace-ID" => "trace_1"},
        timeout: 12
      },
      transport: transport,
      transport_options: {max_frame_size: 1_024}
    ) do |connection|
      assert_instance_of(OpenAI::Realtime::Connection, connection)
      event = connection.receive
      :block_result
    end

    assert_equal(:block_result, result)
    assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
    assert_equal("hello", event.delta)
    assert_equal("wss://example.com/v1/realtime?model=gpt-realtime&trace=yes", transport.open_args[:url].to_s)
    assert_equal("Bearer test-key", transport.open_args[:headers].fetch("authorization"))
    assert_equal("trace_1", transport.open_args[:headers].fetch("x-trace-id"))
    assert_equal(12.0, transport.open_args[:timeout])
    assert_equal({max_frame_size: 1_024}, transport.open_args[:options])
    assert(socket.closed?)
  end

  def test_connect_rejects_transport_options_that_override_authenticated_inputs
    dangerous_options = [
      :url,
      :headers,
      :timeout,
      :hostname,
      :port,
      :scheme,
      :ssl_context,
      :protocol,
      :alpn_protocols
    ]

    dangerous_options.product([false, true]).each do |key, stringify|
      transport_key = stringify ? key.to_s : key
      transport = FakeTransport.new(FakeSocket.new)

      error = assert_raises(ArgumentError) do
        client.realtime.connect(
          model: "gpt-realtime",
          transport: transport,
          transport_options: {transport_key => Object.new}
        ) { |_connection| nil }
      end

      assert_includes(error.message, transport_key.inspect)
      assert_nil(transport.open_args)
    end
  end

  def test_connect_to_a_dedicated_transcription_session
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect_transcription(transport: transport) do |connection|
      assert_instance_of(OpenAI::Realtime::TranscriptionConnection, connection)
      assert_instance_of(OpenAI::Realtime::ConnectionResources::TranscriptionSession, connection.session)
      assert_respond_to(connection.input_audio_buffer, :commit)
      assert_respond_to(connection.input_audio_buffer, :clear)
      refute_respond_to(connection, :response)
      refute_respond_to(connection, :conversation)
      refute_respond_to(connection, :output_audio_buffer)
      connection.session.update(audio: {input: {turn_detection: nil}}, event_id: "update_1")
    end

    assert_equal(
      "wss://example.com/v1/realtime?intent=transcription",
      transport.open_args[:url].to_s
    )
    update = JSON.parse(socket.writes.fetch(0), symbolize_names: true)
    assert_equal(:transcription, update.dig(:session, :type).to_sym)
    assert_equal("update_1", update.fetch(:event_id))
    refute(update.fetch(:session).key?(:event_id))
  end

  def test_connect_to_an_existing_webrtc_or_sip_call
    transport = FakeTransport.new(FakeSocket.new)

    client.realtime.connect_to_call(call_id: "rtc_123", transport: transport) do |connection|
      assert_instance_of(OpenAI::Realtime::SidebandConnection, connection)
      assert_respond_to(connection, :output_audio_buffer)
    end

    assert_equal("wss://example.com/v1/realtime?call_id=rtc_123", transport.open_args[:url].to_s)
  end

  def test_connect_uses_an_explicit_websocket_base_url
    transport = FakeTransport.new(FakeSocket.new)
    custom_client = client(websocket_base_url: "wss://socket.example.test/custom/v2")

    custom_client.realtime.connect(model: "gpt-realtime", transport: transport) { |_connection| nil }

    assert_equal(
      "wss://socket.example.test/custom/v2/realtime?model=gpt-realtime",
      transport.open_args[:url].to_s
    )
  end

  def test_websocket_base_url_rejects_ambiguous_or_unsafe_urls
    invalid_urls = [
      "/socket",
      "ftp://socket.example.test/v1",
      "wss://user:secret@socket.example.test/v1",
      "wss://socket.example.test/v1?tenant=one",
      "wss://socket.example.test/v1#fragment"
    ]

    invalid_urls.each do |url|
      error = assert_raises(ArgumentError) { client(websocket_base_url: url) }
      assert_includes(error.message, "`websocket_base_url`")
    end
  end

  def test_connect_uses_azure_provider_authentication
    transport = FakeTransport.new(FakeSocket.new)
    azure_client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://resource.openai.azure.com",
        api_key: "azure-key"
      )
    )

    azure_client.realtime.connect(model: "deployment", transport: transport) { |_connection| nil }

    assert_equal(
      "wss://resource.openai.azure.com/openai/v1/realtime?model=deployment",
      transport.open_args[:url].to_s
    )
    assert_equal("azure-key", transport.open_args[:headers].fetch("api-key"))
    refute(transport.open_args[:headers].key?("authorization"))
  end

  def test_connect_resolves_workload_identity_before_the_handshake
    subject_token_provider =
      OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
        token_path: "/not-read-by-this-test"
      )
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp_123",
      service_account_id: "sa_123",
      provider: subject_token_provider
    )
    workload_client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: config,
      organization: "org_123",
      base_url: "https://example.com/v1"
    )
    transport = FakeTransport.new(FakeSocket.new)

    workload_client.workload_identity_auth.stub(:get_token, "exchanged-token") do
      workload_client.realtime.connect(model: "gpt-realtime", transport: transport) do |_connection|
        nil
      end
    end

    assert_equal("Bearer exchanged-token", transport.open_args[:headers].fetch("authorization"))
  end

  def test_unsupported_provider_fails_before_resolving_or_sending_credentials
    credential_requested = false
    provider = OpenAI::Providers.bedrock(
      region: "us-east-1",
      token_provider: lambda do
        credential_requested = true
        "bedrock-token"
      end
    )
    provider_client = OpenAI::Client.new(provider: provider)
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(OpenAI::Errors::Error) do
      provider_client.realtime.connect(model: "gpt-realtime", transport: transport) do |_connection|
        nil
      end
    end

    assert_includes(error.message, "not supported")
    refute(credential_requested)
    assert_nil(transport.open_args)
  end

  def test_connection_sends_typed_events_and_audio_bytes
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      send_typed_resource_events(connection)
    end

    events = socket.writes.map { JSON.parse(_1, symbolize_names: true) }
    assert_equal(
      [
        :"session.update",
        :"response.create",
        :"input_audio_buffer.append",
        :"input_audio_buffer.commit",
        :"conversation.item.create",
        :"conversation.item.create",
        :"conversation.item.create",
        :"conversation.item.create",
        :"conversation.item.create"
      ],
      events.map { _1.fetch(:type).to_sym }
    )
    assert_equal("session_update_1", events[0].fetch(:event_id))
    assert_equal("Be concise", events[0].dig(:session, :instructions))
    refute(events[0].fetch(:session).key?(:event_id))
    assert_equal("response_create_1", events[1].fetch(:event_id))
    assert_equal("Say hello", events[1].dig(:response, :instructions))
    refute(events[1].fetch(:response).key?(:event_id))
    assert_equal(Base64.strict_encode64("\x00\x01".b), events[2].fetch(:audio))
    assert_equal("item_create_1", events[4].fetch(:event_id))
    assert_equal("root", events[4].fetch(:previous_item_id))
    assert_equal("Hello", events[4].dig(:item, :content, 0, :text))
    refute(events[4].fetch(:item).key?(:previous_item_id))
    assert_equal(:input_image, events[5].dig(:item, :content, 0, :type).to_sym)
    assert_match(%r{\Adata:image/png;base64,}, events[5].dig(:item, :content, 0, :image_url))
    assert_equal(:function_call_output, events[6].fetch(:item).fetch(:type).to_sym)
    assert_equal(:mcp_approval_response, events[7].fetch(:item).fetch(:type).to_sym)
    assert(events[7].fetch(:item).fetch(:approve))
    generated_id = events[8].fetch(:item).fetch(:id)
    assert_operator(generated_id.length, :<=, 32)
    assert_match(/\Amcpa_[0-9a-f]+\z/, generated_id)
  end

  def test_standard_connection_only_exposes_standard_websocket_capabilities
    transport = FakeTransport.new(FakeSocket.new)

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      refute_respond_to(connection, :output_audio_buffer)
      refute_respond_to(connection.session, :close)
      assert_respond_to(connection.input_audio_buffer, :commit)
      assert_respond_to(connection.input_audio_buffer, :clear)
      assert_respond_to(connection.conversation, :items)
      refute_respond_to(connection.conversation, :item)
    end
  end

  def test_sideband_connection_exposes_output_audio_buffer_controls
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect_to_call(call_id: "rtc_123", transport: transport) do |connection|
      connection.output_audio_buffer.clear(event_id: "clear_1")
    end

    assert_equal(
      {"type" => "output_audio_buffer.clear", "event_id" => "clear_1"},
      JSON.parse(socket.writes.fetch(0))
    )
  end

  def test_sideband_interruption_helpers_preserve_documented_order
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect_to_call(call_id: "rtc_123", transport: transport) do |connection|
      connection.response.cancel
      connection.conversation.items.truncate(item_id: "item_1", content_index: 0, audio_end_ms: 640)
      connection.output_audio_buffer.clear
    end

    assert_equal(
      [
        "response.cancel",
        "conversation.item.truncate",
        "output_audio_buffer.clear"
      ],
      socket.writes.map { JSON.parse(_1).fetch("type") }
    )
  end

  def test_all_standard_resource_helpers_emit_typed_events
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      connection.response.cancel(response_id: "response_1", event_id: "cancel_1")
      connection.input_audio_buffer.clear(event_id: "clear_1")
      connection.conversation.items.retrieve(item_id: "item_1", event_id: "retrieve_1")
      connection.conversation.items.truncate(
        item_id: "item_1",
        content_index: 0,
        audio_end_ms: 250,
        event_id: "truncate_1"
      )
      connection.conversation.items.delete(item_id: "item_1", event_id: "delete_1")
    end

    assert_equal(
      [
        "response.cancel",
        "input_audio_buffer.clear",
        "conversation.item.retrieve",
        "conversation.item.truncate",
        "conversation.item.delete"
      ],
      socket.writes.map { JSON.parse(_1).fetch("type") }
    )
  end

  def test_connection_does_not_override_ruby_send
    transport = FakeTransport.new(FakeSocket.new)

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      assert_equal(false, connection.send(:closed?))
    end
  end

  def test_connection_rejects_an_unknown_client_event
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
        connection.send_event(type: "future.unknown.event")
      end
    end

    assert_includes(error.message, "future.unknown.event")
  end

  def test_connection_accepts_nested_string_keyed_client_events
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)
    event = JSON.parse(
      JSON.generate(
        type: "session.update",
        event_id: "event_1",
        session: {
          type: "realtime",
          audio: {output: {voice: "marin"}}
        }
      )
    )

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      connection.send_event(event)
    end

    sent = JSON.parse(socket.writes.fetch(0))
    assert_equal("session.update", sent.fetch("type"))
    assert_equal("marin", sent.dig("session", "audio", "output", "voice"))
  end

  def test_response_create_accepts_an_existing_item_reference
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      connection.response.create(
        conversation: :none,
        input: [{type: :item_reference, id: "item_12345"}]
      )
    end

    sent = JSON.parse(socket.writes.fetch(0))
    assert_equal("none", sent.dig("response", "conversation"))
    assert_equal(
      {"id" => "item_12345", "type" => "item_reference"},
      sent.dig("response", "input", 0)
    )
  end

  def test_connection_rejects_a_client_event_missing_required_fields
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
        connection.send_event(type: "conversation.item.create")
      end
    end

    assert_includes(error.message, "required fields")
  end

  def test_connect_requires_a_block
    error = assert_raises(ArgumentError) do
      client.realtime.connect(model: "gpt-realtime", transport: FakeTransport.new(FakeSocket.new))
    end

    assert_includes(error.message, "block is required")
  end

  def test_connection_each_returns_a_typed_enumerator_without_a_block
    event_data = JSON.generate(
      type: "response.output_text.delta",
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0,
      delta: "hello"
    )
    transport = FakeTransport.new(FakeSocket.new(event_data, nil))
    events = nil

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      events = connection.each.to_a
    end

    assert_equal(1, events.length)
    assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, events.first)
  end

  def test_connection_each_returns_the_connection_with_a_block
    data = JSON.generate(type: "future.event")
    transport = FakeTransport.new(FakeSocket.new(data, nil))

    client.realtime.connect(model: "gpt-realtime", transport: transport) do |connection|
      count = 0
      result = connection.each { |_event| count += 1 }

      assert_equal(1, count)
      assert_same(connection, result)
    end
  end

  def test_connection_closes_when_the_block_raises
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    assert_raises(RuntimeError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport) do |_connection|
        raise "boom"
      end
    end

    assert(socket.closed?)
  end

  def test_application_error_wins_when_cleanup_also_fails
    transport = FakeTransport.new(FailingCloseSocket.new)

    error = assert_raises(RuntimeError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport) do |_connection|
        raise "application failed"
      end
    end

    assert_equal("application failed", error.message)
  end

  def test_cleanup_error_propagates_after_a_successful_block
    transport = FakeTransport.new(FailingCloseSocket.new)

    error = assert_raises(IOError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport) { |_connection| :done }
    end

    assert_equal("close failed", error.message)
  end

  def test_malformed_server_event_raises_a_realtime_protocol_error
    transport = FakeTransport.new(FakeSocket.new("not-json"))

    error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)
    end

    assert_equal("not-json", error.data)
    assert_instance_of(JSON::ParserError, error.cause)
  end

  def test_api_error_remains_a_typed_event_in_the_stream
    transport = FakeTransport.new(
      FakeSocket.new(
        JSON.generate(
          type: "error",
          event_id: "event_1",
          error: {type: "invalid_request_error", message: "Try another value"}
        )
      )
    )

    event = client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)

    assert_instance_of(OpenAI::Realtime::RealtimeErrorEvent, event)
    assert_equal("Try another value", event.error.message)
  end

  def test_conversation_item_events_decode_message_variants_by_role
    data = JSON.generate(
      type: "conversation.item.done",
      event_id: "event_1",
      item: {
        type: "message",
        role: "user",
        content: [
          {
            type: "input_image",
            image_url: "data:image/png;base64,aW1hZ2U="
          }
        ]
      }
    )
    transport = FakeTransport.new(FakeSocket.new(data))

    event = client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)

    assert_instance_of(OpenAI::Realtime::RealtimeConversationItemUserMessage, event.item)
    assert_equal("data:image/png;base64,aW1hZ2U=", event.item.content.fetch(0).image_url)
  end

  def test_response_output_decodes_assistant_messages_by_role
    data = JSON.generate(
      type: "response.done",
      event_id: "event_1",
      response: {
        id: "response_1",
        status: "completed",
        output: [
          {
            type: "message",
            role: "assistant",
            content: [{type: "output_audio", transcript: "Hello from Ruby"}]
          }
        ]
      }
    )
    transport = FakeTransport.new(FakeSocket.new(data))

    event = client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)

    item = event.response.output.fetch(0)
    assert_instance_of(OpenAI::Realtime::RealtimeConversationItemAssistantMessage, item)
    assert_equal("Hello from Ruby", item.content.fetch(0).transcript)
  end

  def test_message_item_with_an_unknown_role_is_a_protocol_error
    data = JSON.generate(
      type: "conversation.item.done",
      event_id: "event_1",
      item: {type: "message", role: "unknown", content: []}
    )
    transport = FakeTransport.new(FakeSocket.new(data))

    error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)
    end

    assert_includes(error.cause.message, "unknown role")
  end

  def test_unknown_server_event_remains_observable
    data = JSON.generate(type: "future.unknown.event", nested: {values: ["future value"]})
    transport = FakeTransport.new(FakeSocket.new(data))

    event = client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)

    assert_instance_of(OpenAI::Realtime::UnknownServerEvent, event)
    assert_equal(:"future.unknown.event", event.type)
    assert_equal(
      {type: "future.unknown.event", nested: {values: ["future value"]}},
      event.data
    )
    assert(event.frozen?)
    assert(event.data.frozen?)
    assert(event.data.fetch(:nested).frozen?)
    assert(event.data.dig(:nested, :values).frozen?)
    assert(event.data.dig(:nested, :values, 0).frozen?)
  end

  def test_server_event_missing_required_fields_raises_a_realtime_protocol_error
    data = JSON.generate(type: "response.output_text.delta")
    transport = FakeTransport.new(FakeSocket.new(data))

    error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)
    end

    assert_equal(data, error.data)
    assert_includes(error.cause.message, "required fields")
  end

  private def send_typed_resource_events(connection)
    connection.session.update(
      type: :realtime,
      instructions: "Be concise",
      event_id: "session_update_1"
    )
    connection.response.create(instructions: "Say hello", event_id: "response_create_1")
    connection.input_audio_buffer.append_bytes("\x00\x01".b)
    connection.input_audio_buffer.commit
    connection.conversation.items.create(
      type: :message,
      role: :user,
      content: [{type: :input_text, text: "Hello"}],
      previous_item_id: "root",
      event_id: "item_create_1"
    )
    connection.conversation.items.create(
      type: :message,
      role: :user,
      content: [{type: :input_image, image_url: "data:image/png;base64,aW1hZ2U="}]
    )
    connection.conversation.items.create_function_call_output(
      call_id: "call_1",
      output: JSON.generate(temperature: 72)
    )
    connection.conversation.items.respond_to_mcp_approval(
      approval_request_id: "approval_1",
      approve: true,
      id: "approval_response_1"
    )
    connection.conversation.items.respond_to_mcp_approval(
      approval_request_id: "approval_2",
      approve: false
    )
  end
end
