# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::ResponsesWebSocketSorbetTest < Minitest::Test
  def test_shipped_rbi_types_responses_websocket_helpers
    source = <<~RUBY
      # typed: strict

      connection = T.must(T.let(nil, T.nilable(OpenAI::Responses::Connection)))

      connection.response.create(
        model: "gpt-5.2",
        input: [OpenAI::Responses::EasyInputMessage.new(role: :user, content: "hello")],
        stream_id: "turn_1"
      )

      event = connection.receive
      T.assert_type!(
        event,
        T.nilable(
          T.any(
            OpenAI::Responses::ResponsesServerEvent::Variants,
            OpenAI::Responses::UnknownServerEvent
          )
        )
      )
    RUBY

    stdout, stderr, status = typecheck(source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_rejects_wrong_known_response_create_type
    source = <<~RUBY
      # typed: strict

      connection = T.must(T.let(nil, T.nilable(OpenAI::Responses::Connection)))
      connection.response.create(model: 123)
    RUBY

    stdout, stderr, status = typecheck(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "Expected")
  end

  private def typecheck(source)
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["responses-websocket-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "typecheck",
        file.path,
        chdir: root
      )
    end
  end
end
