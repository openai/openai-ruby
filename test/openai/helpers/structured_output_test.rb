# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputTest < Minitest::Test
  def test_misuse
    test_cases = [
      OpenAI::Internal::Type::HashOf[String],
      Date,
      OpenAI::Helpers::StructuredOutput::ArrayOf[Time]
    ]

    test_cases.each do |input|
      assert_raises(ArgumentError) do
        OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema(input)
      end
    end
  end

  A1 = OpenAI::Helpers::StructuredOutput::ArrayOf[String]

  E1 = OpenAI::Helpers::StructuredOutput::EnumOf[:one]

  class M1 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, String, doc: "dog"
    required :b, Integer, nil?: true
    required :c, E1, nil?: true, doc: "dog"
    required :d, E1, doc: "dog"
  end

  class M2 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :type, const: :m2, doc: "Model M2"
  end

  class M3 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :type, const: :m3, doc: "Model M3"
  end

  U1 = OpenAI::Helpers::StructuredOutput::UnionOf[Integer, A1]
  U2 = OpenAI::Helpers::StructuredOutput::UnionOf[M2, M3]
  U3 = OpenAI::Helpers::StructuredOutput::UnionOf[A1, A1]

  def test_coerce
    cases = {
      [A1, [:one]] => [{yes: 2}, ["one"]],
      [E1, "one"] => [{yes: 1}, :one],
      [E1, 1] => [{no: 1}, 1],
      [U1, ["one"]] => [{yes: 2}, ["one"]],
      [U2, ["one"]] => [{no: 1}, ["one"]],
      [U2, {type: :m3}] => [{yes: 2}, M3]
    }
    cases.each do |lhs, rhs|
      target, input = lhs
      exactness, expect = rhs
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_pattern do
        coerced = OpenAI::Internal::Type::Converter.coerce(target, input, state: state)
        coerced => ^expect
        state.fetch(:exactness).filter { _2.nonzero? }.to_h => ^exactness
      end
    end
  end

  def test_base_model
    assert_raises(RuntimeError) do
      Class.new(OpenAI::Helpers::StructuredOutput::BaseModel) do
        optional :name, String
      end
    end
  end

  def test_to_schema
    cases = {
      NilClass => {type: "null"},
      Integer => {type: "integer"},
      Float => {type: "number"},
      String => {type: "string"},
      Symbol => {type: "string"},
      A1 => {type: "array", items: {type: "string"}},
      OpenAI::Helpers::StructuredOutput::ArrayOf[String, nil?: true, doc: "a1"] => {
        type: "array",
        items: {type: %w[string null], description: "a1"}
      },
      E1 => {type: "string", enum: ["one"]},
      M1 => {
        type: "object",
        properties: {
          a: {type: "string", description: "dog"},
          b: {type: %w[integer null]},
          c: {
            anyOf: [{type: "string", enum: ["one"]}, {type: "null"}],
            description: "dog"
          },
          d: {description: "dog", type: "string", enum: ["one"]}
        },
        required: %w[a b c d],
        additionalProperties: false
      },
      U1 => {
        anyOf: [
          {type: "integer"},
          {type: "array", items: {type: "string"}}
        ]
      },
      U2 => {
        anyOf: [
          {
            type: "object",
            properties: {type: {const: "m2"}},
            required: %w[type],
            additionalProperties: false
          },
          {
            type: "object",
            properties: {type: {const: "m3"}},
            required: %w[type],
            additionalProperties: false
          }
        ]
      }
    }
    cases.each do |input, expected|
      assert_pattern do
        schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema(input)
        assert_equal(expected, schema)
      end
    end
  end

  class M4 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, E1
    required :b, E1, nil?: true
    required :c, OpenAI::Helpers::StructuredOutput::ArrayOf[E1, nil?: true, doc: "nested"], nil?: true
  end

  A2 = OpenAI::Helpers::StructuredOutput::ArrayOf[E1, nil?: true]

  class M5 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, A2, nil?: true
    required :b, A2, nil?: true
  end

  class M6 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, String
    required :b, -> { M6 }
  end

  class M7 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, -> { M5 }
    required :b, M5
  end

  class M8 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, -> { M5 }
    required :b, M5, nil?: true
  end

  class M9 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, -> { M10 }
    required :b, -> { M10 }
  end

  class M10 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :b, -> { M9 }
  end

  class M11 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, U3
    required :b, A1, doc: "dog"
    required :c, A1
    required :d, A1, doc: "dawg"
  end

  def test_definition_reusing
    cases = {
      M6 => {
        :$defs =>
          {
            "" =>
                {
                  type: "object",
                  properties: {a: {type: "string"}, b: {:$ref => "#/$defs/"}},
                  required: %w[a b],
                  additionalProperties: false
                }
          },
        :$ref => "#/$defs/"
      },
      M7 =>
        {
          :$defs =>
            {
              ".a" =>
                  {
                    type: "object",
                    properties: {
                      a: {
                        anyOf: [
                          {
                            type: "array",
                            items: {anyOf: [{type: "string", enum: ["one"]}, {type: "null"}]}
                          },
                          {type: "null"}
                        ]
                      },
                      b: {
                        anyOf: [
                          {
                            type: "array",
                            items: {anyOf: [{type: "string", enum: ["one"]}, {type: "null"}]}
                          },
                          {type: "null"}
                        ]
                      }
                    },
                    required: %w[a b],
                    additionalProperties: false
                  }
            },
          :type => "object",
          :properties => {a: {:$ref => "#/$defs/.a"}, b: {:$ref => "#/$defs/.a"}},
          :required => %w[a b],
          :additionalProperties => false
        },
      M8 => {
        type: "object",
        properties: {
          a: {
            type: "object",
            properties: {
              a: {
                anyOf: [
                  {
                    type: "array",
                    items: {anyOf: [{type: "string", enum: ["one"]}, {type: "null"}]}
                  },
                  {type: "null"}
                ]
              },
              b: {
                anyOf: [
                  {
                    type: "array",
                    items: {anyOf: [{type: "string", enum: ["one"]}, {type: "null"}]}
                  },
                  {type: "null"}
                ]
              }
            },
            required: %w[a b],
            additionalProperties: false
          },
          b: {
            anyOf: [
              {
                type: "object",
                properties: {
                  a: {
                    anyOf: [
                      {
                        type: "array",
                        items: {anyOf: [{type: "string", enum: ["one"]}, {type: "null"}]}
                      },
                      {type: "null"}
                    ]
                  },
                  b: {
                    anyOf: [
                      {
                        type: "array",
                        items: {
                          anyOf: [
                            {type: "string", enum: ["one"]},
                            {type: "null"}
                          ]
                        }
                      },
                      {type: "null"}
                    ]
                  }
                },
                required: %w[a b],
                additionalProperties: false
              },
              {type: "null"}
            ]
          }
        },
        required: %w[a b],
        additionalProperties: false
      },
      M10 => {
        :$defs =>
          {
            "" =>
                {
                  type: "object",
                  properties: {
                    b: {
                      type: "object",
                      properties: {a: {:$ref => "#/$defs/"}, b: {:$ref => "#/$defs/"}},
                      required: %w[a b],
                      additionalProperties: false
                    }
                  },
                  required: ["b"],
                  additionalProperties: false
                }
          },
        :$ref => "#/$defs/"
      },
      U3 => {
        anyOf: [
          {type: "array", items: {type: "string"}},
          {type: "array", items: {type: "string"}}
        ]
      },
      M11 => {
        type: "object",
        properties: {
          a: {
            anyOf: [
              {type: "array", items: {type: "string"}},
              {type: "array", items: {type: "string"}}
            ]
          },
          b: {description: "dog", type: "array", items: {type: "string"}},
          c: {type: "array", items: {type: "string"}},
          d: {description: "dawg", type: "array", items: {type: "string"}}
        },
        required: %w[a b c d],
        additionalProperties: false
      }
    }

    cases.each do |input, expected|
      schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema(input)
      assert_pattern do
        assert_equal(expected, schema)
      end
    end
  end

  class M12 < OpenAI::Helpers::StructuredOutput::BaseModel
    required :a, OpenAI::Helpers::StructuredOutput::ParsedJson
  end

  def test_parsed_json
    assert_pattern do
      M12.new(a: {dog: "woof"}) => {a: {dog: "woof"}}
    end

    err = JSON::ParserError.new("unexpected token at 'invalid json'")

    m1 = M12.new(a: err)
    assert_raises(OpenAI::Errors::ConversionError) do
      m1.a
    end

    m2 = OpenAI::Internal::Type::Converter.coerce(M12, {a: err})
    assert_raises(OpenAI::Errors::ConversionError) do
      m2.a
    end
  end
end
