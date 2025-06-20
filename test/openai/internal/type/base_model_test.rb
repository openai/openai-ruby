# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::PrimitiveModelTest < Minitest::Test
  A = OpenAI::Internal::Type::ArrayOf[-> { Integer }]
  H = OpenAI::Internal::Type::HashOf[-> { Integer }, nil?: true]

  module E
    extend OpenAI::Internal::Type::Enum
  end

  module U
    extend OpenAI::Internal::Type::Union
  end

  class B < OpenAI::Internal::Type::BaseModel
    optional :a, Integer
    optional :b, B
  end

  def test_typing
    converters = [
      OpenAI::Internal::Type::Unknown,
      OpenAI::Internal::Type::Boolean,
      A,
      H,
      E,
      U,
      B
    ]

    converters.each do |conv|
      assert_pattern do
        conv => OpenAI::Internal::Type::Converter
      end
    end
  end

  def test_coerce
    cases = {
      [OpenAI::Internal::Type::Unknown, :a] => [{yes: 1}, :a],
      [NilClass, :a] => [{maybe: 1}, nil],
      [NilClass, nil] => [{yes: 1}, nil],
      [OpenAI::Internal::Type::Boolean, true] => [{yes: 1}, true],
      [OpenAI::Internal::Type::Boolean, "true"] => [{no: 1}, "true"],
      [Integer, 1] => [{yes: 1}, 1],
      [Integer, 1.0] => [{maybe: 1}, 1],
      [Integer, "1"] => [{maybe: 1}, 1],
      [Integer, "one"] => [{no: 1}, "one"],
      [Float, 1] => [{yes: 1}, 1.0],
      [Float, "1"] => [{maybe: 1}, 1.0],
      [Float, :one] => [{no: 1}, :one],
      [String, :str] => [{yes: 1}, "str"],
      [String, "str"] => [{yes: 1}, "str"],
      [String, 1] => [{maybe: 1}, "1"],
      [:a, "a"] => [{yes: 1}, :a],
      [Date, "1990-09-19"] => [{yes: 1}, Date.new(1990, 9, 19)],
      [Date, Date.new(1990, 9, 19)] => [{yes: 1}, Date.new(1990, 9, 19)],
      [Date, "one"] => [{no: 1}, "one"],
      [Time, "1990-09-19"] => [{yes: 1}, Time.new(1990, 9, 19)],
      [Time, Time.new(1990, 9, 19)] => [{yes: 1}, Time.new(1990, 9, 19)],
      [Time, "one"] => [{no: 1}, "one"]
    }

    cases.each do |lhs, rhs|
      target, input = lhs
      exactness, expect = rhs
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_pattern do
        OpenAI::Internal::Type::Converter.coerce(target, input, state: state) => ^expect
        state.fetch(:exactness).filter { _2.nonzero? }.to_h => ^exactness
      end
    end
  end

  def test_dump
    cases = {
      [OpenAI::Internal::Type::Unknown, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [A, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [H, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [E, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [U, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [B, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [String, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [:b, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [nil, B.new(a: "one", b: B.new(a: 1.0))] => {a: "one", b: {a: 1}},
      [OpenAI::Internal::Type::Boolean, true] => true,
      [OpenAI::Internal::Type::Boolean, "true"] => "true",
      [Integer, "1"] => "1",
      [Float, 1] => 1,
      [String, "one"] => "one",
      [String, :one] => :one,
      [:a, :b] => :b,
      [:a, "a"] => "a",
      [String, StringIO.new("one")] => "one",
      [String, Pathname(__FILE__)] => OpenAI::FilePart
    }

    cases.each do
      target, input = _1
      expect = _2
      assert_pattern do
        OpenAI::Internal::Type::Converter.dump(target, input) => ^expect
      end
    end
  end

  def test_coerce_errors
    cases = {
      [Integer, "one"] => ArgumentError,
      [Float, "one"] => ArgumentError,
      [String, Time] => TypeError,
      [Date, "one"] => ArgumentError,
      [Time, "one"] => ArgumentError
    }

    cases.each do |testcase, expect|
      target, input = testcase
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      OpenAI::Internal::Type::Converter.coerce(target, input, state: state)
      assert_pattern do
        state => {error: ^expect}
      end
    end
  end

  def test_dump_retry
    types = [
      OpenAI::Internal::Type::Unknown,
      OpenAI::Internal::Type::Boolean,
      A,
      H,
      E,
      U,
      B
    ]
    Pathname(__FILE__).open do |fd|
      cases = [
        fd,
        [fd],
        {a: fd},
        {a: {b: fd}}
      ]
      types.product(cases).each do |target, input|
        state = {can_retry: true}
        OpenAI::Internal::Type::Converter.dump(target, input, state: state)

        assert_pattern do
          state => {can_retry: false}
        end
      end
    end
  end
end

class OpenAI::Test::EnumModelTest < Minitest::Test
  class E0
    include OpenAI::Internal::Type::Enum
    attr_reader :values

    def initialize(*values) = (@values = values)
  end

  module E1
    extend OpenAI::Internal::Type::Enum

    TRUE = true
  end

  module E2
    extend OpenAI::Internal::Type::Enum

    ONE = 1
    TWO = 2
  end

  module E3
    extend OpenAI::Internal::Type::Enum

    ONE = 1.0
    TWO = 2.0
  end

  module E4
    extend OpenAI::Internal::Type::Enum

    ONE = :one
    TWO = :two
  end

  def test_coerce
    cases = {
      [E0.new, "one"] => [{no: 1}, "one"],
      [E0.new(:one), "one"] => [{yes: 1}, :one],
      [E0.new(:two), "one"] => [{maybe: 1}, "one"],

      [E1, true] => [{yes: 1}, true],
      [E1, false] => [{no: 1}, false],
      [E1, :true] => [{no: 1}, :true],

      [E2, 1] => [{yes: 1}, 1],
      [E2, 1.0] => [{yes: 1}, 1],
      [E2, 1.2] => [{no: 1}, 1.2],
      [E2, "1"] => [{no: 1}, "1"],

      [E3, 1.0] => [{yes: 1}, 1.0],
      [E3, 1] => [{yes: 1}, 1.0],
      [E3, "one"] => [{no: 1}, "one"],

      [E4, :one] => [{yes: 1}, :one],
      [E4, "one"] => [{yes: 1}, :one],
      [E4, "1"] => [{maybe: 1}, "1"],
      [E4, :"1"] => [{maybe: 1}, :"1"],
      [E4, 1] => [{no: 1}, 1]
    }

    cases.each do |lhs, rhs|
      target, input = lhs
      exactness, expect = rhs
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_pattern do
        OpenAI::Internal::Type::Converter.coerce(target, input, state: state) => ^expect
        state.fetch(:exactness).filter { _2.nonzero? }.to_h => ^exactness
      end
    end
  end

  def test_dump
    cases = {
      [E1, true] => true,
      [E1, "true"] => "true",

      [E2, 1.0] => 1.0,
      [E2, 3] => 3,
      [E2, "1.0"] => "1.0",

      [E3, 1.0] => 1.0,
      [E3, 3] => 3,
      [E3, "1.0"] => "1.0",

      [E4, :one] => :one,
      [E4, "one"] => "one",
      [E4, "1.0"] => "1.0"
    }

    cases.each do
      target, input = _1
      expect = _2
      assert_pattern do
        OpenAI::Internal::Type::Converter.dump(target, input) => ^expect
      end
    end
  end
end

class OpenAI::Test::CollectionModelTest < Minitest::Test
  A1 = OpenAI::Internal::Type::ArrayOf[-> { Integer }]
  H1 = OpenAI::Internal::Type::HashOf[Integer]

  A2 = OpenAI::Internal::Type::ArrayOf[H1]
  H2 = OpenAI::Internal::Type::HashOf[-> { A1 }]

  A3 = OpenAI::Internal::Type::ArrayOf[Integer, nil?: true]
  H3 = OpenAI::Internal::Type::HashOf[Integer, nil?: true]

  def test_coerce
    cases = {
      [A1, []] => [{yes: 1}, []],
      [A1, {}] => [{no: 1}, {}],
      [A1, [1, 2.0]] => [{yes: 2, maybe: 1}, [1, 2]],
      [A1, ["1", 2.0]] => [{yes: 1, maybe: 2}, [1, 2]],
      [H1, {}] => [{yes: 1}, {}],
      [H1, []] => [{no: 1}, []],
      [H1, {a: 1, b: 2}] => [{yes: 3}, {a: 1, b: 2}],
      [H1, {"a" => 1, "b" => 2}] => [{yes: 3}, {a: 1, b: 2}],
      [H1, {[] => 1}] => [{yes: 2, no: 1}, {[] => 1}],
      [H1, {a: 1.5}] => [{yes: 1, maybe: 1}, {a: 1}],

      [A2, [{}, {"a" => 1}]] => [{yes: 4}, [{}, {a: 1}]],
      [A2, [{"a" => "1"}]] => [{yes: 2, maybe: 1}, [{a: 1}]],
      [H2, {a: [1, 2]}] => [{yes: 4}, {a: [1, 2]}],
      [H2, {"a" => ["1", 2]}] => [{yes: 3, maybe: 1}, {a: [1, 2]}],
      [H2, {"a" => ["one", 2]}] => [{yes: 3, no: 1}, {a: ["one", 2]}],

      [A3, [nil, 1]] => [{yes: 3}, [nil, 1]],
      [A3, [nil, "1"]] => [{yes: 2, maybe: 1}, [nil, 1]],
      [H3, {a: nil, b: "1"}] => [{yes: 2, maybe: 1}, {a: nil, b: 1}],
      [H3, {a: nil}] => [{yes: 2}, {a: nil}]
    }

    cases.each do |lhs, rhs|
      target, input = lhs
      exactness, expect = rhs
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_pattern do
        OpenAI::Internal::Type::Converter.coerce(target, input, state: state) => ^expect
        state.fetch(:exactness).filter { _2.nonzero? }.to_h => ^exactness
      end
    end
  end
end

class OpenAI::Test::BaseModelTest < Minitest::Test
  class M1 < OpenAI::Internal::Type::BaseModel
    required :a, Integer
  end

  class M2 < M1
    required :a, Time
    required :b, Integer, nil?: true
    optional :c, String
  end

  class M3 < OpenAI::Internal::Type::BaseModel
    optional :c, const: :c
    required :d, const: :d
  end

  class M4 < M1
    request_only do
      required :a, Integer
      optional :b, String
    end

    response_only do
      required :c, Integer
      optional :d, String
    end
  end

  class M5 < OpenAI::Internal::Type::BaseModel
    request_only do
      required :c, const: :c
    end

    response_only do
      required :d, const: :d
    end
  end

  class M6 < M1
    required :a, OpenAI::Internal::Type::ArrayOf[M6]
    optional :b, M6
  end

  def test_coerce
    cases = {
      [M1, {}] => [{yes: 1, no: 1}, {}],
      [M1, :m1] => [{no: 1}, :m1],

      [M2, {}] => [{yes: 2, no: 1, maybe: 1}, {}],
      [M2, {a: "1990-09-19", b: nil}] => [{yes: 4}, {a: "1990-09-19", b: nil}],
      [M2, {a: "1990-09-19", b: "1"}] => [{yes: 3, maybe: 1}, {a: "1990-09-19", b: "1"}],
      [M2, {a: "1990-09-19"}] => [{yes: 3, maybe: 1}, {a: "1990-09-19"}],
      [M2, {a: "1990-09-19", c: nil}] => [{yes: 2, maybe: 2}, {a: "1990-09-19", c: nil}],

      [M3, {c: "c", d: "d"}] => [{yes: 3}, {c: :c, d: :d}],
      [M3, {c: "d", d: "c"}] => [{yes: 1, maybe: 2}, {c: "d", d: "c"}],

      [M4, {c: 2}] => [{yes: 5}, {c: 2}],
      [M4, {a: "1", c: 2}] => [{yes: 4, maybe: 1}, {a: "1", c: 2}],
      [M4, {b: nil, c: 2}] => [{yes: 4, maybe: 1}, {b: nil, c: 2}],

      [M5, {}] => [{yes: 3}, {}],
      [M5, {c: "c"}] => [{yes: 3}, {c: :c}],
      [M5, {d: "d"}] => [{yes: 3}, {d: :d}],
      [M5, {d: nil}] => [{yes: 2, no: 1}, {d: nil}],

      [M6, {a: [{a: []}]}] => [{yes: 6}, -> { _1 in {a: [M6]} }]
    }

    cases.each do |lhs, rhs|
      target, input = lhs
      exactness, expect = rhs
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_pattern do
        coerced = OpenAI::Internal::Type::Converter.coerce(target, input, state: state)
        assert_equal(coerced, coerced)
        if coerced.is_a?(OpenAI::Internal::Type::BaseModel)
          coerced.to_h => ^expect
        else
          coerced => ^expect
        end
        state.fetch(:exactness).filter { _2.nonzero? }.to_h => ^exactness
      end
    end
  end

  def test_dump
    cases = {
      [M3, M3.new] => {d: :d},
      [M3, {}] => {d: :d},
      [M3, {d: 1}] => {d: 1},

      [M4, M4.new(a: 1, b: "b", c: 2, d: "d")] => {a: 1, b: "b"},
      [M4, {a: 1, b: "b", c: 2, d: "d"}] => {a: 1, b: "b"},

      [M5, M5.new] => {c: :c},
      [M5, {}] => {c: :c},
      [M5, {c: 1}] => {c: 1}
    }

    cases.each do
      target, input = _1
      expect = _2
      assert_pattern do
        OpenAI::Internal::Type::Converter.dump(target, input) => ^expect
      end
    end
  end

  def test_accessors
    cases = {
      M2.new({a: "1990-09-19", b: "1"}) => [{a: "1990-09-19", b: "1"}, {a: Time.new(1990, 9, 19), b: 1}],
      M2.new(a: "one", b: "one") => [{a: "one", b: "one"}, {a: ArgumentError, b: ArgumentError}],
      M2.new(a: nil, b: 2.0) => [{a: nil, b: 2.0}, {a: TypeError}],
      M2.new(a: nil, b: 2.2) => [{a: nil, b: 2.2}, {a: TypeError, b: 2}],

      M3.new => [{}, {d: :d}],
      M3.new(d: 1) => [{d: 1}, {d: ArgumentError}],

      M5.new => [{}, {c: :c, d: :d}]
    }

    cases.each do
      target = _1
      data, attributes = _2

      assert_pattern do
        target.to_h => ^data
      end

      attributes.each do |accessor, expect|
        case expect
        in Class if expect <= StandardError
          tap do
            target.public_send(accessor)
            flunk
          rescue OpenAI::Errors::ConversionError => e
            assert_kind_of(expect, e.cause)
          end
        else
          assert_pattern { target.public_send(accessor) => ^expect }
        end
      end
    end
  end

  def test_inplace_modification
    m1 = M6.new(a: [])
    m1.a << M6.new(a: [])

    m2 = M6.new(b: M6.new(a: []))
    m2.b.a << M6.new(a: [])

    m3 = M6.new(a: [])
    m4 = M6.new(b: m3)
    m3.a << M6.new(a: [])

    assert_pattern do
      m1 => {a: [{a: []}]}
      m2 => {b: {a: [{a: []}]}}
      m4 => {b: {a: [{a: []}]}}
    end
  end
end

class OpenAI::Test::UnionTest < Minitest::Test
  class U0
    include OpenAI::Internal::Type::Union

    def initialize(*variants) = variants.each { variant(_1) }
  end

  module U1
    extend OpenAI::Internal::Type::Union
    variant const: :a
    variant const: 2
  end

  class M1 < OpenAI::Internal::Type::BaseModel
    required :t, const: :a, api_name: :type
    optional :c, String
  end

  class M2 < OpenAI::Internal::Type::BaseModel
    required :type, const: :b
    optional :c, String
  end

  module U2
    extend OpenAI::Internal::Type::Union
    discriminator :type

    variant :a, M1
    variant :b, M2
  end

  module U3
    extend OpenAI::Internal::Type::Union
    discriminator :type

    variant :a, M1
    variant String
  end

  module U4
    extend OpenAI::Internal::Type::Union
    discriminator :type

    variant String
    variant :a, M1
  end

  class M3 < OpenAI::Internal::Type::BaseModel
    optional :recur, -> { U5 }
    required :a, Integer
  end

  class M4 < OpenAI::Internal::Type::BaseModel
    optional :recur, -> { U5 }
    required :a, OpenAI::Internal::Type::ArrayOf[-> { U5 }]
  end

  class M5 < OpenAI::Internal::Type::BaseModel
    optional :recur, -> { U5 }
    required :b, OpenAI::Internal::Type::ArrayOf[-> { U5 }]
  end

  module U5
    extend OpenAI::Internal::Type::Union

    variant -> { M3 }
    variant -> { M4 }
  end

  module U6
    extend OpenAI::Internal::Type::Union

    variant -> { M3 }
    variant -> { M5 }
  end

  def test_accessors
    model = M3.new(recur: [])
    tap do
      model.recur
      flunk
    rescue OpenAI::Errors::ConversionError => e
      assert_kind_of(ArgumentError, e.cause)
    end
  end

  def test_coerce
    cases = {
      [U0, :""] => [{no: 1}, 0, :""],

      [U0.new(Integer, Float), "one"] => [{no: 1}, 2, "one"],
      [U0.new(Integer, Float), 1.0] => [{yes: 1}, 2, 1.0],
      [U0.new({const: :a}), "a"] => [{yes: 1}, 1, :a],
      [U0.new({const: :a}), "2"] => [{maybe: 1}, 1, "2"],

      [U1, "a"] => [{yes: 1}, 1, :a],
      [U1, "2"] => [{maybe: 1}, 2, "2"],
      [U1, :b] => [{maybe: 1}, 2, :b],

      [U2, {type: :a}] => [{yes: 3}, 0, {t: :a}],
      [U2, {type: "b"}] => [{yes: 3}, 0, {type: :b}],

      [U3, "one"] => [{yes: 1}, 2, "one"],
      [U4, "one"] => [{yes: 1}, 1, "one"],

      [U5, {a: []}] => [{yes: 3}, 2, {a: []}],
      [U6, {b: []}] => [{yes: 3}, 2, {b: []}],

      [U5, {a: [{a: []}]}] => [{yes: 6}, 4, {a: [M4.new(a: [])]}],
      [U5, {a: [{a: [{a: []}]}]}] => [{yes: 9}, 6, {a: [M4.new(a: [M4.new(a: [])])]}]
    }

    cases.each do |lhs, rhs|
      target, input = lhs
      exactness, branched, expect = rhs
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      assert_pattern do
        coerced = OpenAI::Internal::Type::Converter.coerce(target, input, state: state)
        assert_equal(coerced, coerced)
        if coerced.is_a?(OpenAI::Internal::Type::BaseModel)
          coerced.to_h => ^expect
        else
          coerced => ^expect
        end
        state.fetch(:exactness).filter { _2.nonzero? }.to_h => ^exactness
        state => {branched: ^branched}
      end
    end
  end
end

class OpenAI::Test::BaseModelQoLTest < Minitest::Test
  class E0
    include OpenAI::Internal::Type::Enum
    attr_reader :values

    def initialize(*values) = (@values = values)
  end

  module E1
    extend OpenAI::Internal::Type::Enum

    A = 1
  end

  module E2
    extend OpenAI::Internal::Type::Enum

    A = 1
  end

  module E3
    extend OpenAI::Internal::Type::Enum

    A = 2
    B = 3
  end

  class U0
    include OpenAI::Internal::Type::Union

    def initialize(*variants) = variants.each { variant(_1) }
  end

  module U1
    extend OpenAI::Internal::Type::Union

    variant String
    variant Integer
  end

  module U2
    extend OpenAI::Internal::Type::Union

    variant String
    variant Integer
  end

  class M1 < OpenAI::Internal::Type::BaseModel
    required :a, Integer
  end

  class M2 < OpenAI::Internal::Type::BaseModel
    required :a, Integer, nil?: true
  end

  class M3 < M2
    required :a, Integer
  end

  def test_equality
    cases = {
      [OpenAI::Internal::Type::Unknown, OpenAI::Internal::Type::Unknown] => true,
      [OpenAI::Internal::Type::Boolean, OpenAI::Internal::Type::Boolean] => true,
      [OpenAI::Internal::Type::Unknown, OpenAI::Internal::Type::Boolean] => false,
      [E0.new(:a, :b), E0.new(:a, :b)] => true,
      [E0.new(:a, :b), E0.new(:b, :a)] => true,
      [E0.new(:a, :b), E0.new(:b, :c)] => false,
      [E1, E2] => true,
      [E1, E3] => false,
      [U0.new(String, Integer), U0.new(String, Integer)] => true,
      [U0.new(String, Integer), U0.new(Integer, String)] => false,
      [U0.new(String, Float), U0.new(String, Integer)] => false,
      [U1, U2] => true,
      [M1, M2] => false,
      [M1, M3] => true,
      [M1.new(a: 1), M1.new(a: 1)] => true
    }

    cases.each do
      if _2
        assert_equal(*_1)
        assert_equal(*_1.map(&:hash))
      else
        refute_equal(*_1)
        refute_equal(*_1.map(&:hash))
      end
    end
  end
end
