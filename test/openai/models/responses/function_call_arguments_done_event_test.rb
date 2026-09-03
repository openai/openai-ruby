# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::FunctionCallArgumentsDoneEventTest < Minitest::Test
  def test_websocket_done_events_allow_an_omitted_name
    payload = JSON.parse(
      "{\"type\":\"response.function_call_arguments.done\",\"arguments\":\"{}\",\"item_id\":\"fc_test\"," \
        "\"output_index\":0,\"sequence_number\":1,\"stream_id\":\"test-lane\"}",
      symbolize_names: true
    )

    [
      [
        OpenAI::Responses::ResponsesServerEvent,
        OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone
      ],
      [
        OpenAI::Beta::BetaResponsesServerEvent,
        OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone
      ]
    ].each do |union, expected_class|
      # Responses exposes WebSocket models without a socket client. Exercise the
      # same union converter used by the SDK transports.
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      event = OpenAI::Internal::Type::Converter.coerce(union, payload, state: state)

      assert_instance_of(expected_class, event)
      assert_nil(event.name)
      assert_equal("{}", event.arguments)
      assert_equal("test-lane", event.stream_id)
    end
  end
end
