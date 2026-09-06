# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::RealtimeConnectionMetadataKeysTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  def test_metadata_overrides_do_not_leave_json_keys_in_nested_payloads
    session_params = JSON.parse(
      "{\"event_id\":\"template-session\",\"instructions\":\"synthetic session instructions\"}"
    )
    response_params = JSON.parse(
      "{\"event_id\":\"template-response\",\"instructions\":\"synthetic response instructions\"}"
    )
    item_params = JSON.parse(
      "{\"event_id\":\"template-item\",\"previous_item_id\":\"template-previous\"," \
        "\"type\":\"message\",\"role\":\"user\",\"content\":[{\"type\":\"input_text\",\"text\":\"Hello\"}]}"
    )
    original_session_params = session_params.dup
    original_response_params = response_params.dup
    original_item_params = Marshal.load(Marshal.dump(item_params))
    socket = FakeSocket.new

    client.realtime.connect(model: "gpt-realtime-2.1", transport: FakeTransport.new(socket)) do |connection|
      connection.session.update(**session_params, event_id: nil)
      connection.response.create(**response_params, event_id: "caller-response")
      connection.conversation.items.create(
        **item_params,
        event_id: "caller-item",
        previous_item_id: "caller-previous"
      )
    end

    session_event, response_event, item_event = socket.writes.map { JSON.parse(_1) }
    assert_equal(
      {
        "type" => "session.update",
        "session" => {
          "type" => "realtime",
          "instructions" => "synthetic session instructions"
        }
      },
      session_event
    )
    assert_equal(
      {
        "type" => "response.create",
        "event_id" => "caller-response",
        "response" => {"instructions" => "synthetic response instructions"}
      },
      response_event
    )
    assert_equal(
      {
        "type" => "conversation.item.create",
        "event_id" => "caller-item",
        "previous_item_id" => "caller-previous",
        "item" => {
          "type" => "message",
          "role" => "user",
          "content" => [{"type" => "input_text", "text" => "Hello"}]
        }
      },
      item_event
    )
    assert_equal(original_session_params, session_params)
    assert_equal(original_response_params, response_params)
    assert_equal(original_item_params, item_params)
  end

  def test_single_form_metadata_keys_still_emit_only_at_the_envelope
    socket = FakeSocket.new
    string_params = JSON.parse("{\"event_id\":\"json-event\",\"instructions\":\"from JSON\"}")

    client.realtime.connect(model: "gpt-realtime-2.1", transport: FakeTransport.new(socket)) do |connection|
      connection.response.create(**string_params)
      connection.response.create(instructions: "from Ruby", event_id: "ruby-event")
    end

    assert_equal(
      {
        "type" => "response.create",
        "event_id" => "json-event",
        "response" => {"instructions" => "from JSON"}
      },
      JSON.parse(socket.writes.fetch(0))
    )
    assert_equal(
      {
        "type" => "response.create",
        "event_id" => "ruby-event",
        "response" => {"instructions" => "from Ruby"}
      },
      JSON.parse(socket.writes.fetch(1))
    )
    assert_equal(
      {"event_id" => "json-event", "instructions" => "from JSON"},
      string_params
    )
  end

  def test_missing_metadata_does_not_invoke_hash_defaults
    session_params = Hash.new("default-session").merge(instructions: "session instructions")
    default_proc_keys = []
    response_params = Hash
      .new { |_params, key|
        default_proc_keys << key
        "default-#{key}"
      }
      .merge(instructions: "response instructions")
    item_params = Hash.new("default-item").merge(
      type: :message,
      role: :user,
      content: [{type: :input_text, text: "Hello"}]
    )
    socket = FakeSocket.new

    client.realtime.connect(model: "gpt-realtime-2.1", transport: FakeTransport.new(socket)) do |connection|
      connection.session.update(**session_params)
      connection.response.create(**response_params)
      connection.conversation.items.create(**item_params)
    end

    session_event, response_event, item_event = socket.writes.map { JSON.parse(_1) }
    assert_equal(
      {
        "type" => "session.update",
        "session" => {"type" => "realtime", "instructions" => "session instructions"}
      },
      session_event
    )
    assert_equal(
      {
        "type" => "response.create",
        "response" => {"instructions" => "response instructions"}
      },
      response_event
    )
    assert_equal(
      {
        "type" => "conversation.item.create",
        "item" => {
          "type" => "message",
          "role" => "user",
          "content" => [{"type" => "input_text", "text" => "Hello"}]
        }
      },
      item_event
    )
    assert_empty(default_proc_keys)
  end
end
