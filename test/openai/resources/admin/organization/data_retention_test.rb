# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::DataRetentionTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.data_retention.retrieve

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationDataRetention
    end

    assert_pattern do
      response => {
        object: Symbol,
        type: OpenAI::Admin::Organization::OrganizationDataRetention::Type
      }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.data_retention.update(retention_type: :zero_data_retention)

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationDataRetention
    end

    assert_pattern do
      response => {
        object: Symbol,
        type: OpenAI::Admin::Organization::OrganizationDataRetention::Type
      }
    end
  end
end
