# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::UnionDuplicateTagTest < Minitest::Test
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

  def test_response_input_items_preserve_each_message_role_and_content_type
    client = OpenAI::Client.new(api_key: "fake-test-key", base_url: "https://sdk-test.invalid/v1")
    messages = %w[user system developer assistant].map do |role|
      content = if role == "assistant"
        {type: "output_text", text: "synthetic reply", annotations: []}
      else
        {type: "input_text", text: "synthetic input"}
      end

      {id: "msg_#{role}", type: "message", role: role, status: "completed", content: [content]}
    end

    stub_request(:get, "https://sdk-test.invalid/v1/responses/resp_test/input_items")
      .to_return(
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate({object: "list", data: messages, has_more: false})
      )

    items = client.responses.input_items.list("resp_test").data
    items.first(3).each do |item|
      assert_instance_of(OpenAI::Responses::ResponseInputMessageItem, item)
      assert_instance_of(OpenAI::Responses::ResponseInputText, item.content.first)
    end

    assert_instance_of(OpenAI::Responses::ResponseOutputMessage, items.last)
    assert_instance_of(OpenAI::Responses::ResponseOutputText, items.last.content.first)
    assert_equal(messages, JSON.parse(JSON.generate(items.map(&:deep_to_h)), symbolize_names: true))
  end

  def test_duplicate_message_tags_use_fields_in_either_declaration_order
    [OpenAI::Responses::ResponseItem, OpenAI::Beta::BetaResponseItem].each do |union|
      variants = union.variants.first(2)
      [variants, variants.reverse].each do |ordered|
        candidate_union = Module.new do
          extend(OpenAI::Internal::Type::Union)
          discriminator(:type)
          ordered.each { |model| variant(:message, -> { model }) }
        end

        ["message", :message].each do |tag|
          input = {
            id: "msg_test",
            type: "message",
            role: "assistant",
            status: "completed",
            content: [{type: "output_text", text: "synthetic reply", annotations: []}]
          }
          input[:type] = tag
          parsed = OpenAI::Internal::Type::Converter.coerce(candidate_union, input)
          assert_instance_of(variants.last, parsed)
          assert_equal(:assistant, parsed.role)
          refute_instance_of(Hash, parsed.content.first)
        end
      end
    end
  end

  def test_unknown_tags_still_remain_raw
    input = {type: "future_item", role: "assistant", content: []}
    [OpenAI::Responses::ResponseItem, OpenAI::Beta::BetaResponseItem].each do |union|
      assert_same(input, OpenAI::Internal::Type::Converter.coerce(union, input))
    end
  end
end
