# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RealtimeConnectionTest < Minitest::Test
  class FakeSocket
    attr_reader :writes, :close_args

    def initialize(*reads)
      @reads = reads
      @writes = []
      @closed = false
      @aborted = false
    end

    def read = @reads.shift
    def write(message) = @writes << message
    def closed? = @closed

    def close(code: 1000, reason: "")
      @closed = true
      @close_args = {code: code, reason: reason}
    end

    def abort
      @closed = true
      @aborted = true
    end

    def aborted? = @aborted
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

  class MutatingEmptyQuery < Hash
    def empty?
      initially_empty = super
      self["access_token"] = "fake-late-sensitive-token"
      initially_empty
    end
  end

  def test_connect_opens_a_typed_block_scoped_connection
    socket = FakeSocket.new(text_delta("hello"))
    transport = FakeTransport.new(socket)
    event = nil

    result = client
      .realtime
      .connect(
        model: "gpt-realtime-2.1",
        request_options: {
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
    assert_equal(
      "wss://example.com/v1/realtime?model=gpt-realtime-2.1",
      transport.open_args[:url].to_s
    )
    assert_equal("Bearer test-key", transport.open_args[:headers].fetch("authorization"))
    assert_equal("trace_1", transport.open_args[:headers].fetch("x-trace-id"))
    assert_equal(12.0, transport.open_args[:timeout])
    assert_equal({max_frame_size: 1_024}, transport.open_args[:options])
    assert_predicate(socket, :closed?)
  end

  def test_connect_transcription_uses_the_dedicated_handshake_intent
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    result = client.realtime.connect_transcription(transport: transport) do |connection|
      assert_instance_of(OpenAI::Realtime::Connection, connection)
      :block_result
    end

    assert_equal(:block_result, result)
    assert_equal(
      "wss://example.com/v1/realtime?intent=transcription",
      transport.open_args.fetch(:url).to_s
    )
    assert_predicate(socket, :closed?)
  end

  def test_connect_transcription_requires_a_block
    error = assert_raises(ArgumentError) do
      client.realtime.connect_transcription
    end

    assert_equal("A block is required to open a Realtime WebSocket.", error.message)
  end

  def test_connection_manager_snapshots_handshake_query_strings
    model = +"gpt-realtime-2.1"
    transport = FakeTransport.new(FakeSocket.new)
    manager = OpenAI::Realtime::ConnectionManager.new(
      client: client,
      query: {"model" => model},
      websocket_base_url: nil,
      transport: transport,
      request_options: nil,
      transport_options: {}
    )

    model.replace("attacker-controlled-model")
    manager.open { |_connection| nil }

    assert_equal(
      "wss://example.com/v1/realtime?model=gpt-realtime-2.1",
      transport.open_args.fetch(:url).to_s
    )
  end

  def test_proxy_authorization_never_reaches_the_origin_handshake
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)
    configured = client(default_headers: {"Proxy-Authorization" => "Basic configured-secret"})

    configured
      .realtime
      .connect(
        model: "gpt-realtime-2.1",
        request_options: {extra_headers: {"proxy-authorization" => "Basic request-secret"}},
        transport: transport
      ) { |_connection| nil }

    refute(transport.open_args.fetch(:headers).key?("proxy-authorization"))
  end

  def test_connect_rejects_transport_options_that_override_authenticated_inputs
    reserved = %i[url headers timeout hostname port scheme ssl_context protocol alpn_protocols]

    reserved.product([false, true]).each do |key, stringify|
      transport_key = stringify ? key.to_s : key
      transport = FakeTransport.new(FakeSocket.new)
      error = assert_raises(ArgumentError) do
        client
          .realtime
          .connect(
            model: "gpt-realtime-2.1",
            transport: transport,
            transport_options: {transport_key => Object.new}
          ) { |_connection| nil }
      end

      assert_includes(error.message, transport_key.inspect)
      assert_nil(transport.open_args)
    end
  end

  def test_explicit_websocket_base_url_is_validated_and_immutable
    transport = FakeTransport.new(FakeSocket.new)
    endpoint = +"wss://socket.example.test/custom/v2"

    client
      .realtime
      .connect(
        model: "gpt-realtime-2.1",
        websocket_base_url: endpoint,
        transport: transport
      ) do |_connection|
        endpoint.replace("wss://attacker.invalid/v1")
        nil
      end

    assert_equal(
      "wss://socket.example.test/custom/v2/realtime?model=gpt-realtime-2.1",
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
      error = assert_raises(ArgumentError) do
        client
          .realtime
          .connect(
            model: "gpt-realtime-2.1",
            websocket_base_url: url,
            transport: FakeTransport.new(FakeSocket.new)
          ) { |_connection| nil }
      end

      assert_includes(error.message, "`websocket_base_url`")
    end
  end

  def test_azure_provider_uses_azure_endpoint_and_authentication
    transport = FakeTransport.new(FakeSocket.new)
    azure = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://resource.openai.azure.com",
        api_key: "azure-key"
      )
    )

    azure.realtime.connect(model: "deployment", transport: transport) { |_connection| nil }

    assert_equal(
      "wss://resource.openai.azure.com/openai/v1/realtime?model=deployment",
      transport.open_args[:url].to_s
    )
    assert_equal("azure-key", transport.open_args[:headers].fetch("api-key"))
    refute(transport.open_args[:headers].key?("authorization"))
  end

  def test_provider_configured_client_rejects_a_websocket_endpoint_override
    azure = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://resource.openai.azure.com",
        api_key: "azure-key"
      )
    )
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      azure
        .realtime
        .connect(
          model: "deployment",
          websocket_base_url: "wss://socket.example.test/v1",
          transport: transport
        ) { |_connection| nil }
    end

    assert_includes(error.message, "cannot be combined with `provider`")
    assert_nil(transport.open_args)
  end

  def test_unsupported_provider_fails_before_requesting_credentials
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
      provider_client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |_connection|
        nil
      end
    end

    assert_includes(error.message, "not supported")
    refute(credential_requested)
    assert_nil(transport.open_args)
  end

  def test_ruby_native_resource_helpers_add_wire_envelopes
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |connection|
      connection.session.update(
        type: :realtime,
        output_modalities: [:text],
        event_id: "session_1"
      )
      connection.conversation.items.create(
        type: :message,
        role: :user,
        content: [{type: :input_text, text: "Hello"}],
        event_id: "item_1"
      )
      connection.response.create(instructions: "Be concise", event_id: "response_1")
      connection.response.cancel(response_id: "response_id", event_id: "cancel_1")
      connection.conversation.items.retrieve(item_id: "item_id", event_id: "retrieve_1")
      connection.conversation.items.delete(item_id: "item_id", event_id: "delete_1")
    end

    events = socket.writes.map { JSON.parse(_1, symbolize_names: true) }
    assert_equal(
      [
        :"session.update",
        :"conversation.item.create",
        :"response.create",
        :"response.cancel",
        :"conversation.item.retrieve",
        :"conversation.item.delete"
      ],
      events.map { _1.fetch(:type).to_sym }
    )
    assert_equal("session_1", events.fetch(0).fetch(:event_id))
    assert_equal([:text], events.fetch(0).dig(:session, :output_modalities).map(&:to_sym))
    refute(events.fetch(0).fetch(:session).key?(:event_id))
    assert_equal("Hello", events.fetch(1).dig(:item, :content, 0, :text))
    assert_equal("Be concise", events.fetch(2).dig(:response, :instructions))
  end

  def test_input_audio_buffer_helper_encodes_bytes_and_preserves_base64_input
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect_transcription(transport: transport) do |connection|
      connection.input_audio_buffer.append(audio: "YWxyZWFkeS1lbmNvZGVk", event_id: "encoded_1")
      connection.input_audio_buffer.append_bytes("\x00\xFF".b, event_id: "bytes_1")
      connection.input_audio_buffer.commit(event_id: "commit_1")
      connection.input_audio_buffer.clear(event_id: "clear_1")
    end

    events = socket.writes.map { JSON.parse(_1, symbolize_names: true) }
    assert_equal(
      [
        :"input_audio_buffer.append",
        :"input_audio_buffer.append",
        :"input_audio_buffer.commit",
        :"input_audio_buffer.clear"
      ],
      events.map { _1.fetch(:type).to_sym }
    )
    assert_equal("YWxyZWFkeS1lbmNvZGVk", events.fetch(0).fetch(:audio))
    assert_equal("AP8=", events.fetch(1).fetch(:audio))
    assert_equal(%w[encoded_1 bytes_1 commit_1 clear_1], events.map { _1.fetch(:event_id) })
  end

  def test_transcription_session_and_events_use_generated_types
    socket = FakeSocket.new(
      JSON.generate(
        type: "conversation.item.input_audio_transcription.delta",
        event_id: "event_delta",
        item_id: "item_1",
        content_index: 0,
        delta: "Hello"
      ),
      JSON.generate(
        type: "conversation.item.input_audio_transcription.completed",
        event_id: "event_completed",
        item_id: "item_1",
        content_index: 0,
        transcript: "Hello from Ruby.",
        usage: {type: "tokens", input_tokens: 1, output_tokens: 1, total_tokens: 2}
      )
    )
    transport = FakeTransport.new(socket)

    events = client.realtime.connect_transcription(transport: transport) do |connection|
      connection.session.update(
        type: :transcription,
        audio: {
          input: {
            format: {type: :"audio/pcm", rate: 24_000},
            transcription: {model: :"gpt-live-transcribe"},
            turn_detection: nil
          }
        }
      )
      [connection.receive, connection.receive]
    end

    session_event = JSON.parse(socket.writes.fetch(0), symbolize_names: true)
    assert_equal(
      "wss://example.com/v1/realtime?intent=transcription",
      transport.open_args.fetch(:url).to_s
    )
    assert_equal(:transcription, session_event.dig(:session, :type).to_sym)
    assert_equal(24_000, session_event.dig(:session, :audio, :input, :format, :rate))
    assert_instance_of(OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent, events.fetch(0))
    assert_instance_of(
      OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent,
      events.fetch(1)
    )
    assert_equal("item_1", events.fetch(0).item_id)
    assert_equal("item_1", events.fetch(1).item_id)
  end

  def test_send_event_validates_the_generated_client_event_union
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |connection|
      connection.send_event(
        "type" => "session.update",
        "event_id" => "event_1",
        "session" => {"type" => "realtime", "output_modalities" => ["text"]}
      )
    end

    assert_equal("session.update", JSON.parse(socket.writes.fetch(0)).fetch("type"))
  end

  def test_send_event_rejects_unknown_or_incomplete_client_events
    transport = FakeTransport.new(FakeSocket.new)

    unknown = assert_raises(ArgumentError) do
      client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |connection|
        connection.send_event(type: "future.unknown.event")
      end
    end

    assert_equal("Invalid Realtime client event.", unknown.message)
    assert_includes(unknown.cause.message, "future.unknown.event")

    incomplete = assert_raises(ArgumentError) do
      client.realtime.connect(
        model: "gpt-realtime-2.1",
        transport: FakeTransport.new(FakeSocket.new)
      ) do |connection|
        connection.send_event(type: "conversation.item.create")
      end
    end

    assert_equal("Invalid Realtime client event.", incomplete.message)
    assert_includes(incomplete.cause.message, "required fields")
  end

  def test_send_event_keeps_nested_client_values_out_of_the_public_error_message
    authorization = "secret-mcp-authorization"
    description = "private customer tool description"
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |connection|
        connection.send_event(
          type: "response.create",
          response: {
            tools: [
              {
                type: "unknown_tool_type",
                authorization: authorization,
                server_description: description
              }
            ]
          }
        )
      end
    end

    assert_equal("Invalid Realtime client event.", error.message)
    assert_instance_of(ArgumentError, error.cause)
    refute_equal(error.message, error.cause.message)
    refute_includes(error.message, authorization)
    refute_includes(error.message, description)
  end

  def test_item_reference_inputs_require_a_non_nil_id
    [{type: :item_reference}, {type: :item_reference, id: nil}].each do |item|
      socket = FakeSocket.new

      error = assert_raises(ArgumentError) do
        client.realtime.connect(
          model: "gpt-realtime-2.1",
          transport: FakeTransport.new(socket)
        ) do |connection|
          connection.response.create(input: [item])
        end
      end

      assert_equal("Invalid Realtime client event.", error.message)
      assert_includes(error.cause.message, "item_reference")
      assert_includes(error.cause.message, "non-nil `id`")
      assert_empty(socket.writes)
    end
  end

  def test_unknown_server_event_remains_observable_and_immutable
    data = JSON.generate(type: "future.unknown.event", nested: {values: ["future value"]})
    transport = FakeTransport.new(FakeSocket.new(data))

    event = client.realtime.connect(model: "gpt-realtime-2.1", transport: transport, &:receive)

    assert_instance_of(OpenAI::Realtime::UnknownServerEvent, event)
    assert_equal(:"future.unknown.event", event.type)
    assert_equal({type: "future.unknown.event", nested: {values: ["future value"]}}, event.to_h)
    assert_predicate(event, :frozen?)
    assert_predicate(event.data, :frozen?)
    assert_predicate(event.data.dig(:nested, :values), :frozen?)
  end

  def test_generated_message_union_uses_the_message_role
    data = JSON.generate(
      type: "conversation.item.done",
      event_id: "event_1",
      previous_item_id: nil,
      item: {
        type: "message",
        role: "user",
        content: [{type: "input_text", text: "Hello"}]
      }
    )
    transport = FakeTransport.new(FakeSocket.new(data))

    event = client.realtime.connect(model: "gpt-realtime-2.1", transport: transport, &:receive)

    assert_instance_of(OpenAI::Realtime::ConversationItemDone, event)
    assert_instance_of(OpenAI::Realtime::RealtimeConversationItemUserMessage, event.item)
    assert_equal("Hello", event.item.content.fetch(0).text)
  end

  def test_malformed_or_incomplete_server_events_raise_protocol_errors
    malformed = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      client.realtime.connect(
        model: "gpt-realtime-2.1",
        transport: FakeTransport.new(FakeSocket.new("not-json")),
        &:receive
      )
    end

    assert_instance_of(JSON::ParserError, malformed.cause)

    data = JSON.generate(type: "response.output_text.delta")
    incomplete = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      client.realtime.connect(
        model: "gpt-realtime-2.1",
        transport: FakeTransport.new(FakeSocket.new(data)),
        &:receive
      )
    end

    assert_includes(incomplete.cause.message, "required fields")
  end

  def test_protocol_errors_keep_customer_payloads_out_of_the_public_message
    customer_text = "private customer text"
    data = JSON.generate(
      type: "response.output_text.delta",
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0,
      delta: {text: customer_text}
    )

    error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      client.realtime.connect(
        model: "gpt-realtime-2.1",
        transport: FakeTransport.new(FakeSocket.new(data)),
        &:receive
      )
    end

    assert_equal("Invalid Realtime WebSocket event.", error.message)
    assert_equal(data, error.data)
    assert_instance_of(ArgumentError, error.cause)
    assert_includes(error.data, customer_text)
    refute_includes(error.message, customer_text)
  end

  def test_connect_rejects_nonzero_max_retries_before_opening_the_transport
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      client
        .realtime
        .connect(
          model: "gpt-realtime-2.1",
          request_options: {max_retries: 1},
          transport: transport
        ) { |_connection| nil }
    end

    assert_equal(
      "`request_options[:max_retries]` is not supported for Realtime WebSocket connections; " \
        "use 0 or omit it",
      error.message
    )
    assert_nil(transport.open_args)
  end

  def test_connect_rejects_nonempty_extra_query_before_opening_the_transport
    options = [
      {extra_query: {"access_token" => "fake-sensitive-token"}},
      OpenAI::RequestOptions.new(extra_query: {"signature" => "fake-sensitive-signature"})
    ]

    options.each do |request_options|
      transport = FakeTransport.new(FakeSocket.new)
      error = assert_raises(ArgumentError) do
        client
          .realtime
          .connect(
            model: "gpt-realtime-2.1",
            request_options: request_options,
            transport: transport
          ) { |_connection| nil }
      end

      assert_equal(
        "`request_options[:extra_query]` is not supported for Realtime WebSocket connections; " \
          "omit it",
        error.message
      )
      assert_nil(transport.open_args)
    end
  end

  def test_connect_allows_zero_max_retries
    transport = FakeTransport.new(FakeSocket.new)

    client
      .realtime
      .connect(
        model: "gpt-realtime-2.1",
        request_options: {max_retries: 0, extra_query: {}},
        transport: transport
      ) { |_connection| nil }

    refute_nil(transport.open_args)
  end

  def test_empty_extra_query_cannot_inject_data_during_validation
    transport = FakeTransport.new(FakeSocket.new)

    client
      .realtime
      .connect(
        model: "gpt-realtime-2.1",
        request_options: {extra_query: MutatingEmptyQuery.new},
        transport: transport
      ) { |_connection| nil }

    assert_equal(
      "wss://example.com/v1/realtime?model=gpt-realtime-2.1",
      transport.open_args.fetch(:url).to_s
    )
  end

  def test_each_is_enumerable_and_returns_the_connection
    transport = FakeTransport.new(FakeSocket.new(text_delta("hello"), nil))

    client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |connection|
      assert_instance_of(Enumerator, connection.each)
      events = []
      result = connection.each { |event| events << event }
      assert_same(connection, result)
      assert_equal(["hello"], events.map(&:delta))
    end
  end

  def test_send_raw_requires_valid_utf8_text
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)

    client.realtime.connect(model: "gpt-realtime-2.1", transport: transport) do |connection|
      connection.send_raw(JSON.generate(type: "session.update").b)
      assert_raises(ArgumentError) { connection.send_raw("\xFF".b) }
    end

    assert_equal(Encoding::UTF_8, socket.writes.fetch(0).encoding)
  end

  def test_block_exit_closes_normally_and_exceptional_exit_aborts
    normal_socket = FakeSocket.new
    client.realtime.connect(
      model: "gpt-realtime-2.1",
      transport: FakeTransport.new(normal_socket)
    ) { |_connection| :done }
    assert_equal({code: 1000, reason: ""}, normal_socket.close_args)
    refute_predicate(normal_socket, :aborted?)

    exceptional_socket = FakeSocket.new
    error = assert_raises(RuntimeError) do
      client
        .realtime
        .connect(
          model: "gpt-realtime-2.1",
          transport: FakeTransport.new(exceptional_socket)
        ) { |_connection| raise "application failed" }
    end

    assert_equal("application failed", error.message)
    assert_predicate(exceptional_socket, :aborted?)
    assert_nil(exceptional_socket.close_args)
  end

  def test_cleanup_errors_propagate_only_after_successful_blocks
    cleanup_error = assert_raises(IOError) do
      client
        .realtime
        .connect(
          model: "gpt-realtime-2.1",
          transport: FakeTransport.new(FailingCloseSocket.new)
        ) { |_connection| :done }
    end

    assert_equal("close failed", cleanup_error.message)

    application_error = assert_raises(RuntimeError) do
      client
        .realtime
        .connect(
          model: "gpt-realtime-2.1",
          transport: FakeTransport.new(FailingCloseSocket.new)
        ) { |_connection| raise "application failed" }
    end

    assert_equal("application failed", application_error.message)
  end

  def test_connect_requires_a_block
    error = assert_raises(ArgumentError) do
      client.realtime.connect(
        model: "gpt-realtime-2.1",
        transport: FakeTransport.new(FakeSocket.new)
      )
    end

    assert_includes(error.message, "block is required")
  end

  private def client(**options)
    OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      **options
    )
  end

  private def text_delta(delta)
    JSON.generate(
      type: "response.output_text.delta",
      event_id: "event_1",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0,
      delta: delta
    )
  end
end
