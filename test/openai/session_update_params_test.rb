# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::SessionUpdateParamsTest < Minitest::Test
  def test_update_serialization_preserves_omission_values_and_null
    cases = [
      {},
      {agent: {}},
      {agent: {reasoning: {}}},
      {agent: {model: ""}},
      {agent: {model: "gpt-5", reasoning: {effort: :low}, service_tier: :priority}},
      {agent: {reasoning: {effort: nil}, service_tier: nil}},
      {metadata: {purpose: "test"}},
      {metadata: nil},
      {metadata: {}}
    ]

    cases.each do |params|
      body, options = OpenAI::Beta::Agents::SessionUpdateParams.dump_request(params)

      assert_equal(JSON.parse(JSON.generate(params)), JSON.parse(JSON.generate(body)), params.inspect)
      assert_empty(options)
    end
  end
end
