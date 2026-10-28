# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::LiveDecisionCompatibilityTest < Minitest::Test
  def test_released_choice_constructors_accept_string_and_boolean_options
    live = OpenAI::Models::Live
    [
      live::DecisionTrigger::Decisions,
      live::DecisionsDelegationConfig,
      live::DecisionsDelegationUpdateConfig
    ].each do |owner|
      ["accept", false].each do |value|
        option = owner::Question::Choice::Choice.new(value: value, description: "label")
        question = owner::Question::Choice.new(instructions: "pick", choices: [option])
        assert_equal(value, question.choices.first.value)
        assert_equal("label", question.choices.first.description)
        assert_same(live::DecisionChoiceOption::Value, owner::Question::Choice::Choice::Value)
      end
    end
  end
end
