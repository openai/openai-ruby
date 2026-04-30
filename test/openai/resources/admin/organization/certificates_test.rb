# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::CertificatesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.certificates.create(content: "content")

    assert_pattern do
      response => OpenAI::Admin::Organization::Certificate
    end

    assert_pattern do
      response => {
        id: String,
        certificate_details: OpenAI::Admin::Organization::Certificate::CertificateDetails,
        created_at: Integer,
        name: String,
        object: OpenAI::Admin::Organization::Certificate::Object,
        active: OpenAI::Internal::Type::Boolean | nil
      }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.certificates.retrieve("certificate_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Certificate
    end

    assert_pattern do
      response => {
        id: String,
        certificate_details: OpenAI::Admin::Organization::Certificate::CertificateDetails,
        created_at: Integer,
        name: String,
        object: OpenAI::Admin::Organization::Certificate::Object,
        active: OpenAI::Internal::Type::Boolean | nil
      }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.certificates.update("certificate_id", name: "name")

    assert_pattern do
      response => OpenAI::Admin::Organization::Certificate
    end

    assert_pattern do
      response => {
        id: String,
        certificate_details: OpenAI::Admin::Organization::Certificate::CertificateDetails,
        created_at: Integer,
        name: String,
        object: OpenAI::Admin::Organization::Certificate::Object,
        active: OpenAI::Internal::Type::Boolean | nil
      }
    end
  end

  def test_list
    response = @openai.admin.organization.certificates.list

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

  def test_delete
    response = @openai.admin.organization.certificates.delete("certificate_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::CertificateDeleteResponse
    end

    assert_pattern do
      response => {
        id: String,
        object: Symbol
      }
    end
  end

  def test_activate_required_params
    response = @openai.admin.organization.certificates.activate(certificate_ids: ["cert_abc"])

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
    response = @openai.admin.organization.certificates.deactivate(certificate_ids: ["cert_abc"])

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
