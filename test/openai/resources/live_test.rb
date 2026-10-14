# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::LiveTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.live.create(session: {model: :"gpt-live-1"}, transport: {sdp: "x", type: :webrtc})

    assert_pattern do
      response => OpenAI::Models::Live::LiveCreateResponse
    end

    assert_pattern do
      response => {
          session: OpenAI::Models::Live::LiveCreateResponse::Session,
          transport: OpenAI::Models::Live::LiveCreateResponse::Transport
        }
    end
  end
end
