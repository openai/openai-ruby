# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::DecisionMessageConstructorTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_configured_and_local_constructors_preserve_request_content
    constructors = [
      [OpenAI::DecisionInputMessage, "user"],
      [OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage, "user"],
      [OpenAI::DecisionInputMessageUnion::Developer, "developer"],
      [OpenAI::DecisionInputMessageUnion::System, "system"],
      [OpenAI::DecisionInputMessageUnion::Assistant, "assistant"]
    ]
    contents = [
      "synthetic text",
      [
        OpenAI::DecisionInputText.new(text: "synthetic text"),
        OpenAI::DecisionInputImage.new(image_url: "https://example.invalid/image.png"),
        OpenAI::DecisionInputJSON.new(data: {nested: [false, nil, {value: 3}]})
      ]
    ]
    client = OpenAI::Client.new(api_key: "fake-test-key", base_url: "https://example.invalid", max_retries: 0)
    constructors.each do |constructor, role|
      contents.each do |content|
        next if role != "user" && !content.is_a?(String)

        message = constructor.new(content: content)
        received = nil
        request = stub_request(:post, "https://example.invalid/decisions")
          .with { |req| received = JSON.parse(req.body) }
          .to_return(
            headers: {"content-type" => "application/json"},
            body: JSON.generate(id: "decision_synthetic", answers: [], model: "synthetic-model", usage: {})
          )
        client.decisions.create(input: [message], model: "synthetic-model", questions: [])
        expected_content = content.is_a?(String) ? content : [
          {"type" => "input_text", "text" => "synthetic text"},
          {"type" => "input_image", "image_url" => "https://example.invalid/image.png"},
          {"type" => "input_json", "data" => {"nested" => [false, nil, {"value" => 3}]}}
        ]
        assert_equal([{"role" => role, "content" => expected_content}], received.fetch("input"))
        assert_requested(request, times: 1)
        WebMock.reset!
      end
    end
  end
end
