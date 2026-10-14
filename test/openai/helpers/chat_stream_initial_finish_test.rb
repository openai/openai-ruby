# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatStreamInitialFinishTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class StructuredResult < OpenAI::BaseModel
    required :value, Integer
  end

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

  def test_parseable_initial_terminal_chunks_raise_the_existing_finish_errors
    parseable_options.each do |options|
      finish_errors.each do |finish_reason, error_class|
        [false, true].each do |prefix|
          stream = stream_for(
            chunks: terminal_chunks(finish_reason, prefix: prefix),
            **options
          )

          error = assert_raises(error_class) { stream.to_a }
          snapshot = stream.current_completion_snapshot

          assert_equal(finish_reason, snapshot.choices.first.finish_reason)
          assert_raises(error_class) { stream.get_final_completion }

          next unless finish_reason == :length

          assert_same(error.completion, snapshot)
          choice = error.completion.choices.first
          assert_equal(:length, choice.finish_reason)
          assert_equal(:assistant, choice.message.role)
          assert_equal("{\"value\":", choice.message.content)
        end
      end
    end
  end

  def test_plain_chat_terminal_chunks_keep_existing_non_raising_behavior
    finish_errors.each_key do |finish_reason|
      [false, true].each do |prefix|
        stream = stream_for(chunks: terminal_chunks(finish_reason, prefix: prefix))

        stream.to_a

        assert_equal(finish_reason, stream.get_final_completion.choices.first.finish_reason)
      end
    end
  end

  def test_successful_initial_and_prefixed_structured_streams_still_parse
    [false, true].each do |prefix|
      chunks = []
      chunks << choice(delta: {role: "assistant"}) if prefix
      chunks <<
        choice(
          delta: {role: "assistant", content: "{\"value\":1}"},
          finish_reason: "stop"
        )
      stream = stream_for(chunks: chunks, response_format: StructuredResult)

      stream.to_a
      completion = stream.get_final_completion

      assert_equal("{\"value\":1}", completion.choices.first.message.content)
      assert_equal(1, completion.choices.first.message.parsed.value)
    end
  end

  private

  def parseable_options
    [
      {response_format: StructuredResult},
      {
        tools: [
          {
            type: :function,
            function: {
              name: "synthetic",
              strict: false,
              parameters: {type: :object, properties: {}}
            }
          }
        ]
      }
    ]
  end

  def finish_errors
    {
      length: OpenAI::LengthFinishReasonError,
      content_filter: OpenAI::ContentFilterFinishReasonError
    }
  end

  def terminal_chunks(finish_reason, prefix:)
    chunks = []
    chunks << choice(delta: {role: "assistant"}) if prefix
    chunks <<
      choice(
        delta: {role: "assistant", content: "{\"value\":"},
        finish_reason: finish_reason.to_s
      )
    chunks
  end

  def stream_for(chunks:, **options)
    WebMock.reset!
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: sse(chunks)
      )

    @client.chat.completions.stream(
      messages: [{content: "Synthetic", role: :user}],
      model: "gpt-4o-mini",
      **options
    )
  end

  def sse(choices)
    chunks = choices.map do |choice|
      payload = {
        id: "chatcmpl-initial-finish",
        object: "chat.completion.chunk",
        created: 1,
        model: "gpt-4o-mini",
        choices: [choice]
      }
      "data: #{JSON.generate(payload)}\n\n"
    end

    chunks.join + "data: [DONE]\n\n"
  end

  def choice(delta:, finish_reason: nil)
    {index: 0, delta: delta, finish_reason: finish_reason}
  end
end
