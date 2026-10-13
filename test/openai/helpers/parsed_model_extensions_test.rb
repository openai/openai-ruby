# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ParsedModelExtensionsTest < Minitest::Test
  def test_chat_message_parsed_field_is_available_to_generated_and_consumer_subclasses
    parsed = {answer: "synthetic"}
    classes = [
      OpenAI::Models::Chat::ChatCompletionMessage,
      OpenAI::Models::Chat::ChatCompletionStoreMessage,
      Class.new(OpenAI::Models::Chat::ChatCompletionMessage)
    ]

    classes.each do |model|
      message = model.new(content: "synthetic", parsed: parsed)

      assert_equal(parsed, message.parsed)
      assert_equal(parsed, message.deconstruct_keys([:parsed]).fetch(:parsed))
      refute(JSON.parse(message.to_json).key?("parsed"))
      assert_nil(model.new.parsed)
    end
  end

  def test_chat_tool_arguments_remain_parsed_and_response_only
    model = OpenAI::Models::Chat::ChatCompletionMessageFunctionToolCall::Function
    parsed = {answer: 42}
    function = model.new(arguments: "{\"answer\":42}", name: "synthetic", parsed: parsed)

    assert_equal(parsed, function.parsed)
    assert_equal({"arguments" => "{\"answer\":42}", "name" => "synthetic"}, JSON.parse(function.to_json))
    assert_equal(parsed, Class.new(model).new(parsed: parsed).parsed)
  end

  def test_response_tool_parsed_field_is_available_to_generated_and_consumer_subclasses
    parsed = {answer: 42}
    classes = [
      OpenAI::Models::Responses::ResponseFunctionToolCall,
      OpenAI::Models::Responses::ResponseFunctionToolCallItem,
      Class.new(OpenAI::Models::Responses::ResponseFunctionToolCall)
    ]

    classes.each do |model|
      call = model.new(arguments: "{}", name: "synthetic", call_id: "call_synthetic", parsed: parsed)

      assert_equal(parsed, call.parsed)
      assert_equal(parsed, call.deconstruct_keys([:parsed]).fetch(:parsed))
      refute(JSON.parse(call.to_json).key?("parsed"))
    end
  end

  def test_response_output_parsed_field_remains_optional_and_response_only
    model = OpenAI::Models::Responses::ResponseOutputText
    parsed = {answer: "synthetic"}
    output = model.new(text: "synthetic", annotations: [], parsed: parsed)

    assert_equal(parsed, output.parsed)
    assert_nil(model.new.parsed)
    refute(JSON.parse(output.to_json).key?("parsed"))
    assert_equal(parsed, Class.new(model).new(parsed: parsed).parsed)
  end

end
