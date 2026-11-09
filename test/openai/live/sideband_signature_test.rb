# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::LiveSidebandSignatureTest < Minitest::Test
  def test_sideband_accepts_dtmf_models_and_existing_inputs
    stdout, stderr, status = typecheck(
      <<~RUBY
        # typed: strict
        connection = T.must(T.let(nil, T.nilable(OpenAI::Live::SidebandConnection)))
        connection.send_event(OpenAI::Live::SidebandClientEvent::TransportDtmfSend.new(event: "*"))
        connection.send_event(OpenAI::Live::SidebandClientEvent::TransportDtmfSend.new(event: "#", event_id: nil))
        connection.send_event(OpenAI::Live::SidebandClientEvent::TransportDtmfSend.new(event: "5", event_id: "synthetic"))
        connection.send_event(OpenAI::Live::SessionCloseEvent.new)
        connection.send_event({type: "transport.dtmf.send", event: "*"})
      RUBY
    )

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_primary_and_fork_reject_sideband_dtmf_models
    ["Connection", "ForkConnection"].each do |connection_class|
      stdout, stderr, status = typecheck(
        <<~RUBY
          # typed: strict
          connection = T.must(T.let(nil, T.nilable(OpenAI::Live::#{connection_class})))
          connection.send_event(OpenAI::Live::SidebandClientEvent::TransportDtmfSend.new(event: "*"))
        RUBY
      )

      refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
      assert_includes("#{stdout}\n#{stderr}", "Expected")
      assert_includes("#{stdout}\n#{stderr}", "TransportDtmfSend")
    end
  end

  private def typecheck(source)
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["live-sideband-signature", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
    end
  end
end
