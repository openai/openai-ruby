# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::NullableCollectionTest < Minitest::Test
  ARRAY = OpenAI::Internal::Type::ArrayOf[Integer]
  NULLABLE_ARRAY = OpenAI::Internal::Type::ArrayOf[Integer, nil?: true]
  HASH = OpenAI::Internal::Type::HashOf[Integer]
  NULLABLE_HASH = OpenAI::Internal::Type::HashOf[Integer, nil?: true]

  class CollectionUnion
    include OpenAI::Internal::Type::Union

    def initialize(*variants) = variants.each { variant(_1) }
  end

  def test_nullable_array_matcher_agrees_with_coercion
    assert_match_after_coercion(NULLABLE_ARRAY, [1, nil])
    assert(NULLABLE_ARRAY === [1, nil])
    refute(NULLABLE_ARRAY === [1, "one"])
  end

  def test_nullable_hash_matcher_agrees_with_coercion_for_supported_keys
    [{one: 1, none: nil}, {"one" => 1, "none" => nil}].each do |value|
      assert_match_after_coercion(NULLABLE_HASH, value)
      assert(NULLABLE_HASH === value)
    end

    refute(NULLABLE_HASH === {1 => nil})
  end

  def test_non_nullable_matchers_keep_rejecting_nil_elements
    assert(ARRAY === [1])
    refute(ARRAY === [1, nil])
    assert(HASH === {one: 1})
    assert(HASH === {"one" => 1})
    refute(HASH === {one: nil})
    refute(HASH === {"one" => nil})

    assert(OpenAI::Internal::Type::ArrayOf[NilClass] === [nil])
    assert(OpenAI::Internal::Type::HashOf[NilClass] === {none: nil})
  end

  def test_nullable_elements_do_not_make_the_collection_nullable
    [NULLABLE_ARRAY, NULLABLE_HASH].each do |type|
      state = OpenAI::Internal::Type::Converter.new_coerce_state

      refute(type === nil)
      assert_nil(OpenAI::Internal::Type::Converter.coerce(type, nil, state: state))
      assert_equal({yes: 0, no: 1, maybe: 0}, state.fetch(:exactness))
      assert_instance_of(TypeError, state.fetch(:error))
    end
  end

  def test_inspect_equality_and_hash_include_element_nullability
    assert_equal("OpenAI::Internal::Type::ArrayOf[Integer]", ARRAY.inspect)
    assert_equal("OpenAI::Internal::Type::ArrayOf[Integer | nil]", NULLABLE_ARRAY.inspect)
    assert_equal("OpenAI::Internal::Type::HashOf[Integer]", HASH.inspect)
    assert_equal("OpenAI::Internal::Type::HashOf[Integer | nil]", NULLABLE_HASH.inspect)

    refute_equal(ARRAY, NULLABLE_ARRAY)
    refute_equal(ARRAY.hash, NULLABLE_ARRAY.hash)
    refute_equal(HASH, NULLABLE_HASH)
    refute_equal(HASH.hash, NULLABLE_HASH.hash)
  end

  def test_union_dump_selects_nullable_array_variant_only_when_it_precedes_fallback
    nullable = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::FileInput, nil?: true]
    fallback = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]
    value = [nil, StringIO.new("contents")]

    selected = dump_union(CollectionUnion.new(nullable, fallback), value)
    assert_nil(selected.fetch(0))
    assert_instance_of(OpenAI::FilePart, selected.fetch(1))

    fallback_selected = dump_union(CollectionUnion.new(fallback, nullable), value)
    assert_equal([nil, "contents"], fallback_selected)
  end

  def test_union_dump_selects_nullable_hash_variant_only_when_it_precedes_fallback
    nullable = OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::FileInput, nil?: true]
    fallback = OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]
    value = {none: nil, file: StringIO.new("contents")}

    selected = dump_union(CollectionUnion.new(nullable, fallback), value)
    assert_nil(selected.fetch(:none))
    assert_instance_of(OpenAI::FilePart, selected.fetch(:file))

    fallback_selected = dump_union(CollectionUnion.new(fallback, nullable), value)
    assert_equal({none: nil, file: "contents"}, fallback_selected)
  end

  private

  def assert_match_after_coercion(type, value)
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    coerced = OpenAI::Internal::Type::Converter.coerce(type, value, state: state)

    assert(type === coerced)
    assert_nil(state.fetch(:error))
  end

  def dump_union(union, value)
    OpenAI::Internal::Type::Converter.dump(union, value)
  end
end
