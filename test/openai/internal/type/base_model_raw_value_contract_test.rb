# frozen_string_literal: true

require_relative "../../test_helper"

# These tests protect the public raw-value contract of BaseModel. Typed accessors may
# coerce nested values, but #[], #to_h, and #deep_to_h must continue to expose the data
# supplied by the caller or returned by the API.
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

  def test_constructor_keeps_raw_nested_hash_while_accessor_returns_typed_model
    raw_item = {count: "1", type: "item"}
    container = Container.new(item: raw_item)

    assert_same(raw_item, container[:item])
    assert_same(raw_item, container.to_h.fetch(:item))
    assert_equal("item", container.to_h.fetch(:item).fetch(:type))

    assert_instance_of(Item, container.item)
    assert_equal(1, container.item.count)
    assert_equal(:item, container.item.type)
  end

  def test_assignment_keeps_raw_nested_hash_while_replacing_typed_accessor_value
    container = Container.new(item: {count: "1", type: "item"})
    replacement = {count: "2", type: "item"}

    container.item = replacement

    assert_same(replacement, container[:item])
    assert_same(replacement, container.to_h.fetch(:item))
    assert_equal("item", container.to_h.fetch(:item).fetch(:type))
    assert_instance_of(Item, container.item)
    assert_equal(2, container.item.count)
  end

  def test_converter_coerce_keeps_raw_nested_hash_while_accessor_returns_typed_model
    raw_item = {count: "1", type: "item"}
    state = OpenAI::Internal::Type::Converter.new_coerce_state

    container = OpenAI::Internal::Type::Converter.coerce(
      Container,
      {item: raw_item},
      state: state
    )

    assert_same(raw_item, container[:item])
    assert_same(raw_item, container.to_h.fetch(:item))
    assert_equal("item", container.to_h.dig(:item, :type))
    assert_instance_of(Item, container.item)
    assert_equal(1, container.item.count)
    assert_nil(state.fetch(:error))
  end

  def test_array_and_map_accessors_are_typed_without_replacing_raw_collections
    raw_items = [{count: "1", type: "item"}]
    raw_items_by_name = {"first" => {count: "2", type: "item"}}
    container = Container.new(items: raw_items, items_by_name: raw_items_by_name)

    assert_same(raw_items, container.to_h.fetch(:items))
    assert_same(raw_items_by_name, container.to_h.fetch(:items_by_name))
    assert_equal("item", container.to_h.dig(:items, 0, :type))
    assert_equal("item", container.to_h.dig(:items_by_name, "first", :type))

    assert_instance_of(Item, container.items.fetch(0))
    assert_equal(1, container.items.fetch(0).count)
    assert_instance_of(Item, container.items_by_name.fetch(:first))
    assert_equal(2, container.items_by_name.fetch(:first).count)
  end

  def test_deep_to_h_recurses_through_raw_values_without_materializing_models
    raw = {
      item: {count: "1", type: "item"},
      items: [{count: "2", type: "item"}],
      items_by_name: {"third" => {count: "3", type: "item"}}
    }
    container = Container.new(**raw)

    assert_equal(raw, container.deep_to_h)
    assert_instance_of(Hash, container.deep_to_h.fetch(:item))
    assert_instance_of(Hash, container.deep_to_h.fetch(:items).fetch(0))
    assert_instance_of(Hash, container.deep_to_h.dig(:items_by_name, "third"))
  end

  def test_generated_params_support_nested_fetch_chains_on_raw_discriminators
    input = [{content: "hello", role: "user", type: "message"}]
    params = OpenAI::Responses::ResponseCreateParams.new(input: input)

    assert_equal("message", params.to_h.fetch(:input).fetch(0).fetch(:type))
    assert_same(input, params[:input])
    assert_same(input, params.to_h.fetch(:input))
    assert_instance_of(OpenAI::Responses::EasyInputMessage, params.input.fetch(0))
    assert_equal(:message, params.input.fetch(0).type)
  end

  def test_generated_beta_params_have_the_same_raw_value_contract
    input = [{content: "hello", role: "user", type: "message"}]
    params = OpenAI::Beta::ResponseCreateParams.new(input: input)

    assert_equal("message", params.to_h.fetch(:input).fetch(0).fetch(:type))
    assert_same(input, params[:input])
    assert_same(input, params.to_h.fetch(:input))
    assert_instance_of(OpenAI::Beta::BetaEasyInputMessage, params.input.fetch(0))
    assert_equal(:message, params.input.fetch(0).type)
  end

  def test_response_models_keep_raw_nested_payloads_while_accessors_materialize_models
    raw_output = {
      id: "msg_123",
      content: [],
      role: "assistant",
      status: "completed",
      type: "message"
    }
    response = OpenAI::Responses::Response.new(output: [raw_output])

    assert_same(raw_output, response.to_h.fetch(:output).fetch(0))
    assert_equal("message", response.to_h.dig(:output, 0, :type))
    assert_instance_of(OpenAI::Responses::ResponseOutputMessage, response.output.fetch(0))
    assert_equal(:message, response.output.fetch(0).type)
  end

  def test_mutating_raw_input_does_not_rewrite_the_typed_accessor_snapshot
    raw_item = {count: "1", type: "item"}
    container = Container.new(item: raw_item)

    raw_item[:count] = "99"
    raw_item[:future] = true

    assert_equal("99", container.to_h.dig(:item, :count))
    assert_equal(true, container.to_h.dig(:item, :future))
    assert_equal(1, container.item.count)
    refute(container.item.to_h.key?(:future))
  end

  def test_already_typed_nested_models_preserve_identity_in_both_views
    item = Item.new(count: 1, type: :item)
    container = Container.new(item: item)

    assert_same(item, container[:item])
    assert_same(item, container.to_h.fetch(:item))
    assert_same(item, container.item)
  end

  def test_failed_nested_conversion_keeps_raw_value_and_raises_from_accessor
    invalid = {count: "not-an-integer", type: "item"}
    container = Container.new(item: invalid)

    assert_same(invalid, container[:item])
    assert_same(invalid, container.to_h.fetch(:item))
    assert_raises(OpenAI::Errors::ConversionError) { container.item }
  end

  def test_primitive_union_accessor_converts_without_replacing_raw_value
    container = Container.new(choice: "42")

    assert_equal("42", container[:choice])
    assert_equal("42", container.to_h.fetch(:choice))
    assert_equal(42, container.choice)
  end

  def test_yaml_round_trip_preserves_raw_and_typed_views
    raw_item = {count: "1", type: "item"}
    copy = YAML.unsafe_load(YAML.dump(Container.new(item: raw_item)))

    assert_equal(raw_item, copy.to_h.fetch(:item))
    assert_equal("item", copy.to_h.dig(:item, :type))
    assert_instance_of(Item, copy.item)
    assert_equal(1, copy.item.count)
    assert_equal(:item, copy.item.type)
  end

  def test_yaml_from_before_the_converted_cache_remains_readable_and_assignable
    legacy_yaml = <<~YAML
      --- !ruby/object:OpenAI::Test::BaseModelRawValueContractTest::Container
      data:
        :item: !ruby/object:OpenAI::Test::BaseModelRawValueContractTest::Item
          data:
            :count: 1
            :type: :item
          coerced:
            :count: true
            :type: true
      coerced:
        :item: true
    YAML

    container = YAML.unsafe_load(legacy_yaml)

    assert_instance_of(Item, container.item)
    assert_equal(1, container.item.count)

    replacement = {count: "2", type: "item"}
    container.item = replacement

    assert_same(replacement, container.to_h.fetch(:item))
    assert_instance_of(Item, container.item)
    assert_equal(2, container.item.count)
  end

  def test_request_dump_uses_typed_nested_value_without_changing_raw_params
    grader = {
      input: [{content: "hello", role: "user"}],
      model: "gpt-4o",
      name: "score"
    }
    params = OpenAI::FineTuning::Alpha::GraderValidateParams.new(grader: grader)

    dumped, = OpenAI::FineTuning::Alpha::GraderValidateParams.dump_request(params)

    assert_same(grader, params.to_h.fetch(:grader))
    assert_instance_of(OpenAI::Graders::ScoreModelGrader, params.grader)
    assert_equal(:score_model, dumped.dig(:grader, :type))
    assert_equal("user", params.to_h.dig(:grader, :input, 0, :role))
    assert_equal(:user, dumped.dig(:grader, :input, 0, :role))
  end

  def test_request_dump_translates_nested_api_names_without_changing_raw_params
    text = {format_: {type: "text"}}
    params = OpenAI::Responses::ResponseCreateParams.new(
      input: "hello",
      model: "gpt-4o",
      text: text
    )

    dumped, = OpenAI::Responses::ResponseCreateParams.dump_request(params)

    assert_same(text, params.to_h.fetch(:text))
    assert_equal("text", params.to_h.dig(:text, :format_, :type))
    assert_equal("text", dumped.dig(:text, :format, :type))
    refute(dumped.fetch(:text).key?(:format_))
  end
end
