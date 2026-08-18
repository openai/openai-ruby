# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::UnionStateTest < Minitest::Test
  module FailedFirstUnion
    extend OpenAI::Internal::Type::Union

    variant Integer
    variant const: :inf
  end

  module FailedLastUnion
    extend OpenAI::Internal::Type::Union

    variant const: :inf
    variant Integer
  end

  class TaggedValue < OpenAI::Internal::Type::BaseModel
    required :type, const: :tagged
  end

  module DiscriminatedUnion
    extend OpenAI::Internal::Type::Union

    discriminator :type
    variant :tagged, TaggedValue
  end

  class InexactIntegerValue < OpenAI::Internal::Type::BaseModel
    required :value, Integer
  end

  class ExactStringValue < OpenAI::Internal::Type::BaseModel
    required :value, String
  end

  module RankedValueUnion
    extend OpenAI::Internal::Type::Union

    variant InexactIntegerValue
    variant ExactStringValue
  end

  class PartiallyInvalidValue < OpenAI::Internal::Type::BaseModel
    required :coerced, Integer
    required :invalid, Integer
  end

  module SelectedErrorUnion
    extend OpenAI::Internal::Type::Union

    variant PartiallyInvalidValue
    variant Float
  end

  def test_coerce_with_error_isolates_each_attempt
    previous_error = RuntimeError.new("previous")
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    state[:error] = previous_error

    value, error = OpenAI::Internal::Type::Converter.coerce_with_error(Integer, "one", state: state)

    assert_equal("one", value)
    assert_instance_of(ArgumentError, error)
    assert_same(previous_error, state.fetch(:error))

    value, error = OpenAI::Internal::Type::Converter.coerce_with_error(Integer, "1", state: state)

    assert_equal(1, value)
    assert_nil(error)
    assert_same(previous_error, state.fetch(:error))
  end

  def test_rejected_variant_errors_do_not_poison_the_selected_variant
    cases = [
      [FailedFirstUnion, :inf, :inf],
      [FailedFirstUnion, "inf", :inf],
      [FailedLastUnion, "other", "other"]
    ]

    cases.each do |target, input, expected|
      state = OpenAI::Internal::Type::Converter.new_coerce_state

      assert_equal(expected, OpenAI::Internal::Type::Converter.coerce(target, input, state: state))
      assert_nil(state.fetch(:error))
    end
  end

  def test_successful_union_preserves_an_error_from_its_parent
    previous_error = RuntimeError.new("previous")
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    state[:error] = previous_error

    coerced = OpenAI::Internal::Type::Converter.coerce(FailedFirstUnion, :inf, state: state)

    assert_equal(:inf, coerced)
    assert_same(previous_error, state.fetch(:error))
  end

  def test_selected_variant_preserves_its_own_error
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    state[:error] = RuntimeError.new("previous")

    coerced = OpenAI::Internal::Type::Converter.coerce(
      SelectedErrorUnion,
      {coerced: "1", invalid: "invalid"},
      state: state
    )

    assert_instance_of(PartiallyInvalidValue, coerced)
    assert_instance_of(ArgumentError, state.fetch(:error))
    assert_match(/invalid/, state.fetch(:error).message)
  end

  def test_discriminated_coercion_preserves_strictness
    discriminators = [
      {type: :tagged},
      {type: "tagged"},
      {"type" => :tagged},
      {"type" => "tagged"}
    ]

    discriminators.each do |input|
      state = OpenAI::Internal::Type::Converter.new_coerce_state

      OpenAI::Internal::Type::Converter.coerce(DiscriminatedUnion, input, state: state)
      selected = OpenAI::Internal::Type::Converter.coerce(
        RankedValueUnion,
        {value: "1"},
        state: state
      )

      assert_equal(true, state.fetch(:strictness))
      assert_instance_of(ExactStringValue, selected)
      assert_nil(state.fetch(:error))
    end
  end
end
