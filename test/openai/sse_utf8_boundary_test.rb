# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::SseUtf8BoundaryTest < Minitest::Test
  extend Minitest::Serial

  def test_one_leading_bom_matches_plain_sse_for_raw_and_helper_streams
    wire = chat_stream_wire(content: "start ", terminal_content: "end")
    bom = "\xEF\xBB\xBF".b
    plain = consume_stream([wire])

    assert_equal(plain, consume_stream([bom + wire]))
    assert_equal(plain, consume_stream([bom.byteslice(0, 1), bom.byteslice(1, 1), bom.byteslice(2, 1), wire]))
  end

  def test_utf8_labeled_fragments_match_binary_fragments_across_multibyte_boundaries
    wire = chat_stream_wire(content: "你好世界", terminal_content: " end")
    split = wire.index("你".b).succ
    binary_fragments = [wire.byteslice(...split), wire.byteslice(split...)]
    utf8_fragments = binary_fragments.map { _1.dup.force_encoding(Encoding::UTF_8) }
    snapshots = utf8_fragments.map { [_1.bytes, _1.encoding] }

    assert_equal(consume_stream(binary_fragments), consume_stream(utf8_fragments))
    assert_equal(snapshots, utf8_fragments.map { [_1.bytes, _1.encoding] })
  end

  def test_ascii_prefix_then_utf8_content_matches_binary_sse
    wire = chat_stream_wire(content: "你好世界", terminal_content: " end")
    split = wire.index("你".b)
    mixed_fragments = [
      wire.byteslice(...split).force_encoding(Encoding::US_ASCII),
      wire.byteslice(split...).force_encoding(Encoding::UTF_8)
    ]

    assert_equal(consume_stream([wire]), consume_stream(mixed_fragments))
  end

  def test_ascii_prefix_then_utf8_content_preserves_jsonl_decoding
    jsonl = "{\"content\":\"你好世界\"}\n"
    split = jsonl.index("你")
    fragments = [
      jsonl.byteslice(...split).force_encoding(Encoding::US_ASCII),
      jsonl.byteslice(split...).force_encoding(Encoding::UTF_8)
    ]

    line = OpenAI::Internal::Util.decode_lines(fragments).to_a.fetch(0)

    assert_equal("你好世界", JSON.parse(line).fetch("content"))
  end

  def test_only_a_leading_bom_is_ignored_and_crlf_still_decodes
    embedded_bom = "before \uFEFF after"
    wire = chat_stream_wire(content: embedded_bom, terminal_content: "", eol: "\r\n")
    raw, helper = consume_stream([wire])

    assert_equal([[embedded_bom, nil], ["", :stop]], raw)
    assert_equal([embedded_bom, :stop], helper)
  end

  private

  def chat_stream_wire(content:, terminal_content:, eol: "\n")
    base = {id: "chatcmpl_synthetic", object: "chat.completion.chunk", created: 1, model: "test"}
    first = base.merge(choices: [{index: 0, delta: {role: "assistant", content: content}, finish_reason: nil}])
    last = base.merge(choices: [{index: 0, delta: {content: terminal_content}, finish_reason: "stop"}])
    [first, last].map { "data: #{JSON.generate(_1)}#{eol}#{eol}" }.join.b + "data: [DONE]#{eol}#{eol}".b
  end

  def consume_stream(fragments)
    [:stream_raw, :stream].map do |method|
      transport = OpenAI::HTTPClient.new
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "text/event-stream"},
        body: fragments
      )

      transport.stub(:execute, response) do
        client = OpenAI::Client.new(
          api_key: "synthetic-key",
          base_url: "https://sdk.example.test",
          http_client: transport
        )
        stream = client.chat.completions.public_send(
          method,
          model: "test",
          messages: [{role: :user, content: "synthetic"}]
        )
        events = stream.to_a

        if method == :stream_raw
          events.flat_map(&:choices).map { [_1.delta.content, _1.finish_reason] }
        else
          completion = stream.get_final_completion
          [completion.choices.first.message.content, completion.choices.first.finish_reason]
        end

      ensure
        stream&.close
      end
    end
  end
end
