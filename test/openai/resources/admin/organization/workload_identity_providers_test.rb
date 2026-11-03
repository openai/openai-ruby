# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::WorkloadIdentityProvidersTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.workload_identity_providers.create(
      audience: "x",
      issuer: "x",
      name: "x",
      type: :oidc
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProvider
    end

    assert_pattern do
      response => {
          id: String,
          attribute_transformations: ^(OpenAI::Internal::Type::ArrayOf[
            OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation
          ]),
          audience: String,
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          issuer: String,
          name: String,
          object: Symbol,
          type: Symbol,
          updated_at: Integer,
          verification: OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification
        }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.workload_identity_providers.retrieve("x")

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProvider
    end

    assert_pattern do
      response => {
          id: String,
          attribute_transformations: ^(OpenAI::Internal::Type::ArrayOf[
            OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation
          ]),
          audience: String,
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          issuer: String,
          name: String,
          object: Symbol,
          type: Symbol,
          updated_at: Integer,
          verification: OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification
        }
    end
  end

  def test_update
    response = @openai.admin.organization.workload_identity_providers.update("x")

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProvider
    end

    assert_pattern do
      response => {
          id: String,
          attribute_transformations: ^(OpenAI::Internal::Type::ArrayOf[
            OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation
          ]),
          audience: String,
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          issuer: String,
          name: String,
          object: Symbol,
          type: Symbol,
          updated_at: Integer,
          verification: OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification
        }
    end
  end

  def test_list
    response = @openai.admin.organization.workload_identity_providers.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::WorkloadIdentityProvider
    end

    assert_pattern do
      row => {
          id: String,
          attribute_transformations: ^(OpenAI::Internal::Type::ArrayOf[
            OpenAI::Admin::Organization::WorkloadIdentityProvider::AttributeTransformation
          ]),
          audience: String,
          created_at: Integer,
          description: String | nil,
          enabled: OpenAI::Internal::Type::Boolean,
          issuer: String,
          name: String,
          object: Symbol,
          type: Symbol,
          updated_at: Integer,
          verification: OpenAI::Admin::Organization::WorkloadIdentityProvider::Verification
        }
    end
  end

  def test_delete
    response = @openai.admin.organization.workload_identity_providers.delete("x")

    assert_pattern do
      response => OpenAI::Admin::Organization::WorkloadIdentityProviderDeleted
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
