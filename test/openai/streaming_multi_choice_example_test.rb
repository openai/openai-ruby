# frozen_string_literal: true

require "json"

require_relative "test_helper"

class OpenAI::Test::StreamingMultiChoiceExampleTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  EXAMPLE_PATH = File.expand_path("../../examples/chat/streaming_multi_choice.rb", __dir__)

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.allow_net_connect!
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_labels_each_completion_by_choice_index_when_choice_one_finishes_first
    stdout, stderr, exit_error = run_example(
      terminal_chunk(index: 1, content: "Second choice"),
      terminal_chunk(index: 0, content: "First choice")
    )

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_equal(successful_output(first_completion: 1), stdout)
  end

  def test_labels_each_completion_by_choice_index_when_choice_zero_finishes_first
    stdout, stderr, exit_error = run_example(
      terminal_chunk(index: 0, content: "First choice"),
      terminal_chunk(index: 1, content: "Second choice")
    )

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_equal(successful_output(first_completion: 0), stdout)
  end

  def test_fails_when_a_choice_never_completes
    stdout, stderr, exit_error = run_example(
      terminal_chunk(index: 0, content: "First choice")
    )

    assert_failure(exit_error, stderr)
    assert_equal(completion_output(index: 0, content: "First choice"), stdout)
  end

  def test_fails_when_a_completed_choice_has_empty_content
    stdout, stderr, exit_error = run_example(
      terminal_chunk(index: 0, content: ""),
      terminal_chunk(index: 1, content: "Second choice")
    )

    assert_failure(exit_error, stderr)
    assert_equal(
      completion_output(index: 0, content: "") +
        completion_output(index: 1, content: "Second choice"),
      stdout
    )
  end

  private

  def run_example(*chunks)
    wire = chunks.map { |chunk| "data: #{JSON.generate(chunk)}\n\n" }.join + "data: [DONE]\n\n"
    stub_request(:post, "http://localhost/chat/completions")
      .with(body: hash_including(model: "gpt-4o-mini", n: 2, stream: true))
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: wire
      )

    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "fake-key")
    exit_error = nil
    stdout, stderr = capture_io do
      OpenAI::Client.stub(:new, client) do
        load(EXAMPLE_PATH, true)
      rescue SystemExit => error
        exit_error = error
      end
    end

    [stdout, stderr, exit_error]
  end

  def terminal_chunk(index:, content:)
    {
      id: "chatcmpl_synthetic",
      object: "chat.completion.chunk",
      created: 0,
      model: "test",
      choices: [
        {
          index: index,
          delta: {role: "assistant", content: content},
          finish_reason: "stop"
        }
      ]
    }
  end

  def successful_output(first_completion:)
    second_completion = 1 - first_completion
    content_by_index = {0 => "First choice", 1 => "Second choice"}

    completion_output(index: first_completion, content: content_by_index.fetch(first_completion)) +
      completion_output(index: second_completion, content: content_by_index.fetch(second_completion)) +
      "------ final choices ------\n" \
        "[0] First choice\n" \
        "[1] Second choice\n"
  end

  def completion_output(index:, content:)
    "[choice #{index}] complete:\n" \
      "#{content}\n" \
      "--- choice #{index} done ---\n\n"
  end

  def assert_failure(error, stderr)
    assert_instance_of(SystemExit, error)
    assert_equal(1, error.status)
    assert_equal("Expected two completed choices with content; received 1\n", stderr)
  end
end
