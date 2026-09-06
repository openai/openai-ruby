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

  def test_unknown_discriminators_preserve_the_original_value
    inputs = [
      {type: :unknown},
      {type: "unknown"},
      {type: nil},
      {"type" => :unknown},
      {"type" => "unknown"}
    ]

    inputs.each do |input|
      state = OpenAI::Internal::Type::Converter.new_coerce_state

      assert_same(input, OpenAI::Internal::Type::Converter.coerce(DiscriminatedUnion, input, state: state))
      assert_equal({yes: 1, no: 0, maybe: 0}, state.fetch(:exactness))
      assert_nil(state.fetch(:error))
    end
  end

  def test_unknown_response_output_item_is_not_a_known_tool_call
    input = {type: "attacker"}

    output_item = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Responses::ResponseOutputItem,
      input
    )

    assert_same(input, output_item)
    refute_instance_of(OpenAI::Responses::ResponseComputerToolCall, output_item)
  end

  def test_known_unkeyed_discriminator_variants_remain_typed
    cases = [
      [OpenAI::Responses::Tool, "web_search", OpenAI::Responses::WebSearchTool],
      [OpenAI::Responses::Tool, "web_search_2025_08_26", OpenAI::Responses::WebSearchTool],
      [OpenAI::Responses::Tool, "web_search_preview", OpenAI::Responses::WebSearchPreviewTool],
      [
        OpenAI::Responses::Tool,
        "web_search_preview_2025_03_11",
        OpenAI::Responses::WebSearchPreviewTool
      ],
      [OpenAI::Beta::BetaTool, "web_search", OpenAI::Beta::BetaWebSearchTool],
      [OpenAI::Beta::BetaTool, "web_search_2025_08_26", OpenAI::Beta::BetaWebSearchTool],
      [OpenAI::Beta::BetaTool, "web_search_preview", OpenAI::Beta::BetaWebSearchPreviewTool],
      [
        OpenAI::Beta::BetaTool,
        "web_search_preview_2025_03_11",
        OpenAI::Beta::BetaWebSearchPreviewTool
      ]
    ]

    cases.each do |union, type, expected|
      tool = OpenAI::Internal::Type::Converter.coerce(union, {type: type})

      assert_instance_of(expected, tool)
    end
  end

  def test_known_unkeyed_discriminator_ignores_unrelated_inexact_fields
    cases = [
      [
        OpenAI::Responses::Tool,
        {type: "web_search", external_web_access: "false"},
        OpenAI::Responses::WebSearchTool
      ],
      [
        OpenAI::Beta::BetaTool,
        {type: "web_search_preview", search_content_types: ["future"]},
        OpenAI::Beta::BetaWebSearchPreviewTool
      ]
    ]

    cases.each do |union, input, expected|
      tool = OpenAI::Internal::Type::Converter.coerce(union, input)

      assert_instance_of(expected, tool)
    end
  end
end
