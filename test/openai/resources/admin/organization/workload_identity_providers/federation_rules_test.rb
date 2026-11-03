# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::WorkloadIdentityProviders::FederationRulesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.workload_identity_providers.federation_rules.create(
      "x",
      attribute_matchers: {foo: "string"},
      project_id: "x",
      service_account_id: "x"
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule
    end

    assert_pattern do
      response => {
          id: String,
          attribute_matchers: ^(OpenAI::Internal::Type::HashOf[
            union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher
          ]),
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          name: String | nil,
          object: Symbol,
          permissions: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions,
          project_id: String,
          service_account_id: String,
          updated_at: Integer,
          workload_identity_provider_id: String
        }
    end
  end

  def test_retrieve_required_params
    response = @openai.admin.organization.workload_identity_providers.federation_rules.retrieve(
      "x",
      workload_identity_provider_id: "x"
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule
    end

    assert_pattern do
      response => {
          id: String,
          attribute_matchers: ^(OpenAI::Internal::Type::HashOf[
            union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher
          ]),
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          name: String | nil,
          object: Symbol,
          permissions: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions,
          project_id: String,
          service_account_id: String,
          updated_at: Integer,
          workload_identity_provider_id: String
        }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.workload_identity_providers.federation_rules.update(
      "x",
      workload_identity_provider_id: "x"
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule
    end

    assert_pattern do
      response => {
          id: String,
          attribute_matchers: ^(OpenAI::Internal::Type::HashOf[
            union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher
          ]),
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          name: String | nil,
          object: Symbol,
          permissions: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions,
          project_id: String,
          service_account_id: String,
          updated_at: Integer,
          workload_identity_provider_id: String
        }
    end
  end

  def test_list
    response = @openai.admin.organization.workload_identity_providers.federation_rules.list("x")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule
    end

    assert_pattern do
      row => {
          id: String,
          attribute_matchers: ^(OpenAI::Internal::Type::HashOf[
            union: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::AttributeMatcher
          ]),
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          name: String | nil,
          object: Symbol,
          permissions: OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRule::Permissions,
          project_id: String,
          service_account_id: String,
          updated_at: Integer,
          workload_identity_provider_id: String
        }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.workload_identity_providers.federation_rules.delete(
      "x",
      workload_identity_provider_id: "x"
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProviders::FederationRuleDeleted
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
