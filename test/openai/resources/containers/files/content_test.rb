# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Containers::Files::ContentTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    skip("Prism doesn't support application/binary responses")

    response = @openai.containers.files.content.retrieve("file_id", container_id: "container_id")

    assert_pattern do
      response => StringIO
    end
  end
end
