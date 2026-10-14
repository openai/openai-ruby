# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Live::SessionsTest < OpenAI::Test::ResourceTest
  def test_accept_required_params
    response = @openai.live.sessions.accept("session_id", session: {model: "gpt-live-1", type: :live})

    assert_pattern do
      response => nil
    end
  end

  def test_download_recording
    response = @openai.live.sessions.download_recording("live_SQ")

    assert_pattern do
      response => StringIO
    end
  end

  def test_fork_required_params
    response = @openai.live.sessions.fork("session_id", transport: {sdp: "x", type: :webrtc})

    assert_pattern do
      response => OpenAI::Models::Live::SessionForkResponse
    end

    assert_pattern do
      response => {
          session: OpenAI::Models::Live::SessionForkResponse::Session,
          transport: OpenAI::Models::Live::SessionForkResponse::Transport
        }
    end
  end

  def test_hangup
    response = @openai.live.sessions.hangup("session_id")

    assert_pattern do
      response => nil
    end
  end

  def test_refer_required_params
    response = @openai.live.sessions.refer("session_id", target_uri: "tel:+14155550123")

    assert_pattern do
      response => nil
    end
  end

  def test_reject_required_params
    response = @openai.live.sessions.reject("session_id", status_code: 486)

    assert_pattern do
      response => nil
    end
  end
end
