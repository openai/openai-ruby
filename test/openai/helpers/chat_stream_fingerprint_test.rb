# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamFingerprintTest < Minitest::Test
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

  def test_system_fingerprint_accumulates_without_changing_stream_output
    cases = [
      ["fp_initial", nil, "fp_initial"],
      [nil, "fp_later", "fp_later"],
      ["fp_initial", "fp_later", "fp_later"],
      [nil, nil, nil]
    ]

    cases.each do |initial_fingerprint, later_fingerprint, expected_fingerprint|
      stream = stream_for(initial_fingerprint:, later_fingerprint:)
      event_types = []
      raw_fingerprints = []
      snapshot_fingerprints = []
      stream.each do |event|
        event_types << event.type
        next unless event.type == :chunk

        raw_fingerprints << event.chunk.system_fingerprint
        snapshot_fingerprints << event.snapshot.system_fingerprint
      end

      completion = stream.get_final_completion

      assert_equal(
        [initial_fingerprint, later_fingerprint, nil],
        raw_fingerprints
      )
      assert_equal(
        [initial_fingerprint, expected_fingerprint, expected_fingerprint],
        snapshot_fingerprints
      )
      if expected_fingerprint.nil?
        assert_nil(completion.system_fingerprint)
      else
        assert_equal(expected_fingerprint, completion.system_fingerprint)
      end

      assert_equal("Hello world", stream.get_output_text)
      assert_equal([0], completion.choices.map(&:index))
      assert_equal("Hello world", completion.choices.first.message.content)
      assert_equal(2, completion.usage.total_tokens)
      assert_equal(
        [:chunk, :"content.delta", :chunk, :"content.delta", :"content.done", :chunk],
        event_types
      )
    end
  end

  private

  def stream_for(initial_fingerprint:, later_fingerprint:)
    WebMock.reset!
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: sse(initial_fingerprint:, later_fingerprint:)
      )

    @client.chat.completions.stream(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini"
    )
  end

  def sse(initial_fingerprint:, later_fingerprint:)
    chunks = [
      chunk(
        system_fingerprint: initial_fingerprint,
        choices: [choice(delta: {role: "assistant", content: "Hello"})]
      ),
      chunk(
        system_fingerprint: later_fingerprint,
        choices: [choice(delta: {content: " world"}, finish_reason: "stop")]
      ),
      chunk(
        system_fingerprint: nil,
        choices: [],
        usage: {prompt_tokens: 1, completion_tokens: 1, total_tokens: 2}
      )
    ]

    chunks.map { |payload| "data: #{JSON.generate(payload)}\n\n" }.join + "data: [DONE]\n\n"
  end

  def chunk(system_fingerprint:, choices:, usage: nil)
    {
      id: "chatcmpl-fingerprint",
      object: "chat.completion.chunk",
      created: 1,
      model: "gpt-4o-mini",
      system_fingerprint: system_fingerprint,
      choices: choices,
      usage: usage
    }
  end

  def choice(delta:, finish_reason: nil)
    {index: 0, delta: delta, finish_reason: finish_reason}
  end
end
