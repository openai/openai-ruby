# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::SpendLimitTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.spend_limit.retrieve

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendLimit
    end

    assert_pattern do
      response => {
        currency: OpenAI::Admin::Organization::OrganizationSpendLimit::Currency,
        enforcement: OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement,
        interval: OpenAI::Admin::Organization::OrganizationSpendLimit::Interval,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.spend_limit.update(currency: :USD, interval: :month, threshold_amount: 1)

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendLimit
    end

    assert_pattern do
      response => {
        currency: OpenAI::Admin::Organization::OrganizationSpendLimit::Currency,
        enforcement: OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement,
        interval: OpenAI::Admin::Organization::OrganizationSpendLimit::Interval,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.spend_limit.delete

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendLimitDeleted
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
