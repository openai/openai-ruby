# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Models::Responses::ResponseTest < Minitest::Test
  def test_output_text_with_single_message
    response = build_response(
      output: [
        message_output(text: "Hello, world!")
      ]
    )

    assert_equal("Hello, world!", response.output_text)
  end

  def test_output_text_with_multiple_messages
    response = build_response(
      output: [
        message_output(text: "First part. "),
        message_output(text: "Second part.")
      ]
    )

    assert_equal("First part. Second part.", response.output_text)
  end

  def test_output_text_with_multiple_content_blocks
    response = build_response(
      output: [
        message_output(
          content: [
            text_content("Part A"),
            text_content(" and Part B")
          ]
        )
      ]
    )

    assert_equal("Part A and Part B", response.output_text)
  end

  def test_output_text_with_no_messages
    response = build_response(output: [])

    assert_equal("", response.output_text)
  end

  def test_output_text_with_non_message_output_items
    response = build_response(
      output: [
        function_call_output("test_function", "{}"),
        message_output(text: "After tool call")
      ]
    )

    assert_equal("After tool call", response.output_text)
  end

  def test_output_text_with_refusal_content
    response = build_response(
      output: [
        message_output(
          content: [
            refusal_content("I cannot do that"),
            text_content("But I can help with this")
          ]
        )
      ]
    )

    assert_equal("But I can help with this", response.output_text)
  end

  def test_output_text_with_empty_text
    response = build_response(
      output: [message_output(text: "")]
    )

    assert_equal("", response.output_text)
  end

  def test_output_text_with_mixed_empty_and_non_empty_text
    response = build_response(
      output: [
        message_output(
          content: [
            text_content(""),
            text_content("Non-empty"),
            text_content("")
          ]
        )
      ]
    )

    assert_equal("Non-empty", response.output_text)
  end

  private

  def build_response(output:)
    OpenAI::Responses::Response.new(
      id: "resp_test",
      created_at: Time.now.to_f,
      model: "gpt-4o",
      object: :response,
      parallel_tool_calls: false,
      tool_choice: :auto,
      tools: [],
      output: output
    )
  end

  def message_output(text: nil, content: nil)
    content ||= [text_content(text)] if text

    OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_#{SecureRandom.hex(4)}",
      status: :completed,
      content: content
    )
  end

  def text_content(text)
    OpenAI::Responses::ResponseOutputText.new(
      text: text,
      annotations: []
    )
  end

  def refusal_content(refusal)
    OpenAI::Responses::ResponseOutputRefusal.new(
      refusal: refusal
    )
  end

  def function_call_output(name, arguments)
    OpenAI::Responses::ResponseFunctionToolCall.new(
      call_id: "call_#{SecureRandom.hex(4)}",
      name: name,
      arguments: arguments,
      parsed: {}
    )
  end
end
