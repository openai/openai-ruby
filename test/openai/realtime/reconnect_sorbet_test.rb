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
