# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::CollectionStateTest < Minitest::Test
  class Item < OpenAI::Internal::Type::BaseModel
    required :value, Integer
  end

  def test_array_errors_do_not_depend_on_element_order
    inputs = [
      [{value: "invalid"}, {value: "1"}],
      [{value: "1"}, {value: "invalid"}]
    ]

    inputs.each do |input|
      value, state = coerce(OpenAI::Internal::Type::ArrayOf[Item], input)

      assert(value.all? { _1.is_a?(Item) })
      assert_instance_of(ArgumentError, state.fetch(:error))
      assert_match(/invalid/, state.fetch(:error).message)
      assert_equal({yes: 3, no: 1, maybe: 1}, state.fetch(:exactness))
    end
  end

  def test_hash_errors_do_not_depend_on_value_order
    inputs = [
      {invalid: {value: "invalid"}, valid: {value: "1"}},
      {valid: {value: "1"}, invalid: {value: "invalid"}}
    ]

    inputs.each do |input|
      value, state = coerce(OpenAI::Internal::Type::HashOf[Item], input)

      assert(value.values.all? { _1.is_a?(Item) })
      assert_instance_of(ArgumentError, state.fetch(:error))
      assert_match(/invalid/, state.fetch(:error).message)
      assert_equal({yes: 3, no: 1, maybe: 1}, state.fetch(:exactness))
    end
  end

  def test_collections_continue_after_failures_and_retain_the_last_failure
    cases = [
      [
        OpenAI::Internal::Type::ArrayOf[Item],
        [{value: "first"}, {value: "2"}, {value: "last"}]
      ],
      [
        OpenAI::Internal::Type::HashOf[Item],
        {first: {value: "first"}, valid: {value: "2"}, last: {value: "last"}}
      ]
    ]

    cases.each do |target, input|
      value, state = coerce(target, input)
      values = value.is_a?(Hash) ? value.values : value

      assert(values.all? { _1.is_a?(Item) })
      assert_instance_of(ArgumentError, state.fetch(:error))
      assert_match(/last/, state.fetch(:error).message)
      assert_equal({yes: 4, no: 2, maybe: 1}, state.fetch(:exactness))
    end
  end

  def test_collections_preserve_parent_errors_unless_an_element_fails
    cases = [
      [OpenAI::Internal::Type::ArrayOf[Item], [{value: "1"}], [{value: "invalid"}]],
      [OpenAI::Internal::Type::HashOf[Item], {item: {value: "1"}}, {item: {value: "invalid"}}]
    ]

    cases.each do |target, valid, invalid|
      parent_error = RuntimeError.new("parent")
      _, valid_state = coerce(target, valid, error: parent_error)

      assert_same(parent_error, valid_state.fetch(:error))

      _, invalid_state = coerce(target, invalid, error: parent_error)

      assert_instance_of(ArgumentError, invalid_state.fetch(:error))
      assert_match(/invalid/, invalid_state.fetch(:error).message)
    end
  end

  private

  def coerce(target, input, error: nil)
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    state[:error] = error
    value = OpenAI::Internal::Type::Converter.coerce(target, input, state: state)
    [value, state]
  end
end
