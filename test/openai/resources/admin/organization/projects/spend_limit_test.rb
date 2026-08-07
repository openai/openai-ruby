# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::SpendLimitTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.projects.spend_limit.retrieve("proj_123")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectSpendLimit
    end

    assert_pattern do
      response => {
        currency: OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency,
        enforcement: OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement,
        interval: OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.projects.spend_limit.update(
        "proj_123",
        currency: :USD,
        interval: :month,
        threshold_amount: 1
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectSpendLimit
    end

    assert_pattern do
      response => {
        currency: OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency,
        enforcement: OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement,
        interval: OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.projects.spend_limit.delete("proj_123")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectSpendLimitDeleted
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
