# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Realtime::CallsTest < OpenAI::Test::ResourceTest
  def test_accept_required_params
    response = @openai.realtime.calls.accept("call_id", type: :realtime)

    assert_pattern do
      response => nil
    end
  end

  def test_hangup
    response = @openai.realtime.calls.hangup("call_id")

    assert_pattern do
      response => nil
    end
  end

  def test_refer_required_params
    response = @openai.realtime.calls.refer("call_id", target_uri: "tel:+14155550123")

    assert_pattern do
      response => nil
    end
  end

  def test_reject
    response = @openai.realtime.calls.reject("call_id")

    assert_pattern do
      response => nil
    end
  end
end
