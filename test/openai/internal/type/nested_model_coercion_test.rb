# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::NestedModelCoercionTest < Minitest::Test
  class Item < OpenAI::Internal::Type::BaseModel
    required :a, Integer
    required :b, Integer
  end

  module ItemOrInteger
    extend OpenAI::Internal::Type::Union

    variant Integer
    variant Item
  end

  module ReversedItemOrInteger
    extend OpenAI::Internal::Type::Union

    variant Item
    variant Integer
  end

  class Container < OpenAI::Internal::Type::BaseModel
    optional :item, Item
    optional :items, OpenAI::Internal::Type::ArrayOf[Item]
    optional :map, OpenAI::Internal::Type::HashOf[Item]
    optional :nullable_items, OpenAI::Internal::Type::ArrayOf[Item, nil?: true]
    optional :nullable_map, OpenAI::Internal::Type::HashOf[Item, nil?: true]
    optional :choice, ItemOrInteger
    optional :reversed_choice, ReversedItemOrInteger
  end

  class NullableContainer < OpenAI::Internal::Type::BaseModel
    optional :optional_item, Item
    required :nullable_item, Item, nil?: true
  end

  def test_constructor_and_assignment_cache_coerced_models_separately_from_raw_values
    item = {a: "1", b: "2"}
    items = [{a: "3", b: "4"}]
    model = Container.new(item: item, items: items)

    assert_instance_of(Item, model.item)
    assert_instance_of(Item, model.items.fetch(0))
    assert_same(item, model[:item])
    assert_same(items, model[:items])
    assert_same(item, model.to_h.fetch(:item))
    assert_same(items, model.to_h.fetch(:items))
    assert_equal([1, 2], [model.item.a, model.item.b])
    assert_equal([3, 4], [model.items.fetch(0).a, model.items.fetch(0).b])

    item = {a: "5", b: "6"}
    items = [{a: "7", b: "8"}]
    model.item = item
    model.items = items

    assert_instance_of(Item, model.item)
    assert_instance_of(Item, model.items.fetch(0))
    assert_same(item, model[:item])
    assert_same(items, model[:items])
    assert_same(item, model.to_h.fetch(:item))
    assert_same(items, model.to_h.fetch(:items))
    assert_equal([5, 6], [model.item.a, model.item.b])
    assert_equal([7, 8], [model.items.fetch(0).a, model.items.fetch(0).b])
  end

  def test_constructor_and_assignment_coerce_nested_maps_and_unions
    map = {"first" => {a: "1", b: "2"}}
    choice = {a: "3", b: "4"}
    model = Container.new(map: map, choice: choice, reversed_choice: choice)

    assert_instance_of(Item, model.map.fetch(:first))
    assert_instance_of(Item, model.choice)
    assert_instance_of(Item, model.reversed_choice)
    assert_equal([1, 2], [model.map.fetch(:first).a, model.map.fetch(:first).b])
    assert_equal([3, 4], [model.choice.a, model.choice.b])

    model.map = {"second" => {a: "5", b: "6"}}
    model.choice = {a: "7", b: "8"}
    model.reversed_choice = {a: "9", b: "10"}

    assert_instance_of(Item, model.map.fetch(:second))
    assert_instance_of(Item, model.choice)
    assert_instance_of(Item, model.reversed_choice)
    assert_equal(
      {
        map: {"second" => {a: "5", b: "6"}},
        choice: {a: "7", b: "8"},
        reversed_choice: {a: "9", b: "10"}
      },
      model.deep_to_h
    )
    assert_equal("5", JSON.parse(model.to_json).dig("map", "second", "a"))
  end

  def test_setter_preserves_already_coerced_nested_model_identity
    item = Item.new(a: 1, b: 2)
    items = [item]
    map = {item: item}
    model = Container.new(item: item, items: items, map: map)

    assert_same(item, model.item)
    assert_same(items, model.items)
    assert_same(item, model.items.fetch(0))
    assert_same(map, model.map)
    assert_same(item, model.map.fetch(:item))
  end

  def test_setter_preserves_nullable_collection_identity
    item = Item.new(a: 1, b: 2)
    items = [item, nil]
    map = {item: item, empty: nil}
    model = Container.new(nullable_items: items, nullable_map: map)

    assert_same(items, model.nullable_items)
    assert_same(map, model.nullable_map)
  end

  def test_constructor_and_assignment_accept_nil_for_optional_and_nilable_models
    model = NullableContainer.new(optional_item: nil, nullable_item: nil)

    assert_nil(model.optional_item)
    assert_nil(model.nullable_item)
    assert_equal({optional_item: nil, nullable_item: nil}, model.to_h)

    model.optional_item = Item.new(a: 1, b: 2)
    model.nullable_item = Item.new(a: 3, b: 4)
    model.optional_item = nil
    model.nullable_item = nil

    assert_nil(model.optional_item)
    assert_nil(model.nullable_item)
    assert_equal({optional_item: nil, nullable_item: nil}, model.to_h)
  end

  def test_coerce_preserves_already_coerced_model_identity
    model = Item.new(a: 1, b: 2)
    state = OpenAI::Internal::Type::Converter.new_coerce_state

    assert_same(model, OpenAI::Internal::Type::Converter.coerce(Item, model, state: state))
  end

  def test_successful_nested_coercion_isolated_from_raw_input_mutation
    item = {a: "1", b: "2"}
    items = [{a: "3", b: "4"}]
    map = {item: {a: "5", b: "6"}}
    model = Container.new(item: item, items: items, map: map)

    item[:a] = "changed"
    items.fetch(0)[:a] = "changed"
    items << {a: "changed", b: "changed"}
    map.fetch(:item)[:a] = "changed"
    map[:later] = {a: "changed", b: "changed"}

    assert_equal(1, model.item.a)
    assert_equal(3, model.items.fetch(0).a)
    assert_equal(1, model.items.size)
    assert_equal(5, model.map.fetch(:item).a)
    refute(model.map.key?(:later))
    assert_equal("changed", model.to_h.fetch(:item).fetch(:a))
    assert_equal(2, model.to_h.fetch(:items).size)
    assert(model.to_h.fetch(:map).key?(:later))
  end

  def test_nested_model_equality_and_hash_use_stored_raw_values
    left = Container.new(item: {a: "1", b: "2"}, items: [{a: "3", b: "4"}])
    right = Container.new(item: {a: "1", b: "2"}, items: [{a: "3", b: "4"}])

    assert_equal(left, right)
    assert_equal(left.hash, right.hash)

    refute_equal(left, Container.new(item: {a: 1, b: 2}, items: [{a: 3, b: 4}]))
  end

  def test_failed_nested_model_coercion_preserves_input_and_error
    item = {a: "one", b: "2"}
    items = [{a: "1", b: "two"}]
    model = Container.new(item: item, items: items)

    assert_same(item, model.to_h.fetch(:item))
    assert_same(items, model.to_h.fetch(:items))
    assert_raises(OpenAI::Errors::ConversionError) { model.item }
    assert_raises(OpenAI::Errors::ConversionError) { model.items }
  end

  def test_assignment_replaces_previous_success_and_error_status
    valid = {a: "1", b: "2"}
    invalid = {a: "one", b: "2"}
    model = Container.new

    model.item = valid
    assert_instance_of(Item, model.item)
    model.item = invalid
    assert_same(invalid, model.to_h.fetch(:item))
    assert_raises(OpenAI::Errors::ConversionError) { model.item }
    model.item = valid
    assert_instance_of(Item, model.item)

    model.items = [valid]
    assert_instance_of(Item, model.items.fetch(0))
    invalid_items = [invalid]
    model.items = invalid_items
    assert_same(invalid_items, model.to_h.fetch(:items))
    assert_raises(OpenAI::Errors::ConversionError) { model.items }
    model.items = [valid]
    assert_instance_of(Item, model.items.fetch(0))

    model.map = {valid: valid}
    assert_instance_of(Item, model.map.fetch(:valid))
    invalid_map = {invalid: invalid}
    model.map = invalid_map
    assert_same(invalid_map, model.to_h.fetch(:map))
    assert_raises(OpenAI::Errors::ConversionError) { model.map }
    model.map = {valid: valid}
    assert_instance_of(Item, model.map.fetch(:valid))

    model.choice = valid
    assert_instance_of(Item, model.choice)
    model.choice = invalid
    assert_same(invalid, model.to_h.fetch(:choice))
    assert_raises(OpenAI::Errors::ConversionError) { model.choice }
    model.choice = valid
    assert_instance_of(Item, model.choice)
  end

  def test_composite_coercion_errors_do_not_depend_on_field_or_item_order
    valid = {a: "1", b: "2"}
    invalid_values = [{a: "one", b: "2"}, {a: "1", b: "two"}]

    invalid_values.each do |invalid|
      [[invalid, valid], [valid, invalid]].each do |items|
        map = items.each_with_index.to_h { |value, index| [index, value] }
        model = Container.new(item: invalid, items: items, map: map)

        assert_same(invalid, model.to_h.fetch(:item))
        assert_same(items, model.to_h.fetch(:items))
        assert_same(map, model.to_h.fetch(:map))
        assert_raises(OpenAI::Errors::ConversionError) { model.item }
        assert_raises(OpenAI::Errors::ConversionError) { model.items }
        assert_raises(OpenAI::Errors::ConversionError) { model.map }
      end
    end
  end

  def test_rejected_union_variant_does_not_override_selected_coercion
    model = Container.new(choice: "1", reversed_choice: "2")

    assert_equal(1, model.choice)
    assert_equal("1", model.to_h.fetch(:choice))
    assert_equal(2, model.reversed_choice)
    assert_equal("2", model.to_h.fetch(:reversed_choice))
  end

  def test_selected_union_variant_preserves_its_conversion_error
    choice = {a: "one", b: "2"}
    reversed_choice = {a: "1", b: "two"}
    model = Container.new(choice: choice, reversed_choice: reversed_choice)

    assert_same(choice, model.to_h.fetch(:choice))
    assert_same(reversed_choice, model.to_h.fetch(:reversed_choice))
    assert_raises(OpenAI::Errors::ConversionError) { model.choice }
    assert_raises(OpenAI::Errors::ConversionError) { model.reversed_choice }
  end
end
