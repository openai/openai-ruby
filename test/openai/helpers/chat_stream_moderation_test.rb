# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamModerationTest < Minitest::Test
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

  def test_final_moderation_chunk_is_preserved_from_raw_stream_to_snapshots_and_completion
    moderation = moderation_payload(
      input: success_result(flagged: true, score: 0.75),
      output: error_result(code: "output_unavailable")
    )
    chunks = stream_chunks(final_moderation: moderation)

    raw_chunks = raw_stream_for(chunks).to_a
    raw_moderation = raw_chunks.last.moderation.deep_to_h

    stream = stream_for(chunks)
    event_types = []
    raw_values = []
    snapshot_values = []
    stream.each do |event|
      event_types << event.type
      next unless event.type == :chunk

      raw_values << event.chunk.moderation&.deep_to_h
      snapshot_values << event.snapshot.moderation&.deep_to_h
    end

    completion = stream.get_final_completion

    assert_equal(:moderation_results, raw_moderation.dig(:input, :type))
    assert_equal(true, raw_moderation.dig(:input, :results, 0, :flagged))
    assert_equal(0.75, raw_moderation.dig(:input, :results, 0, :category_scores, :violence))
    assert_equal(:error, raw_moderation.dig(:output, :type))
    assert_equal([nil, nil, raw_moderation], raw_values)
    assert_equal([nil, nil, raw_moderation], snapshot_values)
    assert_equal(raw_moderation, completion.moderation.deep_to_h)
    assert_instance_of(OpenAI::Chat::ChatCompletion::Moderation, stream.current_completion_snapshot.moderation)
    assert_instance_of(OpenAI::Chat::ChatCompletion::Moderation, completion.moderation)
    assert_equal("ok", completion.choices.first.message.content)
    assert_equal("ok", stream.get_output_text)
    assert_equal([0], completion.choices.map(&:index))
    assert_equal(2, completion.usage.total_tokens)
    assert_equal(
      [:chunk, :"content.delta", :chunk, :"content.delta", :"content.done", :chunk],
      event_types
    )
  end

  def test_initial_moderation_survives_later_omitted_and_nil_values
    moderation = moderation_payload(
      input: error_result(code: "input_unavailable"),
      output: success_result(flagged: false, score: 0.25)
    )
    chunks = stream_chunks(initial_moderation: moderation, final_moderation: nil)
    raw_moderation = raw_stream_for(chunks).to_a.first.moderation.deep_to_h

    stream = stream_for(chunks)
    raw_values = []
    snapshot_values = []
    stream.each do |event|
      next unless event.type == :chunk

      raw_values << event.chunk.moderation&.deep_to_h
      snapshot_values << event.snapshot.moderation&.deep_to_h
    end

    completion = stream.get_final_completion

    assert_equal([raw_moderation, nil, nil], raw_values)
    assert_equal([raw_moderation, raw_moderation, raw_moderation], snapshot_values)
    assert_equal(raw_moderation, completion.moderation.deep_to_h)
    assert_instance_of(OpenAI::Chat::ChatCompletion::Moderation, completion.moderation)
  end

  def test_unmoderated_stream_keeps_nil_moderation
    chunks = stream_chunks

    stream = stream_for(chunks)
    raw_values = []
    snapshot_values = []
    stream.each do |event|
      next unless event.type == :chunk

      raw_values << event.chunk.moderation
      snapshot_values << event.snapshot.moderation
    end

    completion = stream.get_final_completion

    assert_equal([nil, nil, nil], raw_values)
    assert_equal([nil, nil, nil], snapshot_values)
    assert_nil(completion.moderation)
  end

  private

  def raw_stream_for(chunks)
    stub_stream(chunks)
    @client.chat.completions.stream_raw(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini"
    )
  end

  def stream_for(chunks)
    stub_stream(chunks)
    @client.chat.completions.stream(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini"
    )
  end

  def stub_stream(chunks)
    WebMock.reset!
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: sse(chunks)
      )
  end

  def stream_chunks(initial_moderation: nil, final_moderation: :omitted)
    [
      chunk(
        moderation: initial_moderation,
        choices: [choice(delta: {role: "assistant", content: "o"})]
      ),
      chunk(
        choices: [choice(delta: {content: "k"}, finish_reason: "stop")]
      ),
      chunk(
        moderation: final_moderation,
        choices: [],
        usage: {prompt_tokens: 1, completion_tokens: 1, total_tokens: 2}
      )
    ]
  end

  def sse(chunks)
    chunks.map { |payload| "data: #{JSON.generate(payload)}\n\n" }.join + "data: [DONE]\n\n"
  end

  def chunk(moderation: :omitted, choices:, usage: nil)
    payload = {
      id: "chatcmpl-moderation",
      object: "chat.completion.chunk",
      created: 1,
      model: "gpt-4o-mini",
      choices: choices,
      usage: usage
    }
    payload[:moderation] = moderation unless moderation == :omitted
    payload
  end

  def choice(delta:, finish_reason: nil)
    {index: 0, delta: delta, finish_reason: finish_reason}
  end

  def moderation_payload(input:, output:)
    {input: input, output: output}
  end

  def success_result(flagged:, score:)
    {
      type: "moderation_results",
      model: "omni-moderation-latest",
      results: [
        {
          type: "moderation_result",
          model: "omni-moderation-latest",
          categories: {violence: flagged},
          category_applied_input_types: {violence: ["text"]},
          category_scores: {violence: score},
          flagged: flagged
        }
      ]
    }
  end

  def error_result(code:)
    {type: "error", code: code, message: "synthetic moderation error"}
  end
end
