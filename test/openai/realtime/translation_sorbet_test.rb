# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::RealtimeTranslationSorbetTest < Minitest::Test
  def test_translation_types_preserve_exact_generated_variants_and_raw_event_input
    source = <<~RUBY
      # typed: strict
      client = OpenAI::Client.new
      result = client.realtime.connect_translation(
        model: "gpt-realtime-translate", request_options: {timeout: 7.0, extra_headers: {"X-Translation" => "example"}}
      ) do |connection|
        T.assert_type!(connection, OpenAI::Realtime::TranslationConnection)
        T.assert_type!(connection.receive, T.nilable(OpenAI::Realtime::TranslationConnection::ServerEvent))
        connection.send_event(OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent.new(audio: "AA=="))
        connection.send_event(type: "session.close")
        raw = T.let({"type" => "session.close"}, T::Hash[String, T.anything])
        connection.send_event(raw)
        :finished
      end
      T.assert_type!(result, Symbol)
      client.with_translation_connection_request(model: "gpt-realtime-translate", options: {timeout: 7.0}) do |request, marker|
        T.assert_type!(request, OpenAI::Internal::Transport::BaseClient::RequestInput)
        marker.call
      end
    RUBY
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["translation-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      stdout, stderr, status = Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end
end
