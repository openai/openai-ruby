# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::LiveWebSocketSorbetTest < Minitest::Test
  def test_live_role_connections_keep_their_shipped_protocol_types
    source = <<~RUBY
      # typed: strict
      client = OpenAI::Client.new
      client.live.sideband.connect("live_source", request_options: {timeout: 7.0}) do |connection|
        T.assert_type!(connection, OpenAI::Live::SidebandConnection)
        T.assert_type!(connection.receive, T.nilable(OpenAI::Live::Connection::ServerEvent))
        connection.send_event(OpenAI::Live::InputAudioMuteEvent.new)
      end
      client.live.forks.connect("live_stored", request_options: OpenAI::RequestOptions.new(timeout: 4.0)) do |connection|
        T.assert_type!(connection, OpenAI::Live::ForkConnection)
        T.assert_type!(connection.receive, T.nilable(OpenAI::Live::ForkConnection::ServerEvent))
        connection.send_event(OpenAI::Live::ForkSessionStartEvent.new(session: OpenAI::Live::ForkSessionConfig.new))
      end
    RUBY
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["live-websocket-roles-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      stdout, stderr, status = Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end

  def test_fork_typing_rejects_primary_startup_models
    source = <<~RUBY
      # typed: strict
      OpenAI::Client.new.live.forks.connect("live_stored") do |connection|
        primary = OpenAI::Live::SessionStartEvent.new(session: OpenAI::Live::SessionConfig.new(model: "gpt-live-1"))
        connection.send_event(primary)
      end
    RUBY
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["live-websocket-wrong-role-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      stdout, stderr, status = Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
      refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
      assert_includes("#{stdout}\n#{stderr}", "SessionStartEvent")
      assert_includes("#{stdout}\n#{stderr}", "send_event")
    end
  end

  def test_live_connect_and_internal_client_dispatch_accept_request_option_hashes
    source = <<~RUBY
      # typed: strict

      client = OpenAI::Client.new
      client.live.connect(request_options: {timeout: 7.0, extra_headers: {"X-Live" => "example"}}) do |connection|
        T.assert_type!(connection, OpenAI::Live::Connection)
        connection.send_event(type: "session.start", session: {model: "gpt-live-1"})
        raw_event = T.let({"type" => "session.start", "session" => {"model" => "gpt-live-1"}}, T::Hash[String, T.anything])
        connection.send_event(raw_event)
      end
      client.live.connect(request_options: OpenAI::RequestOptions.new(timeout: 7.0)) { |connection| connection.close }

      client.with_live_websocket_connection_request(options: {timeout: 7.0}) do |request, mark_handshake_completed|
        T.assert_type!(request, OpenAI::Internal::Transport::BaseClient::RequestInput)
        mark_handshake_completed.call
      end

      future_data = T.let({"type" => "session.future"}, T::Hash[String, T.anything])
      future = OpenAI::Live::UnknownServerEvent.new(data: future_data)
      T.assert_type!(future.data, T::Hash[T.any(String, Symbol), T.anything])
    RUBY

    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["live-websocket-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      stdout, stderr, status = Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end
end
