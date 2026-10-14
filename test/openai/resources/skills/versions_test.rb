# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Skills::VersionsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.skills.versions.create("skill_123")

    assert_pattern do
      response => OpenAI::Skills::SkillVersion
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String,
        name: String,
        object: Symbol,
        skill_id: String,
        version: String
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.skills.versions.retrieve("version", skill_id: "skill_123")

    assert_pattern do
      response => OpenAI::Skills::SkillVersion
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        description: String,
        name: String,
        object: Symbol,
        skill_id: String,
        version: String
      }
    end
  end

  def test_list
    response = @openai.skills.versions.list("skill_123")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Skills::SkillVersion
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        description: String,
        name: String,
        object: Symbol,
        skill_id: String,
        version: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.skills.versions.delete("version", skill_id: "skill_123")

    assert_pattern do
      response => OpenAI::Skills::DeletedSkillVersion
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol,
        version: String
      }
    end
  end
end
