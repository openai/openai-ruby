# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::BaseModelNilabilityTest < Minitest::Test
  class Fields < OpenAI::Internal::Type::BaseModel
    required :nullable, Integer, nil?: true
    optional :optional, Integer
    optional :optional_nullable, Integer, nil?: true
  end

  class UnknownFields < OpenAI::Internal::Type::BaseModel
    required :required_value, OpenAI::Internal::Type::Unknown
    optional :optional_value, OpenAI::Internal::Type::Unknown, nil?: true
  end

  def test_constructor_accepts_explicit_nil_only_for_nullable_fields
    model = Fields.new(nullable: nil, optional_nullable: nil)

    assert_nil(model.nullable)
    assert_nil(model.optional_nullable)
    assert_nil(model[:nullable])
    assert_nil(model.to_h.fetch(:optional_nullable))
  end

  def test_constructor_distinguishes_omitted_optional_from_explicit_nil
    omitted = Fields.new(nullable: nil)

    assert_nil(omitted.optional)
    refute(omitted.to_h.key?(:optional))

    explicit = Fields.new(nullable: nil, optional: nil)

    assert_nil(explicit[:optional])
    assert_nil(explicit.to_h.fetch(:optional))
    error = assert_raises(OpenAI::Errors::ConversionError) { explicit.optional }
    assert_instance_of(TypeError, error.cause)
  end

  def test_constructor_treats_only_the_nil_singleton_as_nullable_nil
    value = {"nil?" => true, "effort" => "high"}
    value.define_singleton_method(:nil?) { true }
    params = OpenAI::Responses::InputTokenCountParams.new(reasoning: value)

    assert_same(value, params[:reasoning])
    assert_same(value, params.to_h.fetch(:reasoning))

    dumped, = OpenAI::Responses::InputTokenCountParams.dump_request(params)
    assert_equal({nil?: true, effort: "high"}, dumped.fetch(:reasoning))
    assert_equal(
      {"reasoning" => {"nil?" => true, "effort" => "high"}},
      JSON.parse(JSON.generate(dumped))
    )
  end

  def test_response_coercion_accepts_explicit_nullable_nil_without_an_error
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    model = OpenAI::Internal::Type::Converter.coerce(
      Fields,
      {nullable: nil, optional_nullable: nil},
      state: state
    )

    assert_nil(model.nullable)
    assert_nil(model.optional_nullable)
    assert_nil(state.fetch(:error))
  end

  def test_response_coercion_keeps_optional_nil_as_an_inexact_match
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    model = OpenAI::Internal::Type::Converter.coerce(
      Fields,
      {nullable: nil, optional: nil},
      state: state
    )

    assert_nil(model[:optional])
    assert_nil(model.optional)
    assert_nil(state.fetch(:error))
    assert_equal({yes: 3, no: 0, maybe: 1}, state.fetch(:exactness))
  end

  def test_response_coercion_does_not_dispatch_nil_query_for_unknown_values
    calls = 0
    value = Object.new
    value.define_singleton_method(:nil?) do
      calls += 1
      raise "should not dispatch nil?"
    end

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    model = OpenAI::Internal::Type::Converter.coerce(
      UnknownFields,
      {required_value: value, optional_value: value},
      state: state
    )

    assert_same(value, model.required_value)
    assert_same(value, model.optional_value)
    assert_equal(0, calls)
    assert_nil(state.fetch(:error))
  end

  def test_nil_class_coercion_does_not_dispatch_nil_query
    calls = 0
    value = Object.new
    value.define_singleton_method(:nil?) do
      calls += 1
      raise "should not dispatch nil?"
    end

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    assert_nil(OpenAI::Internal::Type::Converter.coerce(NilClass, value, state: state))
    assert_equal(0, calls)
    assert_equal({yes: 0, no: 0, maybe: 1}, state.fetch(:exactness))
  end
end
