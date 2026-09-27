# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::LiveWebSocketSorbetTest < Minitest::Test
  def test_live_connect_and_internal_client_dispatch_accept_request_option_hashes
    source = <<~RUBY
      # typed: strict

      client = OpenAI::Client.new
      client.live.connect(request_options: {timeout: 7.0, extra_headers: {"X-Live" => "example"}}) do |connection|
        T.assert_type!(connection, OpenAI::Live::Connection)
        connection.send_event(type: "session.start", session: {model: "gpt-live-1"})
      end
      client.live.connect(request_options: OpenAI::RequestOptions.new(timeout: 7.0)) { |connection| connection.close }

      client.with_live_websocket_connection_request(options: {timeout: 7.0}) do |request, mark_handshake_completed|
        T.assert_type!(request, OpenAI::Internal::Transport::BaseClient::RequestInput)
        mark_handshake_completed.call
      end
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
