# frozen_string_literal: true

require_relative "examples_test_case"
require_relative "../../../examples/realtime/function_calling"
require_relative "../../../examples/realtime/image_input"

class OpenAI::Test::RealtimeInputAndToolsExamplesTest < OpenAI::Test::RealtimeExamplesTestCase
  def test_image_input_example_sends_a_png_data_uri_and_requires_text_output
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseTextDeltaEvent.new(
          content_index: 0,
          delta: "A ruby gemstone.",
          event_id: "event_1",
          item_id: "item_1",
          output_index: 0,
          response_id: "response_1"
        ),
        completed_response_event
      ]
    )
    realtime = RecordingRealtime.new(connection)

    Tempfile.create(["realtime-image", ".png"]) do |image|
      image.binmode
      image.write("\x89PNG\r\n\x1A\nimage".b)
      image.flush

      OpenAI::Examples::Realtime::ImageInput.run(
        client: RecordingClient.new(realtime: realtime),
        model: "gpt-realtime-2.1",
        image_path: image.path,
        prompt: "What is shown?",
        output: StringIO.new
      )
    end

    assert_equal(
      {type: :realtime, output_modalities: [:text]},
      connection.session.updates.fetch(0)
    )
    item = connection.conversation.items.calls.fetch(0)
    assert_equal(:message, item.fetch(:type))
    assert_equal(:user, item.fetch(:role))
    content = item.fetch(:content)
    assert_match(%r{\Adata:image/png;base64,}, content.fetch(0).fetch(:image_url))
    assert_equal({type: :input_text, text: "What is shown?"}, content.fetch(1))
    assert_equal([{}], connection.response.calls)
  end

  def test_image_input_example_rejects_an_unsupported_file_format
    realtime = RecordingRealtime.new(RecordingConnection.new)

    Tempfile.create("realtime-image") do |image|
      image.write("not an image")
      image.flush

      error = assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::ImageInput.run(
          client: RecordingClient.new(realtime: realtime),
          model: "gpt-realtime-2.1",
          image_path: image.path,
          prompt: "What is shown?",
          output: StringIO.new
        )
      end

      assert_equal("Realtime image input must be a PNG or JPEG file", error.message)
    end

    assert_empty(realtime.connections)
  end

  def test_function_calling_example_executes_the_tool_and_requests_a_final_answer
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent.new(
          arguments: JSON.generate(city: "Paris"),
          call_id: "call_1",
          event_id: "event_1",
          item_id: "item_1",
          name: "lookup_weather",
          output_index: 0,
          response_id: "response_1"
        ),
        completed_response_event,
        OpenAI::Realtime::ResponseTextDeltaEvent.new(
          content_index: 0,
          delta: "It is 18 C in Paris.",
          event_id: "event_2",
          item_id: "item_2",
          output_index: 0,
          response_id: "response_2"
        ),
        completed_response_event
      ]
    )
    realtime = RecordingRealtime.new(connection)

    OpenAI::Examples::Realtime::FunctionCalling.run(
      client: RecordingClient.new(realtime: realtime),
      model: "gpt-realtime-2.1",
      prompt: "What is the weather in Paris?",
      output: StringIO.new
    )

    update = connection.session.updates.fetch(0)
    assert_equal({type: :function, name: "lookup_weather"}, update.fetch(:tool_choice))
    assert_equal(false, update.fetch(:parallel_tool_calls))
    assert_equal([{}], connection.response.calls.take(1))
    assert_equal({tool_choice: :none}, connection.response.calls.fetch(1))
    assert_equal(
      {
        call_id: "call_1",
        output: JSON.generate(city: "Paris", temperature_c: 18, conditions: "clear")
      },
      connection.conversation.items.calls.fetch(1)
    )
  end

  def test_function_calling_example_rejects_eof_before_the_final_answer
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent.new(
          arguments: JSON.generate(city: "Paris"),
          call_id: "call_1",
          event_id: "event_1",
          item_id: "item_1",
          name: "lookup_weather",
          output_index: 0,
          response_id: "response_1"
        ),
        completed_response_event
      ]
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::FunctionCalling.run_session(
        connection,
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before response.done", error.message)
    assert_equal({tool_choice: :none}, connection.response.calls.fetch(0))
  end
end
