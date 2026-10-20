# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::CompactionContractTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_ga_compaction_preserves_typed_items_and_next_request
    client = OpenAI::Client.new(api_key: "fake-test-key", base_url: "https://sdk-test.invalid/v1")
    assert_compaction_contract(client.responses, OpenAI::Responses, "")
  end

  def test_beta_compaction_preserves_typed_items_and_next_request
    client = OpenAI::Client.new(api_key: "fake-test-key", base_url: "https://sdk-test.invalid/v1")
    assert_compaction_contract(client.beta.responses, OpenAI::Beta, "?beta=true")
  end

  private

  def assert_compaction_contract(resource, models, suffix)
    messages = %w[user system developer assistant].map do |role|
      content = role == "assistant" ? {type: "output_text", text: "synthetic reply", annotations: []} : {
        type: "input_text",
        text: "synthetic #{role}"
      }
      {id: "msg_#{role}", type: "message", role: role, status: "completed", content: [content]}
    end

    messages.first[:content].concat(
      [
        {type: "input_image", image_url: "https://example.invalid/image.png", detail: "auto"},
        {type: "input_audio", input_audio: {data: "ZmFrZQ==", format: "wav"}}
      ]
    )
    items = messages +
      [
        {
          type: "function_call",
          id: "fc_test",
          call_id: "call_test",
          name: "synthetic_tool",
          arguments: "{}",
          status: "completed"
        },
        {type: "compaction", id: "cmp_test", encrypted_content: "fake-encrypted-content"},
        {type: "future_item", synthetic_value: "preserved"},
        {}
      ]
    compact_stub = stub_request(:post, "https://sdk-test.invalid/v1/responses/compact#{suffix}")
      .to_return(
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate(
          {
            id: "cmp_response",
            object: "response.compaction",
            created_at: 1,
            output: items,
            usage: {input_tokens: 1, output_tokens: 1, total_tokens: 2}
          }
        )
      )
    compacted = resource.compact(model: "synthetic-model", input: "synthetic input")
    prefix = models == OpenAI::Beta ? "Beta" : ""
    compacted.output.first(3).each do |item|
      assert_instance_of(models.const_get("#{prefix}ResponseInputMessageItem"), item)
      assert_instance_of(models.const_get("#{prefix}ResponseInputText"), item.content.first)
    end

    assert_instance_of(models.const_get("#{prefix}ResponseInputImage"), compacted.output.first.content[1])
    # Audio is not in the existing ResponseInputContent union; retain its raw fields.
    assert_instance_of(Hash, compacted.output.first.content[2])
    assert_instance_of(models.const_get("#{prefix}ResponseOutputMessage"), compacted.output[3])
    assert_instance_of(models.const_get("#{prefix}ResponseOutputText"), compacted.output[3].content.first)
    assert_instance_of(models.const_get("#{prefix}ResponseFunctionToolCallItem"), compacted.output[4])
    assert_instance_of(models.const_get("#{prefix}ResponseCompactionItem"), compacted.output[5])
    assert_instance_of(Hash, compacted.output[-2])
    serialized = JSON.parse(JSON.generate(compacted.deep_to_h.fetch(:output)), symbolize_names: true)
    assert_equal(items, serialized)
    next_stub = stub_request(:post, "https://sdk-test.invalid/v1/responses#{suffix}")
      .with { |request| JSON.parse(request.body, symbolize_names: true).fetch(:input) == items }
      .to_return(headers: {"Content-Type" => "application/json"}, body: "{\"id\":\"resp_next\",\"output\":[]}")
    assert_equal("resp_next", resource.create(model: "synthetic-model", input: compacted.deep_to_h.fetch(:output)).id)
    assert_requested(compact_stub)
    assert_requested(next_stub)
  end
end
