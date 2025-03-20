# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::BaseModelTest < Minitest::Test
  class E1 < OpenAI::Enum
    A = :a
    B = :b
  end

  A1 = OpenAI::ArrayOf[-> { Integer }]
  A2 = OpenAI::ArrayOf[enum: -> { E1 }]

  def test_basic
    assert(E1.is_a?(OpenAI::Converter))
    assert(A1.is_a?(OpenAI::Converter))
  end

  def test_basic_coerce
    assert_pattern do
      OpenAI::Converter.coerce(A1, [1.0, 2.0, 3.0]) => [1, 2, 3]
    end

    assert_pattern do
      OpenAI::Converter.coerce(A2, %w[a b c]) => [:a, :b, "c"]
    end
  end

  def test_basic_dump
    assert_pattern do
      OpenAI::Converter.dump(A1, [1.0, 2.0, 3.0]) => [1, 2, 3]
    end

    assert_pattern do
      OpenAI::Converter.dump(A2, %w[a b c]) => %w[a b c]
    end
  end

  def test_primitive_try_strict_coerce
    d_now = Date.today
    t_now = Time.now

    cases = {
      [NilClass, :a] => [true, nil, 0],
      [NilClass, nil] => [true, nil, 1],
      [Integer, 1.0] => [true, 1, 1],
      [Float, 1] => [true, 1.0, 1],
      [Date, d_now] => [true, d_now, 1],
      [Time, t_now] => [true, t_now, 1]
    }

    cases.each do |test, expect|
      type, input = test
      assert_pattern do
        OpenAI::Converter.try_strict_coerce(type, input) => ^expect
      end
    end
  end

  def test_basic_enum_try_strict_coerce
    cases = {
      :a => [true, :a, 1],
      "a" => [true, :a, 1],
      :c => [false, true, 0],
      1 => [false, false, 0]
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.try_strict_coerce(E1, input) => ^expect
      end
    end
  end

  def test_basic_array_try_strict_coerce
    cases = {
      [] => [true, [], 0],
      nil => [false, false, 0],
      [1, 2, 3] => [true, [1, 2, 3], 3],
      [1.0, 2.0, 3.0] => [true, [1, 2, 3], 3],
      [1, nil, 3] => [true, [1, nil, 3], 2],
      [1, nil, nil] => [true, [1, nil, nil], 1],
      [1, "two", 3] => [false, true, 2]
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.try_strict_coerce(A1, input) => ^expect
      end
    end
  end

  def test_nested_array_try_strict_coerce
    cases = {
      %w[a b] => [true, [:a, :b], 2],
      %w[a b c] => [false, true, 2]
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.try_strict_coerce(A2, input) => ^expect
      end
    end
  end

  class M1 < OpenAI::BaseModel
    required :a, Time
    optional :b, E1, api_name: :renamed
    required :c, A1

    request_only do
      required :w, Integer
      optional :x, String
    end

    response_only do
      required :y, Integer
      optional :z, String
    end
  end

  class M2 < M1
    required :c, M1
  end

  def test_model_accessors
    now = Time.now.round(0)
    model = M2.new(a: now.to_s, b: "b", renamed: "a", c: [1.0, 2.0, 3.0], w: 1, y: 1)

    cases = [
      [model.a, now],
      [model.b, :a],
      [model.c, [1, 2, 3]],
      [model.w, 1],
      [model.y, 1]
    ]

    cases.each do |input, expect|
      assert_pattern do
        input => ^expect
      end
    end
  end

  def test_model_conversion_accessor
    model = M2.new(c: {})
    assert_pattern do
      model.c => M1
    end
  end

  def test_model_equality
    now = Time.now
    model1 = M2.new(a: now, b: "b", renamed: "a", c: M1.new, w: 1, y: 1)
    model2 = M2.new(a: now, b: "b", renamed: "a", c: M1.new, w: 1, y: 1)

    assert_pattern do
      model2 => ^model1
    end
  end

  def test_basic_model_coerce
    cases = {
      {} => M2.new,
      {a: nil, b: :a, c: [1.0, 2.0, 3.0], w: 1} => M2.new(a: nil, b: :a, c: [1.0, 2.0, 3.0], w: 1)
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.coerce(M2, input) => ^expect
      end
    end
  end

  def test_basic_model_dump
    cases = {
      nil => nil,
      {} => {},
      {w: 1, x: "x", y: 1, z: "z"} => {w: 1, x: "x"},
      [1, 2, 3] => [1, 2, 3]
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.dump(M2, input) => ^expect
      end
    end
  end

  def test_basic_model_try_strict_coerce
    raw = {a: Time.now, c: [2], y: 1}
    addn = {x: "x", n: "n"}
    expect_exact = M1.new(raw)
    expect_addn = M1.new(**raw, **addn)

    cases = {
      {} => [false, true, 0],
      raw => [true, expect_exact, 3],
      {**raw, **addn} => [true, expect_addn, 4]
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.try_strict_coerce(M1, input) => ^expect
      end
    end
  end

  def test_nested_model_dump
    now = Time.now
    models = [M1, M2]
    inputs = [
      M1.new(a: now, b: "a", c: [1.0, 2.0, 3.0], y: 1),
      {a: now, b: "a", c: [1.0, 2.0, 3.0], y: 1},
      {"a" => now, b: "", "b" => "a", "c" => [], :c => [1.0, 2.0, 3.0], "y" => 1}
    ]

    models.product(inputs).each do |model, input|
      assert_pattern do
        OpenAI::Converter.dump(model, input) => {a: now, renamed: "a", c: [1, 2, 3]}
      end
    end
  end

  class M4 < M2
    required :c, M1
    required :d, OpenAI::ArrayOf[M4]
    required :e, M2, api_name: :f
  end

  def test_model_to_h
    model = M4.new(a: "wow", c: {}, d: [{}, 2, {c: {}}], f: {})
    assert_pattern do
      model.to_h => {a: "wow", c: M1, d: [M4, 2, M4 => child], f: M2}
      assert_equal({c: M1.new}, child.to_h)
    end
  end

  A3 = OpenAI::ArrayOf[A1]

  class M3 < M1
    optional :b, E1, api_name: :renamed_again
  end

  class U1 < OpenAI::Union
    discriminator :type
    variant :a, M1
    variant :b, M3
  end

  class U2 < OpenAI::Union
    variant A1
    variant A3
  end

  def test_basic_union
    assert(U1.is_a?(OpenAI::Converter))

    assert_pattern do
      M1.new => U1
      M3.new => U1
    end
  end

  def test_basic_discriminated_union_coerce
    common = {a: Time.now, c: [], w: 1}
    cases = {
      nil => nil,
      {type: "a", **common} => M1.new(type: "a", **common),
      {type: :b, **common} => M3.new(type: :b, **common),
      {type: :c, xyz: 1} => {type: :c, xyz: 1}
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.coerce(U1, input) => ^expect
      end
    end
  end

  def test_basic_discriminated_union_dump
    now = Time.now
    cases = {
      nil => nil,
      M1.new(a: now, b: :a, c: [1.0, 2.0, 3.0], y: 1) => {a: now, renamed: :a, c: [1, 2, 3]},
      M3.new(b: "a", y: 1) => {renamed_again: "a"},
      {type: :a, b: "a", y: 1} => {type: :a, renamed: "a"},
      {type: "b", b: "a", y: 1} => {type: "b", renamed_again: "a"},
      {type: :c, xyz: 1} => {type: :c, xyz: 1}
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.dump(U1, input) => ^expect
      end
    end
  end

  def test_basic_undifferentiated_union_try_strict_coerce
    cases = {
      [] => [true, [], 0],
      [[]] => [true, [[]], 0],
      # [nil] => [false, true, 0],
      [1, 2, 3] => [true, [1, 2, 3], 3],
      [[1, 2, 3], [4, 5, 6]] => [true, [[1, 2, 3], [4, 5, 6]], 6]
    }

    cases.each do |input, expect|
      assert_pattern do
        OpenAI::Converter.try_strict_coerce(U2, input) => ^expect
      end
    end
  end

  class C1 < OpenAI::BaseModel
    required :a, const: :a
    required :b, const: :b, nil?: true
    optional :c, const: :c
  end

  def test_basic_const
    assert_pattern do
      C1.dump(C1.new) => {a: :a}
      C1.new => {a: :a}
      C1.new(a: "a") => {a: :a}
      C1.new(b: 2) => {b: 2}
      C1.new.a => :a
      C1.new.b => nil
      C1.new.c => nil
    end
  end

  class E2 < OpenAI::Enum
    A = :a
    B = :b
  end

  class U3 < OpenAI::Union
    discriminator :type
    variant :a, M1
    variant :b, M3
  end

  def test_basic_eql
    assert_equal(OpenAI::Unknown, OpenAI::Unknown)
    refute_equal(OpenAI::Unknown, OpenAI::BooleanModel)
    assert_equal(OpenAI::BooleanModel, OpenAI::BooleanModel)

    assert_equal(E1, E2)
    assert_equal(E1, E2)

    refute_equal(U1, U2)
    assert_equal(U1, U3)
  end

  class U4 < OpenAI::Union
    variant :a, const: :a
    variant :b, const: :b
  end

  def test_basic_const_union
    assert_pattern do
      U4.coerce(nil) => nil
      U4.coerce("") => ""
      U4.coerce(:a) => :a
      U4.coerce("a") => :a
    end
  end
end
