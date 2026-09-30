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

  def test_invalid_arguments_never_reach_the_application
    [
      @arguments.except(:amount),
      @arguments.except(:memo),
      @arguments.merge(amount: 1),
      @arguments.merge(asset: "UNKNOWN"),
      @arguments.merge(extra: true),
      @arguments.merge(recipient: {}),
      @arguments.merge(recipient: {wallet_address: "fake-address", extra: true}),
      @arguments.merge(recipient: {wallet_address: 42}),
      @arguments.merge(memo: false),
      [],
      nil,
      "{broken"
    ].each do |arguments|
      assert_raises(ArgumentError, JSON::ParserError) { @tool.call(arguments) }
    end

    assert_empty(@wallet.transfers)
  end

  def test_arrays_nullable_fields_constants_and_unions
    child = Class.new(OpenAI::BaseModel) { required(:count, Integer) }
    model = Class.new(OpenAI::BaseModel) do
      required(:children, OpenAI::ArrayOf[child])
      required(:choice, OpenAI::UnionOf[String, Integer])
      required(:version, const: 1)
    end

    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "batch", arguments: model) { _1 }
    parsed = tool.call(children: [{count: 2}], choice: 3, version: 1)
    assert_equal(2, parsed.children.first.count)
    assert_equal(3, parsed.choice)
    assert_raises(ArgumentError) { tool.call(children: [{count: "2"}], choice: 3, version: 1) }
    assert_raises(ArgumentError) { tool.call(children: [{}], choice: 3, version: 1) }
    assert_raises(ArgumentError) { tool.call(children: [], choice: true, version: 1) }
    assert_raises(ArgumentError) { tool.call(children: [], choice: "ok", version: 2) }
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
end
