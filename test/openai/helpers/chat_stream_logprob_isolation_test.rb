# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamLogprobIsolationTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def setup
    super
    @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_raw_chunk_logprobs_stay_isolated_when_they_start_after_the_initial_chunk
    [:content, :refusal].each do |kind|
      stream = stream_for(kind, initial_logprobs: false)
      chunks, observed = collect_raw_logprobs(stream, kind)

      assert_equal([nil, ["A"], ["B"], nil], observed)
      assert_equal([nil, ["A"], ["B"], nil], retained_logprobs(chunks, kind))
      assert_equal(["A", "B"], final_logprobs(stream, kind))
    end
  end

  def test_raw_chunk_logprobs_stay_isolated_when_the_initial_chunk_has_logprobs
    [:content, :refusal].each do |kind|
      stream = stream_for(kind, initial_logprobs: true)
      chunks, observed = collect_raw_logprobs(stream, kind)

      assert_equal([["A"], ["B"], nil], observed)
      assert_equal([["A"], ["B"], nil], retained_logprobs(chunks, kind))
      assert_equal(["A", "B"], final_logprobs(stream, kind))
    end
  end

  def test_late_choice_logprobs_still_accumulate_once_per_chunk
    stream = stream_for(:content, initial_logprobs: false, choice_index: 1, tokens: ["A", "A"])
    chunks, = collect_raw_logprobs(stream, :content)

    assert_equal([nil, ["A"], ["A"], nil], retained_logprobs(chunks, :content))
    assert_equal(["A", "A"], final_logprobs(stream, :content, choice_index: 1))
  end

  private

  def stream_for(kind, initial_logprobs:, choice_index: 0, tokens: ["A", "B"])
    WebMock.reset!
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: sse(kind:, initial_logprobs:, choice_index:, tokens:)
      )

    @client.chat.completions.stream(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini",
      logprobs: true
    )
  end

  def sse(kind:, initial_logprobs:, choice_index:, tokens:)
    choices = [
      choice(choice_index.zero? ? choice_index : 0, delta: {role: "assistant"}),
      choice(choice_index, delta: {kind => tokens.first}, logprobs: {kind => [logprob(tokens.first)]}),
      choice(choice_index, delta: {kind => tokens.last}, logprobs: {kind => [logprob(tokens.last)]}),
      choice(choice_index, delta: {}, finish_reason: "stop")
    ]
    choices.shift if initial_logprobs

    chunks = choices.map { |item| chunk(item) }
    chunks.map { |payload| "data: #{JSON.generate(payload)}\n\n" }.join + "data: [DONE]\n\n"
  end

  def chunk(choice)
    {
      id: "chatcmpl-logprob-isolation",
      object: "chat.completion.chunk",
      created: 1,
      model: "gpt-4o-mini",
      choices: [choice]
    }
  end

  def choice(index, delta:, logprobs: nil, finish_reason: nil)
    {index:, delta:, logprobs:, finish_reason:}
  end

  def logprob(token)
    {token:, logprob: -0.1, bytes: token.bytes, top_logprobs: []}
  end

  def collect_raw_logprobs(stream, kind)
    chunks = []
    observed = []

    stream.each do |event|
      next unless event.type == :chunk

      chunks << event.chunk
      observed << logprob_tokens(event.chunk, kind)
    end

    [chunks, observed]
  end

  def retained_logprobs(chunks, kind)
    chunks.map { |chunk| logprob_tokens(chunk, kind) }
  end

  def logprob_tokens(chunk, kind)
    logprobs = chunk.choices.first.logprobs
    values = kind == :content ? logprobs&.content : logprobs&.refusal
    values&.map(&:token)
  end

  def final_logprobs(stream, kind, choice_index: 0)
    choice = stream.get_final_completion.choices.find { |item| item.index == choice_index }
    values = kind == :content ? choice.logprobs.content : choice.logprobs.refusal
    values.map(&:token)
  end
end
