# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::WebSocketBindingSorbetTest < Minitest::Test
  def test_generic_connection_supports_enumerator_and_enumerable_methods
    source = <<~RUBY
      # typed: strict
      connection = T.let(T.unsafe(nil), OpenAI::WebSocket::TypedConnection)
      connection.each
      connection.each { |event| event }
      connection.map { |event| event }
    RUBY
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["websocket-binding-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      stdout, stderr, status = Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end
end
