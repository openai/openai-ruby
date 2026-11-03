# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::ServiceTierSettingsTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.projects.service_tier_settings.retrieve("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings
    end

    assert_pattern do
      response => {
          default: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default,
          enabled_tiers: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers,
          object: Symbol
        }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.projects.service_tier_settings.update("project_id", default: :standard)

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings
    end

    assert_pattern do
      response => {
          default: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::Default,
          enabled_tiers: OpenAI::Admin::Organization::Projects::ProjectServiceTierSettings::EnabledTiers,
          object: Symbol
        }
    end
  end
end
