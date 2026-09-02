# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputRecursiveRefsTest < Minitest::Test
  class RecursivePlain < OpenAI::BaseModel
    required :name, String
    required :child, -> { RecursivePlain }
  end

  class RecursiveNilable < OpenAI::BaseModel
    required :name, String
    required :child, -> { RecursiveNilable }, nil?: true
  end

  class RecursiveDocumented < OpenAI::BaseModel
    required :name, String
    required :child, -> { RecursiveDocumented }, doc: "Next node"
  end

  class RecursiveNilableDocumented < OpenAI::BaseModel
    required :name, String
    required :child, -> { RecursiveNilableDocumented }, nil?: true, doc: "Optional next node"
  end

  class MutualLeft < OpenAI::BaseModel
    required :right, -> { MutualRight }, nil?: true
  end

  class MutualRight < OpenAI::BaseModel
    required :left, -> { MutualLeft }, nil?: true
  end

  def test_recursive_model_references_are_finite_and_resolvable
    schemas = [
      RecursivePlain,
      RecursiveNilable,
      RecursiveDocumented,
      RecursiveNilableDocumented
    ].to_h { [_1, round_trip_schema(_1)] }

    schemas.each_value { assert_resolvable_refs(_1) }

    assert_equal(
      {"$ref" => "#/$defs/"},
      schemas.fetch(RecursivePlain).dig("$defs", "", "properties", "child")
    )
    assert_equal(
      [{"$ref" => "#/$defs/"}, {"type" => "null"}],
      schemas.fetch(RecursiveNilable).dig("$defs", "", "properties", "child", "anyOf")
    )
    assert_equal(
      {"$ref" => "#/$defs/", "description" => "Next node"},
      schemas.fetch(RecursiveDocumented).dig("$defs", "", "properties", "child")
    )

    documented_nilable = schemas
      .fetch(RecursiveNilableDocumented)
      .dig("$defs", "", "properties", "child")
    assert_equal("Optional next node", documented_nilable.fetch("description"))
    assert_equal(
      [{"$ref" => "#/$defs/"}, {"type" => "null"}],
      documented_nilable.fetch("anyOf")
    )
  end

  def test_mutual_nilable_references_are_finite_and_resolvable
    schema = round_trip_schema(MutualLeft)

    assert_resolvable_refs(schema)
    assert_nullable_property(schema, "right")
    assert_nullable_property(schema, "left")
  end

  private

  def round_trip_schema(model) = JSON.parse(JSON.generate(model.to_json_schema))

  def assert_resolvable_refs(schema)
    refs = collect_hashes(schema).filter_map { _1["$ref"] }

    refute_empty(refs)
    refs.each do |ref|
      assert_equal("#", ref[0])
      assert(resolve_local_ref(schema, ref), "Expected #{ref} to resolve")
    end
  end

  def assert_nullable_property(schema, property)
    property_schema = collect_hashes(schema)
      .filter_map { _1.fetch("properties", {})[property] }
      .first

    refute_nil(property_schema)
    assert_includes(property_schema.fetch("anyOf"), {"type" => "null"})
  end

  def collect_hashes(value)
    case value
    in Hash
      [value, *value.values.flat_map { collect_hashes(_1) }]
    in Array
      value.flat_map { collect_hashes(_1) }
    else
      []
    end
  end

  def resolve_local_ref(schema, ref)
    pointer = URI::RFC2396_PARSER.unescape(ref.delete_prefix("#/"))
    pointer.split("/", -1).reduce(schema) do |value, token|
      value.fetch(token.gsub("~1", "/").gsub("~0", "~"))
    end
  end
end
