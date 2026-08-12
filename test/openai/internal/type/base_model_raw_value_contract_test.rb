# frozen_string_literal: true

require_relative "../../test_helper"

# These tests pin the v0.78 BaseModel compatibility boundary. Request models retain
# caller-owned values, while the response coercion path may materialize parsed values.
class OpenAI::Test::BaseModelRawValueContractTest < Minitest::Test
  class Item < OpenAI::Internal::Type::BaseModel
    required :count, Integer
    required :type, const: :item
  end

  module ItemOrInteger
    extend OpenAI::Internal::Type::Union

    variant Item
    variant Integer
  end

  class Container < OpenAI::Internal::Type::BaseModel
    optional :item, Item
    optional :items, OpenAI::Internal::Type::ArrayOf[Item]
    optional :items_by_name, OpenAI::Internal::Type::HashOf[Item]
    optional :choice, ItemOrInteger
  end

  class Envelope < OpenAI::Internal::Type::BaseModel
    required :message, OpenAI::Responses::ResponseOutputMessage
  end

  def test_constructor_preserves_raw_values_for_every_nested_shape
    item = {count: "1", type: "item"}
    items = [{count: "2", type: "item"}]
    items_by_name = {"third" => {count: "3", type: "item"}}
    choice = {count: "4", type: "item"}
    model = Container.new(item: item, items: items, items_by_name: items_by_name, choice: choice)

    assert_same(item, model.item)
    assert_same(items, model.items)
    assert_same(items_by_name, model.items_by_name)
    assert_same(choice, model[:choice])
    assert_same(item, model[:item])
    assert_same(items, model.to_h.fetch(:items))
    assert_equal("item", model.to_h.fetch(:item).fetch(:type))
  end

  def test_assignment_replaces_the_shared_raw_value
    model = Container.new(item: {count: "1", type: "item"})
    replacement = {count: "2", type: "item"}

    model.item = replacement

    assert_same(replacement, model.item)
    assert_same(replacement, model[:item])
    assert_same(replacement, model.to_h.fetch(:item))
  end

  def test_deep_to_h_recurses_without_materializing_request_values
    raw = {
      item: {count: "1", type: "item"},
      items: [{count: "2", type: "item"}],
      items_by_name: {"third" => {count: "3", type: "item"}}
    }
    model = Container.new(**raw)

    assert_equal(raw, model.deep_to_h)
    assert_instance_of(Hash, model.deep_to_h.fetch(:item))
    assert_instance_of(Hash, model.deep_to_h.fetch(:items).fetch(0))
    assert_instance_of(Hash, model.deep_to_h.dig(:items_by_name, "third"))
  end

  def test_generated_params_support_nested_fetch_chains_on_raw_discriminators
    input = [{content: "hello", role: "user", type: "message"}]
    params = OpenAI::Responses::ResponseCreateParams.new(input: input, model: "gpt-4o")

    assert_equal("message", params.to_h.fetch(:input).fetch(0).fetch(:type))
    assert_same(input, params.input)
    assert_same(input, params[:input])
    assert_same(input, params.to_h.fetch(:input))
  end

  def test_beta_params_have_the_same_raw_value_contract
    input = [{content: "hello", role: "user", type: "message"}]
    params = OpenAI::Beta::ResponseCreateParams.new(input: input, model: "gpt-4o")

    assert_equal("message", params.to_h.fetch(:input).fetch(0).fetch(:type))
    assert_same(input, params.input)
    assert_same(input, params.to_h.fetch(:input))
  end

  def test_request_dump_observes_mutations_to_shared_nested_values
    input = [{content: "before", role: "user", type: "message"}]
    params = OpenAI::Responses::ResponseCreateParams.new(input: input, model: "gpt-4o")

    input.fetch(0)[:content] = "after"
    input << {content: "second", role: "user", type: "message"}
    dumped, = OpenAI::Responses::ResponseCreateParams.dump_request(params)

    assert_same(input, params.to_h.fetch(:input))
    assert_equal(%w[after second], dumped.fetch(:input).map { _1.fetch(:content) })
    assert_equal(2, dumped.fetch(:input).size)
  end

  def test_response_coercion_preserves_symbolized_enum_and_const_values
    message = coerce_response_output_message

    assert_equal(:assistant, message.role)
    assert_equal(:assistant, message[:role])
    assert_equal(:message, message.type)
    assert_equal(:message, message.to_h.fetch(:type))
    assert_equal(:completed, message.status)
  end

  def test_parsed_response_equality_and_hash_use_parsed_values
    parsed = coerce_response_output_message
    symbolic = OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_123",
      content: [],
      role: :assistant,
      status: :completed,
      type: :message
    )
    stringly = OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_123",
      content: [],
      role: "assistant",
      status: "completed",
      type: "message"
    )

    assert_equal(symbolic, parsed)
    assert_equal(symbolic.hash, parsed.hash)
    refute_equal(stringly, parsed)
    refute_equal(stringly.hash, parsed.hash)
  end

  def test_response_coercion_materializes_nested_models
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    envelope = OpenAI::Internal::Type::Converter.coerce(
      Envelope,
      {message: response_output_message_payload},
      state: state
    )

    assert_instance_of(OpenAI::Responses::ResponseOutputMessage, envelope.message)
    assert_same(envelope.message, envelope.to_h.fetch(:message))
    assert_equal(:message, envelope.message[:type])
    assert_nil(state.fetch(:error))
  end

  private

  def coerce_response_output_message
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    message = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Responses::ResponseOutputMessage,
      response_output_message_payload,
      state: state
    )

    assert_nil(state.fetch(:error))
    message
  end

  def response_output_message_payload
    {
      id: "msg_123",
      content: [],
      role: "assistant",
      status: "completed",
      type: "message"
    }
  end
end
