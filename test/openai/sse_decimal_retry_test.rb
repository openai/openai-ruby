# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::SseDecimalRetryTest < Minitest::Test
  extend Minitest::Serial

  def test_digit_only_retry_metadata_does_not_interrupt_raw_chat_stream
    %w[0 8 08 09 010].each do |retry_value|
      stream = raw_stream(retry_value)

      assert_equal(1, stream.to_a.length, "retry=#{retry_value}")
    ensure
      stream&.close
    end
  end

  def test_digit_only_retry_metadata_is_parsed_as_decimal
    {
      "0" => 0,
      "8" => 8,
      "08" => 8,
      "09" => 9,
      "010" => 10
    }.each do |retry_value, expected|
      event = OpenAI::Internal::Util.decode_sse(["retry: #{retry_value}\n", "data: ok\n", "\n"]).first

      assert_equal(expected, event.fetch(:retry), "retry=#{retry_value}")
    end
  end

  private

  def raw_stream(retry_value)
    payload = {
      id: "chatcmpl_synthetic",
      object: "chat.completion.chunk",
      created: 1,
      model: "test",
      choices: [{index: 0, delta: {role: "assistant", content: "ok"}, finish_reason: "stop"}]
    }
    wire = "retry: #{retry_value}\ndata: #{JSON.generate(payload)}\n\ndata: [DONE]\n\n".b
    transport = OpenAI::HTTPClient.new
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "text/event-stream"},
      body: [wire]
    )

    transport.stub(:execute, response) do
      client = OpenAI::Client.new(
        api_key: "synthetic-key",
        base_url: "https://sdk.example.test",
        http_client: transport
      )
      return client.chat.completions.stream_raw(
        model: "test",
        messages: [{role: :user, content: "synthetic"}]
      )
    end
  end
end
