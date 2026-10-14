# frozen_string_literal: true

require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/sideband"

class OpenAI::Test::RealtimeSidebandExampleTest < Minitest::Test
  def test_example_updates_an_existing_call_without_logging_customer_data
    instructions = "private customer policy"
    expected_call_id = "rtc_example_identifier"
    session = Minitest::Mock.new
    session.expect(:update, nil, type: :realtime, instructions: instructions)

    connection = Minitest::Mock.new([session_created, session_updated(instructions: instructions)])
    connection.expect(:session, session)

    realtime = Minitest::Mock.new
    realtime.expect(:connect_to_call, nil) do |call_id:, &block|
      assert_equal(expected_call_id, call_id)
      block.call(connection)
      true
    end

    client = Minitest::Mock.new
    client.expect(:realtime, realtime)
    output = StringIO.new

    OpenAI::Examples::Realtime::Sideband.run(
      client: client,
      call_id: expected_call_id,
      instructions: instructions,
      output: output
    )

    [client, realtime, connection, session].each(&:verify)
    assert_includes(output.string, "[realtime] sideband connected")
    assert_includes(output.string, "[realtime] session.created")
    assert_includes(output.string, "[realtime] session.updated")
    assert_includes(output.string, "[realtime] sideband smoke test passed")
    refute_includes(output.string, instructions)
    refute_includes(output.string, expected_call_id)
  end

  def test_example_rejects_connection_closure_before_session_update
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Sideband.stream_until_updated(
        [],
        instructions: "expected policy",
        output: StringIO.new
      )
    end

    assert_equal("Realtime sideband connection closed before session.updated.", error.message)
  end

  def test_example_keeps_service_error_details_out_of_diagnostics
    customer_data = "private customer prompt from the service"
    event = OpenAI::Realtime::RealtimeErrorEvent.new(
      event_id: "event_error",
      error: OpenAI::Realtime::RealtimeError.new(
        message: customer_data,
        type: "invalid_request_error"
      )
    )
    output = StringIO.new

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Sideband.stream_until_updated(
        [event],
        instructions: "expected policy",
        output: output
      )
    end

    assert_equal("Realtime API error.", error.message)
    refute_includes(error.message, customer_data)
    refute_includes(output.string, customer_data)
  end

  def test_example_does_not_log_unrelated_event_payloads
    customer_text = "private assistant speech"
    event = OpenAI::Realtime::ResponseTextDeltaEvent.new(
      content_index: 0,
      delta: customer_text,
      event_id: "event_delta",
      item_id: "item_1",
      output_index: 0,
      response_id: "response_1"
    )
    output = StringIO.new

    OpenAI::Examples::Realtime::Sideband.stream_until_updated(
      [event, session_updated(instructions: "expected policy")],
      instructions: "expected policy",
      output: output
    )

    assert_includes(output.string, "session.updated")
    refute_includes(output.string, customer_text)
  end

  def test_example_skips_an_unrelated_session_update_before_its_policy_is_confirmed
    output = StringIO.new

    OpenAI::Examples::Realtime::Sideband.stream_until_updated(
      [
        session_updated(instructions: "unrelated client policy"),
        session_updated(instructions: "expected server policy")
      ],
      instructions: "expected server policy",
      output: output
    )

    assert_equal("[realtime] session.updated\n", output.string)
  end

  def test_example_surfaces_an_error_after_an_unrelated_session_update
    event = OpenAI::Realtime::RealtimeErrorEvent.new(
      event_id: "event_error",
      error: OpenAI::Realtime::RealtimeError.new(
        message: "private service diagnostics",
        type: "invalid_request_error"
      )
    )
    output = StringIO.new

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Sideband.stream_until_updated(
        [session_updated(instructions: "unrelated client policy"), event],
        instructions: "expected server policy",
        output: output
      )
    end

    assert_equal("Realtime API error.", error.message)
    assert_empty(output.string)
  end

  private def session_created
    OpenAI::Realtime::SessionCreatedEvent.new(
      event_id: "event_created",
      session: {type: :realtime}
    )
  end

  private def session_updated(instructions:)
    OpenAI::Realtime::SessionUpdatedEvent.new(
      event_id: "event_updated",
      session: OpenAI::Realtime::RealtimeSessionCreateRequest.new(instructions: instructions)
    )
  end
end
