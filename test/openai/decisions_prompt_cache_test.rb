# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::DecisionsPromptCacheTest < Minitest::Test
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

  %i[explicit implicit nulls omitted].each do |mode|
    define_method("test_request_#{mode}") do
      content = [
        {type: "input_text", text: "synthetic"},
        {type: "input_image", image_url: "https://example.test/image.png"}
      ]
      body = {
        model: "synthetic-model",
        input: [{type: "message", role: "user", content: content}],
        questions: [{instructions: "Synthetic question", type: "predicate"}]
      }
      unless mode == :omitted
        body[:prompt_cache_key] = mode == :nulls ? nil : "synthetic-key"
        body[:prompt_cache_options] = mode == :nulls ? nil : {mode: mode, ttl: "30m"}
        content.each do |part|
          part[:prompt_cache_breakpoint] = mode == :nulls ? nil : {mode: "explicit"}
        end
      end

      expected = JSON.parse(JSON.generate(body))
      received = nil
      request = stub_request(:post, "https://example.test/decisions")
        .with { |req| (received = JSON.parse(req.body)) == expected }
        .to_return(
          status: 200,
          headers: {"content-type" => "application/json"},
          body: JSON.generate(id: "decision_synthetic", answers: [], model: "synthetic-model", usage: {})
        )
      client = OpenAI::Client.new(
        api_key: "fake-test-key",
        base_url: "https://example.test",
        max_retries: 0
      )
      client.decisions.create(**body)
      assert_equal(expected, received)
      assert_requested(request, times: 1)
    end
  end

  def test_shared_breakpoint_and_caller_owned_hashes
    shared = OpenAI::DecisionPromptCacheBreakpoint.new(mode: :explicit)
    text = OpenAI::DecisionInputText.new(text: "synthetic", prompt_cache_breakpoint: shared)
    image = OpenAI::DecisionInputImage.new(
      image_url: "https://example.test/image.png",
      prompt_cache_breakpoint: shared
    )
    assert_same(shared, text.prompt_cache_breakpoint)
    assert_same(shared, image.prompt_cache_breakpoint)

    caller_owned = {mode: :explicit}
    text.prompt_cache_breakpoint = caller_owned
    assert_same(caller_owned, text.prompt_cache_breakpoint)
  end
end
