# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::ChatStreamSorbetTest < Minitest::Test
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

  def teardown
    WebMock.reset!
    super
  end

  def test_shipped_rbi_types_high_level_chat_stream_workflow
    source = <<~RUBY
      # typed: strict

      class MathResponse < OpenAI::BaseModel
        required :answer, Integer
      end

      class MathTool < OpenAI::BaseModel
        required :x, Integer
      end

      client = OpenAI::Client.new(api_key: "test-key")
      stream = client.chat.completions.stream(
        model: "gpt-4o-mini",
        messages: [OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Hello")],
        response_format: MathResponse,
        tools: [MathTool]
      )

      T.assert_type!(stream, OpenAI::Streaming::ChatCompletionStream)
      T.assert_type!(stream.text, T::Enumerator[String])
      stream.text.each { |text| T.assert_type!(text, String) }
      stream.each do |event|
        T.assert_type!(event, OpenAI::Helpers::Streaming::ChatCompletionStream::ChatCompletionStreamEvent)
        T.assert_type!(event.type, Symbol)

        case event
        when OpenAI::Streaming::ChatLogprobsContentDeltaEvent
          T.assert_type!(event.snapshot, T::Array[OpenAI::Chat::ChatCompletionTokenLogprob])
        when OpenAI::Streaming::ChatLogprobsRefusalDeltaEvent
          T.assert_type!(event.snapshot, T::Array[OpenAI::Chat::ChatCompletionTokenLogprob])
        end
      end
      T.assert_type!(stream.get_final_completion, OpenAI::Chat::ChatCompletion)
      snapshot = stream.current_completion_snapshot
      T.assert_type!(snapshot, T.nilable(OpenAI::Chat::ParsedChatCompletion))
      if snapshot
        T.assert_type!(
          snapshot.choices.fetch(0).finish_reason,
          T.nilable(OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
        )
      end
      T.assert_type!(stream.get_output_text, String)
      T.assert_type!(stream.until_done, OpenAI::Streaming::ChatCompletionStream)
      T.assert_type!(stream.status, Integer)
      T.assert_type!(stream.headers, T::Hash[String, String])
      T.assert_type!(stream.last_response, OpenAI::ResponseMetadata)
      T.assert_type!(stream._request_id, T.nilable(String))
      stream.close

      done = T.must(T.let(nil, T.nilable(OpenAI::Streaming::ChatFunctionToolCallArgumentsDoneEvent)))
      delta = T.must(T.let(nil, T.nilable(OpenAI::Streaming::ChatFunctionToolCallArgumentsDeltaEvent)))
      done.parsed
      delta.parsed
    RUBY

    stdout, stderr, status = typecheck(source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_rejects_wrong_chat_stream_contracts
    source = <<~RUBY
      # typed: strict

      client = OpenAI::Client.new(api_key: "test-key")
      client.chat.completions.stream(
        model: 123,
        messages: [OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Hello")]
      )

      event = T.must(
        T.let(nil, T.nilable(OpenAI::Streaming::ChatFunctionToolCallArgumentsDoneEvent))
      )
      event.parsed_arguments
    RUBY

    stdout, stderr, status = typecheck(source)
    output = "#{stdout}\n#{stderr}"

    refute_predicate(status, :success?, output)
    assert_includes(output, "Expected")
    assert_includes(output, "Method \`parsed_arguments\` does not exist")
  end

  def test_text_returns_the_declared_eager_enumerator_shape
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: chat_stream_body
      )
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
    stream = client.chat.completions.stream(
      model: "gpt-4o-mini",
      messages: [{role: :user, content: "Synthetic"}]
    )

    text = stream.text

    assert_instance_of(Enumerator, text)
    refute_instance_of(Enumerator::Lazy, text)
    assert_equal(["Hello"], text.to_a)
  ensure
    stream&.close
  end

  def test_current_snapshot_keeps_a_nil_finish_reason_before_terminal_chunk
    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: chat_nonterminal_stream_body
      )
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
    stream = client.chat.completions.stream(
      model: "gpt-4o-mini",
      messages: [{role: :user, content: "Synthetic"}]
    )

    stream.to_a

    snapshot = stream.current_completion_snapshot
    refute_nil(snapshot)
    assert_nil(snapshot.choices.first.finish_reason)
  ensure
    stream&.close
  end

  private def typecheck(source)
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["chat-stream-sorbet", ".rb"]) do |file|
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

  private def chat_stream_body
    payload = {
      id: "chatcmpl-sorbet-shape",
      object: "chat.completion.chunk",
      created: 1,
      model: "gpt-4o-mini",
      choices: [{index: 0, delta: {role: "assistant", content: "Hello"}, finish_reason: "stop"}]
    }

    "data: #{JSON.generate(payload)}\n\ndata: [DONE]\n\n"
  end

  private def chat_nonterminal_stream_body
    payload = {
      id: "chatcmpl-sorbet-partial",
      object: "chat.completion.chunk",
      created: 1,
      model: "gpt-4o-mini",
      choices: [{index: 0, delta: {role: "assistant", content: "Hello"}, finish_reason: nil}]
    }

    "data: #{JSON.generate(payload)}\n\ndata: [DONE]\n\n"
  end
end
