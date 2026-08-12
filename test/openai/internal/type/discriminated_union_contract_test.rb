# frozen_string_literal: true

require_relative "../../test_helper"

# These tests protect discriminator behavior used by generated Responses and Realtime
# schemas. Those schemas include duplicate, optional, nullable, and unkeyed
# discriminators, so a simple discriminator hash lookup is not sufficient.
class OpenAI::Test::DiscriminatedUnionContractTest < Minitest::Test
  class UniqueA < OpenAI::Internal::Type::BaseModel
    required :type, const: :a
    required :value, Integer
  end

  class UniqueB < OpenAI::Internal::Type::BaseModel
    required :type, const: :b
    required :value, String
  end

  module UniqueUnion
    extend OpenAI::Internal::Type::Union

    discriminator :type
    variant :a, UniqueA
    variant :b, UniqueB
  end

  class DuplicateLeft < OpenAI::Internal::Type::BaseModel
    required :type, const: :duplicate
    required :left, Integer
  end

  class DuplicateRight < OpenAI::Internal::Type::BaseModel
    required :type, const: :duplicate
    required :right, String
  end

  module DuplicateUnion
    extend OpenAI::Internal::Type::Union

    discriminator :type
    variant :duplicate, DuplicateLeft
    variant :duplicate, DuplicateRight
  end

  def test_unique_discriminator_accepts_symbol_and_string_keys_and_values
    inputs = [
      {type: :a, value: 1},
      {type: "a", value: 1},
      {"type" => :a, value: 1},
      {"type" => "a", value: 1}
    ]

    inputs.each do |input|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(UniqueUnion, input, state: state)

      assert_instance_of(UniqueA, output)
      assert_equal(:a, output.type)
      assert_equal(1, output.value)
      assert_nil(state.fetch(:error))
    end
  end

  def test_duplicate_discriminator_uses_structure_instead_of_first_registration
    left_input = {type: "duplicate", left: "1"}
    right_input = {type: "duplicate", right: "value"}

    left_state = OpenAI::Internal::Type::Converter.new_coerce_state
    left = OpenAI::Internal::Type::Converter.coerce(DuplicateUnion, left_input, state: left_state)
    right_state = OpenAI::Internal::Type::Converter.new_coerce_state
    right = OpenAI::Internal::Type::Converter.coerce(DuplicateUnion, right_input, state: right_state)

    assert_instance_of(DuplicateLeft, left)
    assert_equal(1, left.left)
    assert_nil(left_state.fetch(:error))
    assert_instance_of(DuplicateRight, right)
    assert_equal("value", right.right)
    assert_nil(right_state.fetch(:error))
  end

  def test_responses_input_message_variants_with_the_same_tag_choose_the_most_specific_shape
    cases = [
      [
        {content: "hello", role: "user", type: "message"},
        OpenAI::Responses::EasyInputMessage
      ],
      [
        {content: [], role: "developer", status: "completed", type: "message"},
        OpenAI::Responses::ResponseInputItem::Message
      ],
      [
        {id: "msg_123", content: [], role: "assistant", status: "completed", type: "message"},
        OpenAI::Responses::ResponseOutputMessage
      ]
    ]

    cases.each do |input, expected_class|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Responses::ResponseInputItem,
        input,
        state: state
      )

      assert_instance_of(expected_class, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_beta_input_message_variants_with_the_same_tag_choose_the_most_specific_shape
    cases = [
      [
        {content: "hello", role: "user", type: "message"},
        OpenAI::Beta::BetaEasyInputMessage
      ],
      [
        {content: [], role: "developer", status: "completed", type: "message"},
        OpenAI::Beta::BetaResponseInputItem::Message
      ],
      [
        {id: "msg_123", content: [], role: "assistant", status: "completed", type: "message"},
        OpenAI::Beta::BetaResponseOutputMessage
      ]
    ]

    cases.each do |input, expected_class|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Beta::BetaResponseInputItem,
        input,
        state: state
      )

      assert_instance_of(expected_class, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_responses_item_message_variants_with_the_same_tag_use_required_fields
    cases = [
      [
        {id: "msg_in", content: [], role: "user", type: "message"},
        OpenAI::Responses::ResponseInputMessageItem
      ],
      [
        {id: "msg_out", content: [], role: "assistant", status: "completed", type: "message"},
        OpenAI::Responses::ResponseOutputMessage
      ]
    ]

    cases.each do |input, expected_class|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(OpenAI::Responses::ResponseItem, input, state: state)

      assert_instance_of(expected_class, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_beta_item_message_variants_with_the_same_tag_use_required_fields
    cases = [
      [
        {id: "msg_in", content: [], role: "user", type: "message"},
        OpenAI::Beta::BetaResponseInputMessageItem
      ],
      [
        {id: "msg_out", content: [], role: "assistant", status: "completed", type: "message"},
        OpenAI::Beta::BetaResponseOutputMessage
      ]
    ]

    cases.each do |input, expected_class|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(OpenAI::Beta::BetaResponseItem, input, state: state)

      assert_instance_of(expected_class, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_realtime_message_variants_with_the_same_tag_use_role
    cases = [
      ["system", OpenAI::Realtime::RealtimeConversationItemSystemMessage],
      ["user", OpenAI::Realtime::RealtimeConversationItemUserMessage],
      ["assistant", OpenAI::Realtime::RealtimeConversationItemAssistantMessage]
    ]

    cases.each do |role, expected_class|
      input = {content: [], role: role, type: "message"}
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Realtime::ConversationItem,
        input,
        state: state
      )

      assert_instance_of(expected_class, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_missing_discriminator_retains_structural_inference_for_responses_messages
    input = {content: "hello", role: "user"}
    state = OpenAI::Internal::Type::Converter.new_coerce_state

    output = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Responses::ResponseInputItem,
      input,
      state: state
    )

    assert_instance_of(OpenAI::Responses::EasyInputMessage, output)
    assert_nil(output[:type])
    assert_nil(state.fetch(:error))
  end

  def test_nil_discriminator_retains_structural_inference_for_nullable_item_reference
    input = {id: "item_123", type: nil}
    state = OpenAI::Internal::Type::Converter.new_coerce_state

    output = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Responses::ResponseInputItem,
      input,
      state: state
    )

    assert_instance_of(OpenAI::Responses::ResponseInputItem::ItemReference, output)
    assert_nil(output.type)
    assert_nil(state.fetch(:error))
  end

  def test_missing_discriminator_retains_structural_inference_for_realtime_audio
    cases = [
      [{}, OpenAI::Realtime::RealtimeAudioFormats::AudioPCM],
      [{rate: 24_000}, OpenAI::Realtime::RealtimeAudioFormats::AudioPCM]
    ]

    cases.each do |input, expected_class|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Realtime::RealtimeAudioFormats,
        input,
        state: state
      )

      assert_instance_of(expected_class, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_missing_discriminator_retains_structural_inference_for_realtime_tools
    input = {name: "weather"}
    state = OpenAI::Internal::Type::Converter.new_coerce_state

    output = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Realtime::RealtimeToolsConfigUnion,
      input,
      state: state
    )

    assert_instance_of(OpenAI::Realtime::RealtimeFunctionTool, output)
    assert_equal("weather", output.name)
    assert_nil(state.fetch(:error))
  end

  def test_unknown_discriminator_is_a_successful_raw_passthrough
    inputs = [
      {type: :future, sequence_number: 3},
      {type: "future", sequence_number: 3},
      {"type" => :future, "sequence_number" => 3},
      {"type" => "future", "sequence_number" => 3}
    ]

    inputs.each do |input|
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Responses::ResponseStreamEvent,
        input,
        state: state
      )

      assert_same(input, output)
      assert_nil(state.fetch(:error))
    end
  end

  def test_unknown_discriminator_nested_in_model_is_raw_and_does_not_raise
    future_item = {id: "item_future", type: "future_item"}
    response = OpenAI::Responses::Response.new(output: [future_item])

    assert_same(future_item, response.output.fetch(0))
    assert_same(future_item, response.to_h.fetch(:output).fetch(0))
  end

  def test_known_unkeyed_discriminator_variants_remain_typed_with_unknown_nested_enum
    cases = [
      [OpenAI::Responses::Tool, :web_search, OpenAI::Responses::WebSearchTool],
      [OpenAI::Responses::Tool, :web_search_preview, OpenAI::Responses::WebSearchPreviewTool],
      [OpenAI::Beta::BetaTool, :web_search, OpenAI::Beta::BetaWebSearchTool],
      [OpenAI::Beta::BetaTool, :web_search_preview, OpenAI::Beta::BetaWebSearchPreviewTool]
    ]

    cases.each do |union, type, expected_class|
      input = {type: type.to_s, search_context_size: "future_size"}
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(union, input, state: state)

      assert_instance_of(expected_class, output)
      assert_equal(type, output.type)
      assert_equal("future_size", output[:search_context_size])
      assert_equal("future_size", output.search_context_size)
      assert_nil(state.fetch(:error))
    end
  end

  def test_unkeyed_variants_do_not_claim_genuinely_unknown_discriminators
    [OpenAI::Responses::Tool, OpenAI::Beta::BetaTool].each do |union|
      input = {type: "future_tool", search_context_size: "future_size"}
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      output = OpenAI::Internal::Type::Converter.coerce(union, input, state: state)

      assert_same(input, output)
      assert_nil(state.fetch(:error))
    end
  end
end
