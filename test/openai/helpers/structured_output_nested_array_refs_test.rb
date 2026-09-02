# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputNestedArrayRefsTest < Minitest::Test
  Inner = OpenAI::ArrayOf[Integer]
  Outer = OpenAI::ArrayOf[Inner]

  class ReusedArrays < OpenAI::BaseModel
    required :nested_one, Outer
    required :nested_two, Outer
    required :flat, Inner
  end

  def test_reused_nested_and_flat_arrays_keep_distinct_schema_dimensions
    expected = {
      :$defs => {
        ".nested_one" => {
          type: "array",
          items: {:$ref => "#/$defs/.nested_one~1%5B%5D"}
        },
        ".nested_one/[]" => {
          type: "array",
          items: {type: "integer"}
        }
      },
      :type => "object",
      :properties => {
        nested_one: {:$ref => "#/$defs/.nested_one"},
        nested_two: {:$ref => "#/$defs/.nested_one"},
        flat: {:$ref => "#/$defs/.nested_one~1%5B%5D"}
      },
      :required => %w[nested_one nested_two flat],
      :additionalProperties => false
    }

    assert_equal(expected, ReusedArrays.to_json_schema)
    assert_equal(expected, ReusedArrays.to_json_schema)
  end
end
