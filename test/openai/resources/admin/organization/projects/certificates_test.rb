# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::CertificatesTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.admin.organization.projects.certificates.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Certificate
    end

    assert_pattern do
      row => {
        id: String,
        certificate_details: OpenAI::Admin::Organization::Certificate::CertificateDetails,
        created_at: Integer,
        name: String,
        object: OpenAI::Admin::Organization::Certificate::Object,
        active: OpenAI::Internal::Type::Boolean | nil
      }
    end
  end

  def test_activate_required_params
    response =
      @openai.admin.organization.projects.certificates.activate("project_id", certificate_ids: ["cert_abc"])

    assert_pattern do
      response => OpenAI::Internal::Page
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Certificate
    end

    assert_pattern do
      row => {
        id: String,
        certificate_details: OpenAI::Admin::Organization::Certificate::CertificateDetails,
        created_at: Integer,
        name: String,
        object: OpenAI::Admin::Organization::Certificate::Object,
        active: OpenAI::Internal::Type::Boolean | nil
      }
    end
  end

  def test_deactivate_required_params
    response =
      @openai.admin.organization.projects.certificates.deactivate("project_id", certificate_ids: ["cert_abc"])

    assert_pattern do
      response => OpenAI::Internal::Page
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Certificate
    end

    assert_pattern do
      row => {
        id: String,
        certificate_details: OpenAI::Admin::Organization::Certificate::CertificateDetails,
        created_at: Integer,
        name: String,
        object: OpenAI::Admin::Organization::Certificate::Object,
        active: OpenAI::Internal::Type::Boolean | nil
      }
    end
  end
end
