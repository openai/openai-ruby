# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Skills::Versions::ContentTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    skip("Prism doesn't support application/binary responses")

    response = @openai.skills.versions.content.retrieve("version", skill_id: "skill_123")

    assert_pattern do
      response => StringIO
    end
  end
end
