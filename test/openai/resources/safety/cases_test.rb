# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Safety::CasesTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.safety.cases.retrieve("id")

    assert_pattern do
      response => OpenAI::Safety::SafetyCase
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          entity_identifier: String,
          notice: OpenAI::Safety::SafetyCase::Notice,
          object: Symbol,
          reason: String | nil
        }
    end
  end
end
