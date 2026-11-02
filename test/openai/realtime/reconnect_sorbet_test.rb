# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::RealtimeReconnectSorbetTest < Minitest::Test
  def test_reconnect_options_and_connection_queue_methods_are_typed
    source = <<~RUBY
      # typed: strict
      client = OpenAI::Client.new(api_key: "test-key")
      callback = T.let(-> (connection) {
        connection.session.update(type: :realtime)
        connection.flush_pending
      }, T.proc.params(connection: OpenAI::Realtime::Connection).void)
      client.realtime.connect(model: "test-model", reconnect: true,
        max_reconnect_attempts: 3, max_queue_bytes: 4096, on_reconnected: callback) do |connection|
        T.assert_type!(connection.reconnecting?, T::Boolean)
        T.assert_type!(connection.pending_messages, T::Array[String])
        T.assert_type!(connection.take_pending_messages, T::Array[String])
        connection.flush_pending
      end
    RUBY
    output, status = typecheck(source)
    assert_predicate(status, :success?, output)
  end

  def test_reconnect_rejects_a_non_boolean_in_shipped_types
    output, status = typecheck(
      <<~RUBY
        # typed: strict
        client = OpenAI::Client.new(api_key: "test-key")
        client.realtime.connect(model: "test-model", reconnect: "yes") { |_connection| nil }
      RUBY
    )
    refute_predicate(status, :success?)
    assert_includes(output, "Expected")
  end

  def test_selected_recovery_roles_keep_typed_facades_and_before_attempt_decisions
    source = <<~RUBY
      # typed: strict
      client = OpenAI::Client.new(api_key: "fixture")
      before = T.let(-> (context) { nil }, T.proc.params(context: T::Hash[Symbol, T.untyped]).returns(NilClass))
      client.realtime.connect_transcription(reconnect: true, on_reconnecting: before) do |connection|
        T.assert_type!(connection, OpenAI::Realtime::Connection)
        T.assert_type!(connection.pending_messages, T::Array[String])
      end
      client.realtime.connect_to_call(call_id: "call_fixture", reconnect: true, on_reconnecting: before) do |connection|
        connection.output_audio_buffer.clear
        T.assert_type!(connection.reconnecting?, T::Boolean)
      end
      client.realtime.translations.connect(query: {model: "synthetic-fixture-model"}, reconnect: true, on_reconnecting: before) do |connection|
        T.assert_type!(connection, OpenAI::Realtime::TranslationSocketConnection)
        connection.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
        T.assert_type!(connection.take_pending_messages, T::Array[String])
      end
      client.live.connect(reconnect: true, on_reconnecting: before) do |connection|
        T.assert_type!(connection, OpenAI::Live::Connection)
        T.assert_type!(connection.pending_messages, T::Array[String])
      end
      client.live.sideband.connect("live_fixture", reconnect: true, on_reconnecting: before) do |connection|
        T.assert_type!(connection, OpenAI::Live::SidebandConnection)
        connection.flush_pending
      end
      consent = T.let(-> (context) { {open_new_fork_transport: true} },
        T.proc.params(context: T::Hash[Symbol, T.untyped]).returns(T::Hash[Symbol, T.untyped]))
      client.live.forks.connect("stored_fixture", reconnect: true, on_reconnecting: consent) do |connection|
        T.assert_type!(connection, OpenAI::Live::ForkConnection)
        T.assert_type!(connection.reconnecting?, T::Boolean)
      end
    RUBY
    output, status = typecheck(source)
    assert_predicate(status, :success?, output)
  end

  def test_before_attempt_decisions_reject_wrong_return_types_in_shipped_signatures
    output, status = typecheck(
      <<~RUBY
        # typed: strict
        client = OpenAI::Client.new(api_key: "fixture")
        client.live.connect(reconnect: true, on_reconnecting: -> (context) { "wrong" }) { |_connection| nil }
      RUBY
    )
    refute_predicate(status, :success?)
    assert_includes(output, "Expected")
  end

  private def typecheck(source)
    Tempfile.create(["realtime-reconnect-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture2e(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "typecheck",
        file.path,
        chdir: File.expand_path("../../..", __dir__)
      )
    end
  end
end
