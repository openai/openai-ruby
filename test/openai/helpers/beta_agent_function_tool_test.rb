# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::BetaAgentFunctionToolTest < Minitest::Test
  class Recipient < OpenAI::BaseModel
    required :address, String, api_name: :wallet_address
  end

  class Transfer < OpenAI::BaseModel
    required :recipient, Recipient
    required :amount, String
    required :asset, OpenAI::EnumOf[:USDC, :ETH]
    required :memo, String, nil?: true
  end

  class Wallet
    attr_reader :transfers
    def initialize = @transfers = []
    def transfer(arguments)
      @transfers << arguments
      {receipt: "fake-receipt", amount: arguments.amount}
    end
  end

  def setup
    super
    @wallet = Wallet.new
    @tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(
      name: "transfer",
      arguments: Transfer,
      description: "Transfer an approved amount from the application's wallet.",
      &@wallet.method(:transfer)
    )
    @arguments = {recipient: {wallet_address: "fake-address"}, amount: "1.00", asset: "USDC", memo: nil}
  end

  def test_flat_agent_definition_serializes_without_callback_or_wallet
    definition = @tool.definition
    assert_equal("function", definition[:type])
    assert_equal("transfer", definition[:name])
    assert_equal(JSON.parse(JSON.generate(Transfer.to_json_schema), symbolize_names: true), definition[:parameters])
    assert_equal(%i[description name parameters type], definition.keys.sort)
    wire, = OpenAI::Beta::Agents::SessionCreateParams.dump_request(
      agent: {model: "test-model", tools: [definition]},
      environment: {type: :none},
      input: "Hi"
    )
    assert_equal(JSON.parse(JSON.generate(definition)), JSON.parse(JSON.generate(wire))["agent"]["tools"].first)
    definition[:parameters][:properties].clear
    refute_empty(@tool.definition[:parameters][:properties])
  end

  def test_bound_action_receives_parsed_arguments
    assert_equal({receipt: "fake-receipt", amount: "1.00"}, @tool.handlers.fetch("transfer").call(@arguments))
    args = @wallet.transfers.fetch(0)
    assert_instance_of(Transfer, args)
    assert_instance_of(Recipient, args.recipient)
    assert_equal("fake-address", args.recipient.address)
    assert_equal(:USDC, args.asset)
    assert_nil(args.memo)
    assert_equal("USDC", @arguments[:asset])
    assert_equal("1.00", @tool.call(JSON.generate(@arguments))[:amount])
  end

  def test_non_objects_and_malformed_json_never_reach_the_application
    [[], nil, "\"text\"", "{broken", @arguments.except(:amount), @arguments.merge(amount: [])].each do |arguments|
      assert_raises(ArgumentError, JSON::ParserError) { @tool.call(arguments) }
    end

    assert_empty(@wallet.transfers)
  end

  def test_native_parser_accepts_integral_floats_and_preserves_union_data
    first = Class.new(OpenAI::BaseModel) { required(:x, String) }
    second = Class.new(OpenAI::BaseModel) do
      required(:x, String)
      required(:y, String)
    end

    model = Class.new(OpenAI::BaseModel) do
      required(:count, Integer)
      required(:choice, OpenAI::UnionOf[first, second])
    end

    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "parse", arguments: model) { _1 }
    parsed = tool.call(count: 1.0, choice: {x: "x", y: "y"})
    assert_instance_of(model, parsed)
    assert_equal(1, parsed.count)
    # Existing BaseModel parsing chooses the first matching union model and retains
    # fields it does not recognize, just as the structured-output helpers do.
    assert_instance_of(first, parsed.choice)
    assert_equal("y", parsed.choice[:y])
  end

  def test_application_validates_constraints_before_side_effects
    model = Class.new(OpenAI::BaseModel) { required(:code, String, pattern: "^[a-z]+$") }
    actions = []
    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "action", arguments: model) do |args|
      raise ArgumentError, "invalid action code" unless args.code.is_a?(String) && args.code.match?(/\A[a-z]+\z/)
      actions << args.code
      "approved"
    end

    assert_equal("^[a-z]+$", tool.definition[:parameters][:properties][:code][:pattern])
    assert_raises(ArgumentError) { tool.call(code: "ABC") }
    assert_empty(actions)
    assert_equal("approved", tool.call(code: "valid"))
    assert_equal(["valid"], actions)
  end

  def test_requires_a_model_and_explicit_callback

    assert_raises(ArgumentError) {
      OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "bad", arguments: Hash) { nil }
    }
    assert_raises(ArgumentError) { OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "bad", arguments: Transfer) }
    assert_raises(ArgumentError) {
      OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "", arguments: Transfer) { nil }
    }
  end

  def test_symbol_fields_and_nonfinite_schema_constants_follow_native_parsing
    model = Class.new(OpenAI::BaseModel) do
      required(:kind, Symbol)
      required(:value, const: Float::INFINITY)
    end

    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "parse", arguments: model) { _1 }
    parsed = tool.call(kind: "hello", value: 1)
    assert_equal(:hello, parsed.kind)
    assert_equal(1, parsed.value)
    assert_equal({type: "number"}, tool.definition[:parameters][:properties][:value])
  end

  def test_constructor_snapshots_caller_owned_description_and_metadata
    description = +"Original description"
    field_doc = +"Original field"
    model = Class.new(OpenAI::BaseModel) { required(:value, String, doc: field_doc) }
    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "parse", arguments: model, description: description) {
      _1
    }
    description.replace("Changed")
    field_doc.replace("Changed")
    assert_equal("Original description", tool.definition[:description])
    assert_equal("Original field", tool.definition[:parameters][:properties][:value][:description])
  end
end
