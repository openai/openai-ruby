# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::SkillsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.skills.create

    assert_pattern do
      response => OpenAI::Skill
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        default_version: String,
        description: String,
        latest_version: String,
        name: String,
        object: Symbol
      }
    end
  end

  def test_retrieve
    response = @openai.skills.retrieve("skill_123")

    assert_pattern do
      response => OpenAI::Skill
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        default_version: String,
        description: String,
        latest_version: String,
        name: String,
        object: Symbol
      }
    end
  end

  def test_update_required_params
    response = @openai.skills.update("skill_123", default_version: "default_version")

    assert_pattern do
      response => OpenAI::Skill
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        default_version: String,
        description: String,
        latest_version: String,
        name: String,
        object: Symbol
      }
    end
  end

  def test_list
    response = @openai.skills.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Skill
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        default_version: String,
        description: String,
        latest_version: String,
        name: String,
        object: Symbol
      }
    end
  end

  def test_delete
    response = @openai.skills.delete("skill_123")

    assert_pattern do
      response => OpenAI::DeletedSkill
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
