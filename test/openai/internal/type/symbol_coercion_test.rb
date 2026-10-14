# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::SymbolCoercionTest < Minitest::Test
  def test_json_strings_are_exact_matches_for_symbol_fields
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    assert_equal(:hello, OpenAI::Internal::Type::Converter.coerce(Symbol, "hello", state: state))
    assert_equal({yes: 1, no: 0, maybe: 0}, state[:exactness])
    assert_nil(state[:error])
    assert_equal(:hello, OpenAI::Internal::Type::Converter.coerce(Symbol, :hello))
  end

  def test_non_strings_are_not_coerced_to_symbols
    [1, [], {}, true, nil].each do |input|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_equal(input, OpenAI::Internal::Type::Converter.coerce(Symbol, input, state: state)) unless input.nil?
      assert_nil(OpenAI::Internal::Type::Converter.coerce(Symbol, input, state: state)) if input.nil?
      assert_equal(1, state[:exactness][:no])
    end
  end
end
