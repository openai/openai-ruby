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

  class NestedParticipant < OpenAI::BaseModel
    required :name, String
  end

  class NestedEvent < OpenAI::BaseModel
    required :participant, NestedParticipant
    required :participants, OpenAI::ArrayOf[NestedParticipant]
    required :choice, OpenAI::UnionOf[String, NestedParticipant]
    required :status, OpenAI::EnumOf[:confirmed, :tentative]
  end

  class NullableNestedEvent < OpenAI::BaseModel
    required :participants, OpenAI::ArrayOf[NestedParticipant, nil?: true]
  end

  class ScalarContractEvent < OpenAI::BaseModel
    required :active, OpenAI::Boolean
    required :status, OpenAI::EnumOf[:confirmed, :tentative]
    required :flags, OpenAI::ArrayOf[OpenAI::Boolean]
  end

  class NullableScalarContractEvent < OpenAI::BaseModel
    required :active, OpenAI::Boolean, nil?: true
    required :participant, NestedParticipant, nil?: true
  end

  class NullableReaderContractEvent < OpenAI::BaseModel
    required :name, String, nil?: true
    required :kind, Symbol, nil?: true
    required :count, Integer, nil?: true
    required :amount, Float, nil?: true
    required :active, OpenAI::Boolean, nil?: true
    required :participant, NestedParticipant, nil?: true
    required :participants, OpenAI::ArrayOf[NestedParticipant], nil?: true
    required :status, OpenAI::EnumOf[:confirmed], nil?: true
    required :choice, OpenAI::UnionOf[String, NestedParticipant], nil?: true
  end

  class EmptyUnionMember < OpenAI::BaseModel
  end

  class UnionContractEvent < OpenAI::BaseModel
    required :choice, OpenAI::UnionOf[String, EmptyUnionMember]
  end

  class SymbolContractEvent < OpenAI::BaseModel
    required :kind, Symbol
  end

  class RecursiveSymbolContractEvent < OpenAI::BaseModel
    required :kinds, OpenAI::ArrayOf[Symbol]
    required :nullable_kinds, OpenAI::ArrayOf[Symbol, nil?: true]
    required :nested_kinds, OpenAI::ArrayOf[OpenAI::ArrayOf[Symbol]]
    required :choice, OpenAI::UnionOf[Integer, Symbol]
    required :choices, OpenAI::ArrayOf[OpenAI::UnionOf[Integer, Symbol]]
  end

  class NestedSymbolContractEvent < OpenAI::BaseModel
    required :participants, OpenAI::ArrayOf[SymbolContractEvent]
    required :choice, OpenAI::UnionOf[Integer, SymbolContractEvent]
  end

  class InheritedNestedEvent < NestedEvent
    required :name, String
  end

  U1 = OpenAI::Helpers::StructuredOutput::UnionOf[Integer, A1]
  U2 = OpenAI::Helpers::StructuredOutput::UnionOf[M2, M3]
  U3 = OpenAI::Helpers::StructuredOutput::UnionOf[A1, A1]
  U4 = OpenAI::Helpers::StructuredOutput::UnionOf[String, NilClass]

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

  def test_nested_readers_materialize_constructor_values_without_changing_raw_storage
    participant = {name: "Ada"}
    participants = [{name: "Grace"}]
    choice = {name: "Katherine"}
    event = NestedEvent.new(
      participant: participant,
      participants: participants,
      choice: choice,
      status: "confirmed"
    )

    assert_instance_of(NestedParticipant, event.participant)
    assert_equal("Ada", event.participant.name)
    assert_instance_of(NestedParticipant, event.participants.fetch(0))
    assert_instance_of(NestedParticipant, event.choice)
    assert_equal(:confirmed, event.status)
    assert_same(participant, event[:participant])
    assert_same(participants, event.to_h.fetch(:participants))
    assert_same(choice, event[:choice])
  end

  def test_nested_readers_materialize_assigned_values_without_changing_raw_storage
    event = NestedEvent.new
    participant = {name: "Ada"}
    participants = [{name: "Grace"}]
    choice = {name: "Katherine"}

    event.participant = participant
    event.participants = participants
    event.choice = choice
    event.status = "tentative"

    assert_instance_of(NestedParticipant, event.participant)
    assert_instance_of(NestedParticipant, event.participants.fetch(0))
    assert_instance_of(NestedParticipant, event.choice)
    assert_equal(:tentative, event.status)
    assert_same(participant, event.to_h.fetch(:participant))
    assert_same(participants, event[:participants])
    assert_same(choice, event.to_h.fetch(:choice))
  end

  def test_nested_readers_preserve_materialized_response_values
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    event = OpenAI::Internal::Type::Converter.coerce(
      NestedEvent,
      {
        participant: {name: "Ada"},
        participants: [{name: "Grace"}],
        choice: {name: "Katherine"},
        status: "confirmed"
      },
      state: state
    )

    assert_nil(state.fetch(:error))
    assert_instance_of(NestedParticipant, event.participant)
    assert_instance_of(NestedParticipant, event.participants.fetch(0))
    assert_instance_of(NestedParticipant, event.choice)
    assert_equal(:confirmed, event.status)
    assert_same(event[:participant], event.participant)
    assert_same(event[:participants], event.participants)
    assert_same(event[:choice], event.choice)
  end

  def test_nested_readers_preserve_nilable_array_elements
    participants = [{name: "Ada"}, nil]
    event = NullableNestedEvent.new(participants: participants)

    assert_instance_of(NestedParticipant, event.participants.fetch(0))
    assert_nil(event.participants.fetch(1))
    assert_same(participants, event[:participants])
    assert_same(participants, event.to_h.fetch(:participants))

    replacement = [nil, {name: "Grace"}]
    event.participants = replacement

    assert_nil(event.participants.fetch(0))
    assert_instance_of(NestedParticipant, event.participants.fetch(1))
    assert_same(replacement, event[:participants])

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      NullableNestedEvent,
      {participants: participants},
      state: state
    )

    assert_nil(state.fetch(:error))
    assert_instance_of(NestedParticipant, parsed.participants.fetch(0))
    assert_nil(parsed.participants.fetch(1))
    assert_same(parsed[:participants], parsed.participants)

    parsed.participants << nil

    assert_equal(3, parsed[:participants].length)
    assert_same(parsed[:participants], parsed.participants)
  end

  def test_nested_readers_are_preserved_by_subclass_inheritance
    participant = {name: "Ada"}
    participants = [{name: "Grace"}]
    event = InheritedNestedEvent.new(
      name: "conference",
      participant: participant,
      participants: participants,
      choice: "speaker",
      status: "confirmed"
    )

    assert_equal("conference", event.name)
    assert_instance_of(NestedParticipant, event.participant)
    assert_instance_of(NestedParticipant, event.participants.fetch(0))
    assert_equal("speaker", event.choice)
    assert_equal(:confirmed, event.status)
    assert_same(participant, event[:participant])
    assert_same(participants, event.to_h.fetch(:participants))
  end

  def test_nested_readers_observe_mutations_to_caller_owned_values
    participant = {name: "Ada"}
    participants = [{name: "Grace"}]
    event = NestedEvent.new(participant: participant, participants: participants)

    participant[:name] = "Katherine"
    participants << {name: "Dorothy"}

    assert_equal("Katherine", event.participant.name)
    assert_equal(%w[Grace Dorothy], event.participants.map(&:name))
    assert_same(participant, event[:participant])
    assert_same(participants, event.to_h.fetch(:participants))
  end

  def test_nested_readers_preserve_existing_conversion_errors
    participant = Object.new
    event = NestedEvent.new(participant: participant)

    assert_raises(OpenAI::Errors::ConversionError) { event.participant }
    assert_same(participant, event[:participant])
    assert_same(participant, event.to_h.fetch(:participant))
  end

  def test_typed_readers_reject_nonviable_scalar_constructor_values
    event = ScalarContractEvent.new(active: "yes", status: "unknown")

    assert_raises(OpenAI::Errors::ConversionError) { event.active }
    assert_raises(OpenAI::Errors::ConversionError) { event.status }
    assert_equal("yes", event[:active])
    assert_equal("unknown", event[:status])
  end

  def test_typed_readers_reject_nil_for_required_non_nilable_fields
    event = ScalarContractEvent.new(active: nil)

    assert_raises(OpenAI::Errors::ConversionError) { event.active }
    assert_nil(event[:active])
  end

  def test_typed_readers_reject_missing_required_fields
    scalar_event = ScalarContractEvent.new
    nested_event = NestedEvent.new

    assert_raises(OpenAI::Errors::ConversionError) { scalar_event.active }
    assert_raises(OpenAI::Errors::ConversionError) { scalar_event.status }
    assert_raises(OpenAI::Errors::ConversionError) { scalar_event.flags }
    assert_raises(OpenAI::Errors::ConversionError) { nested_event.participant }
    assert_raises(OpenAI::Errors::ConversionError) { nested_event.participants }
    assert_raises(OpenAI::Errors::ConversionError) { nested_event.status }
  end

  def test_typed_readers_allow_nil_when_declared_nilable
    event = NullableScalarContractEvent.new(active: nil)

    assert_nil(event.active)
    assert_nil(event.participant)
    assert_nil(event[:active])
  end

  def test_nullable_readers_accept_explicit_nil_for_every_supported_shape
    readers = {
      name: lambda(&:name),
      kind: lambda(&:kind),
      count: lambda(&:count),
      amount: lambda(&:amount),
      active: lambda(&:active),
      participant: lambda(&:participant),
      participants: lambda(&:participants),
      status: lambda(&:status),
      choice: lambda(&:choice)
    }
    payload = readers.keys.to_h { [_1, nil] }
    constructed = NullableReaderContractEvent.new(payload)
    readers.each_value { assert_nil(_1.call(constructed)) }

    assigned = NullableReaderContractEvent.new
    assigned.name = nil
    assigned.kind = nil
    assigned.count = nil
    assigned.amount = nil
    assigned.active = nil
    assigned.participant = nil
    assigned.participants = nil
    assigned.status = nil
    assigned.choice = nil
    readers.each { |name, reader| assert_nil(reader.call(assigned), name.to_s) }

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(NullableReaderContractEvent, payload, state: state)

    assert_nil(state.fetch(:error))
    readers.each_value { assert_nil(_1.call(parsed)) }
    assert_equal(payload, constructed.to_h)
    assert_equal(payload, assigned.to_h)
    assert_equal(payload, parsed.to_h)
  end

  def test_union_readers_ignore_errors_from_rejected_alternatives
    choice = {}
    event = UnionContractEvent.new(choice: choice)

    assert_instance_of(EmptyUnionMember, event.choice)
    assert_same(choice, event[:choice])

    replacement = {}
    event.choice = replacement

    assert_instance_of(EmptyUnionMember, event.choice)
    assert_same(replacement, event.to_h.fetch(:choice))

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      UnionContractEvent,
      {choice: {}},
      state: state
    )

    assert_nil(state.fetch(:error))
    assert_instance_of(EmptyUnionMember, parsed.choice)
    assert_same(parsed[:choice], parsed.choice)
  end

  def test_symbol_readers_materialize_json_strings_without_replacing_raw_values
    kind = "ready"
    event = SymbolContractEvent.new(kind: kind)

    assert_equal(:ready, event.kind)
    assert_same(kind, event[:kind])

    replacement = "updated"
    event.kind = replacement

    assert_equal(:updated, event.kind)
    assert_same(replacement, event.to_h.fetch(:kind))

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      SymbolContractEvent,
      {kind: "parsed"},
      state: state
    )

    assert_equal(:parsed, parsed.kind)
  end

  def test_symbol_readers_materialize_nested_array_and_union_values
    kinds = ["ready"]
    nullable_kinds = ["ready", nil]
    nested_kinds = [["nested"]]
    choice = "selected"
    choices = ["first", 2]
    event = RecursiveSymbolContractEvent.new(
      kinds: kinds,
      nullable_kinds: nullable_kinds,
      nested_kinds: nested_kinds,
      choice: choice,
      choices: choices
    )

    assert_equal([:ready], event.kinds)
    assert_equal([:ready, nil], event.nullable_kinds)
    assert_equal([[:nested]], event.nested_kinds)
    assert_equal(:selected, event.choice)
    assert_equal([:first, 2], event.choices)
    assert_same(kinds, event[:kinds])
    assert_same(nullable_kinds, event[:nullable_kinds])
    assert_same(nested_kinds, event[:nested_kinds])
    assert_same(choice, event[:choice])
    assert_same(choices, event[:choices])
  end

  def test_symbol_readers_materialize_assigned_and_parsed_container_values
    kinds = ["assigned"]
    choice = "assigned"
    event = RecursiveSymbolContractEvent.new
    event.kinds = kinds
    event.choice = choice

    assert_equal([:assigned], event.kinds)
    assert_equal(:assigned, event.choice)
    assert_same(kinds, event.to_h.fetch(:kinds))
    assert_same(choice, event.to_h.fetch(:choice))

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      RecursiveSymbolContractEvent,
      {
        kinds: ["parsed"],
        nullable_kinds: ["parsed", nil],
        nested_kinds: [["parsed"]],
        choice: "parsed",
        choices: ["parsed", 3]
      },
      state: state
    )

    assert_nil(state.fetch(:error))
    assert_equal([:parsed], parsed.kinds)
    assert_equal([:parsed, nil], parsed.nullable_kinds)
    assert_equal([[:parsed]], parsed.nested_kinds)
    assert_equal(:parsed, parsed.choice)
    assert_equal([:parsed, 3], parsed.choices)
    assert_same(parsed[:kinds], parsed.kinds)
    assert_same(parsed[:nullable_kinds], parsed.nullable_kinds)
    assert_same(parsed[:choices], parsed.choices)
  end

  def test_symbol_readers_materialize_models_nested_in_arrays_and_unions
    participants = [{kind: "ready"}]
    choice = {kind: "selected"}
    event = NestedSymbolContractEvent.new(participants: participants, choice: choice)

    assert_equal(:ready, event.participants.first.kind)
    assert_equal(:selected, event.choice.kind)
    assert_same(participants, event[:participants])
    assert_same(choice, event[:choice])

    assigned_participants = [{kind: "assigned"}]
    assigned_choice = {kind: "assigned"}
    event.participants = assigned_participants
    event.choice = assigned_choice

    assert_equal(:assigned, event.participants.first.kind)
    assert_equal(:assigned, event.choice.kind)
    assert_same(assigned_participants, event.to_h.fetch(:participants))
    assert_same(assigned_choice, event.to_h.fetch(:choice))

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      NestedSymbolContractEvent,
      {participants: [{kind: "parsed"}], choice: {kind: "parsed"}},
      state: state
    )

    assert_nil(state.fetch(:error))
    assert_equal(:parsed, parsed.participants.first.kind)
    assert_equal(:parsed, parsed.choice.kind)
    assert_same(parsed[:participants], parsed.participants)
    assert_same(parsed[:choice], parsed.choice)
  end

  def test_supported_scalars_materialize_consistently_through_nested_model_shapes
    cases = {
      String => [:ready, "ready"],
      Symbol => ["ready", :ready],
      Integer => ["42", 42],
      Float => ["4.5", 4.5],
      OpenAI::Boolean => [true, true],
      OpenAI::EnumOf[:ready] => ["ready", :ready]
    }
    assert_readers = lambda do |event, expected|
      assert_equal(expected, event.member.value)
      assert_equal(expected, event.members.first.value)
      assert_equal(expected, event.choice.value)
    end

    cases.each do |type, (input, expected)|
      member = Class.new(OpenAI::BaseModel) { required :value, type }
      container = Class.new(OpenAI::BaseModel) do
        required :member, member
        required :members, OpenAI::ArrayOf[member]
        required :choice, OpenAI::UnionOf[String, member]
      end
      payload = {member: {value: input}, members: [{value: input}], choice: {value: input}}
      event = container.new(payload)

      assert_readers.call(event, expected)
      payload.each { |name, raw| assert_same(raw, event[name]) }

      event.members = payload.fetch(:members)
      event.choice = payload.fetch(:choice)

      assert_readers.call(event, expected)
      payload.each { |name, raw| assert_same(raw, event.to_h.fetch(name)) }

      state = OpenAI::Internal::Type::Converter.new_coerce_state
      parsed = OpenAI::Internal::Type::Converter.coerce(container, payload, state: state)

      assert_nil(state.fetch(:error))
      assert_readers.call(parsed, expected)
      assert_same(parsed[:members], parsed.members)
      assert_same(parsed[:choice], parsed.choice)
    end
  end

  def test_responses_api_parses_nested_structured_model_readers_end_to_end
    content = {participants: [{kind: "ready"}], choice: {kind: "selected"}}
    body = {
      id: "resp_contract",
      created_at: 1,
      model: "gpt-4o",
      object: "response",
      output: [
        {
          id: "msg_contract",
          type: "message",
          role: "assistant",
          status: "completed",
          content: [{type: "output_text", text: JSON.generate(content), annotations: []}]
        }
      ],
      parallel_tool_calls: false,
      tool_choice: "auto",
      tools: []
    }
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(body)
    )
    transport = OpenAI::HTTPClient.new
    client = OpenAI::Client.new(api_key: "test-key", http_client: transport)

    transport.stub(:execute, response) do
      result = client.responses.create(
        input: "Extract participants", model: "gpt-4o", text: NestedSymbolContractEvent
      )
      parsed = result.output.fetch(0).content.fetch(0).parsed

      assert_instance_of(NestedSymbolContractEvent, parsed)
      assert_equal(:ready, parsed.participants.fetch(0).kind)
      assert_equal(:selected, parsed.choice.kind)
      assert_same(parsed[:participants], parsed.participants)
    end
  end

  def test_chat_completions_parse_nested_structured_model_readers_end_to_end
    content = {participants: [{kind: "ready"}], choice: {kind: "selected"}}
    body = {
      id: "chatcmpl_contract",
      created: 1,
      model: "gpt-4o",
      object: "chat.completion",
      choices: [
        {
          index: 0,
          finish_reason: "stop",
          message: {role: "assistant", content: JSON.generate(content), refusal: nil}
        }
      ]
    }
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(body)
    )
    transport = OpenAI::HTTPClient.new
    client = OpenAI::Client.new(api_key: "test-key", http_client: transport)

    transport.stub(:execute, response) do
      result = client.chat.completions.create(
        messages: [{role: :user, content: "Extract participants"}],
        model: "gpt-4o",
        response_format: NestedSymbolContractEvent
      )
      parsed = result.choices.fetch(0).message.parsed

      assert_instance_of(NestedSymbolContractEvent, parsed)
      assert_equal(:ready, parsed.participants.fetch(0).kind)
      assert_equal(:selected, parsed.choice.kind)
      assert_same(parsed[:participants], parsed.participants)
    end
  end

  def test_typed_readers_reject_nonviable_scalar_assignment_values
    event = ScalarContractEvent.new
    event.active = "yes"
    event.status = "unknown"

    assert_raises(OpenAI::Errors::ConversionError) { event.active }
    assert_raises(OpenAI::Errors::ConversionError) { event.status }
    assert_equal("yes", event.to_h.fetch(:active))
    assert_equal("unknown", event.to_h.fetch(:status))
  end

  def test_typed_readers_reject_invalid_mutations_to_caller_owned_containers
    flags = [true]
    participants = [{name: "Ada"}]
    scalar_event = ScalarContractEvent.new(flags: flags)
    nested_event = NestedEvent.new(participants: participants)

    flags << "yes"
    participants << Object.new

    assert_raises(OpenAI::Errors::ConversionError) { scalar_event.flags }
    assert_raises(OpenAI::Errors::ConversionError) { nested_event.participants }
    assert_same(flags, scalar_event[:flags])
    assert_same(participants, nested_event[:participants])
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
      },
      U4 => {
        anyOf: [
          {type: "string"},
          {type: "null"}
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
