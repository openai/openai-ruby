# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ContentProvenanceChecksTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.content_provenance_checks.create(file: StringIO.new("Example data"))

    assert_pattern do
      response => OpenAI::ContentProvenanceCheck
    end

    assert_pattern do
      response => {
        created_at: Integer,
        object: OpenAI::ContentProvenanceCheck::Object,
        results: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::ContentProvenanceCheck::Result])
      }
    end
  end
end
