# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::ResponseTextSorbetTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

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

  def test_shipped_rbi_types_text_as_an_eager_string_enumerator
    source = <<~RUBY
      # typed: strict

      client = OpenAI::Client.new(api_key: "synthetic-key")
      stream = client.responses.stream(model: "gpt-4o-mini", input: "Synthetic")
      texts = stream.text

      T.assert_type!(texts, T::Enumerator[String])
      mapped = T.let(texts.map { |text| text.upcase }, T::Array[String])
      taken = T.let(stream.text.take(1), T::Array[String])
      lazy = T.let(stream.text.lazy.map { |text| text.upcase }, T::Enumerator::Lazy[String])

      T.assert_type!(mapped.fetch(0), String)
      T.assert_type!(taken.fetch(0), String)
      T.assert_type!(lazy, T::Enumerator::Lazy[String])
    RUBY

    stdout, stderr, status = typecheck(source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_rejects_lazy_only_operation_on_text
    source = <<~RUBY
      # typed: strict

      client = OpenAI::Client.new(api_key: "synthetic-key")
      stream = client.responses.stream(model: "gpt-4o-mini", input: "Synthetic")
      texts = stream.text
      T.assert_type!(texts, T::Enumerator[String])
      texts.force
    RUBY

    stdout, stderr, status = typecheck(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "force")
  end

  def test_public_text_stream_remains_an_eager_enumerator
    stub_request(:post, "http://localhost/responses").to_return(
      status: 200,
      headers: {"Content-Type" => "text/event-stream"},
      body: sse_response
    )

    stream = OpenAI::Client
      .new(
        api_key: "synthetic-key",
        base_url: "http://localhost"
      )
      .responses
      .stream(model: "gpt-4o-mini", input: "Synthetic")

    texts = stream.text
    normalized = texts.map { |text| text.upcase }

    assert_instance_of(Enumerator, texts)
    refute_instance_of(Enumerator::Lazy, texts)
    assert_instance_of(Array, normalized)
    assert_equal(["HELLO", " WORLD"], normalized)
    assert_equal("hello world", stream.get_output_text)
    assert_requested(:post, "http://localhost/responses", times: 1)
  ensure
    stream&.close
  end

  private def typecheck(source)
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["response-text-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "typecheck",
        file.path,
        chdir: root
      )
    end
  end

  private def sse_response
    events = [
      {type: "response.created", sequence_number: 0, response: response},
      {type: "response.output_item.added", sequence_number: 1, output_index: 0, item: message_item},
      {
        type: "response.content_part.added",
        sequence_number: 2,
        output_index: 0,
        item_id: "msg_synthetic",
        content_index: 0,
        part: text_part
      },
      text_delta(3, "hello"),
      text_delta(4, " world"),
      {
        type: "response.output_text.done",
        sequence_number: 5,
        output_index: 0,
        item_id: "msg_synthetic",
        content_index: 0,
        text: "hello world"
      },
      {
        type: "response.completed",
        sequence_number: 6,
        response: response.merge(
          status: "completed",
          output: [message_item.merge(status: "completed", content: [text_part.merge(text: "hello world")])]
        )
      }
    ]

    events.map { |event| "data: #{JSON.generate(event)}\n\n" }.join
  end

  private def text_delta(sequence_number, delta)
    {
      type: "response.output_text.delta",
      sequence_number: sequence_number,
      output_index: 0,
      item_id: "msg_synthetic",
      content_index: 0,
      delta: delta
    }
  end

  private def response
    {
      id: "resp_synthetic",
      object: "response",
      created_at: 1,
      status: "in_progress",
      error: nil,
      incomplete_details: nil,
      instructions: nil,
      model: "gpt-4o-mini",
      output: [],
      parallel_tool_calls: true,
      metadata: {},
      temperature: 1.0,
      tool_choice: "auto",
      tools: [],
      top_p: 1.0
    }
  end

  private def message_item
    {
      id: "msg_synthetic",
      type: "message",
      role: "assistant",
      status: "in_progress",
      content: []
    }
  end

  private def text_part
    {type: "output_text", text: "", annotations: [], logprobs: []}
  end
end
