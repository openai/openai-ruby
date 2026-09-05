# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ServiceAccountAPIKeyExpirationTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_create_serializes_lifetime_and_decodes_expiration
    url = "http://localhost/organization/projects/project_test/service_accounts/service_account_test/api_keys"
    stub_request(:post, url)
      .with(body: {expires_in_seconds: 3600}, headers: {"Authorization" => "Bearer fake-admin-key"})
      .to_return_json(
        status: 200,
        body: {
          id: "key_test",
          created_at: 1_700_000_000,
          name: "Expiring test key",
          object: "organization.project.service_account.api_key",
          value: "fake-service-account-key",
          expires_at: 1_700_003_600
        }
      )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "fake-project-key",
      admin_api_key: "fake-admin-key",
      max_retries: 0
    )
    response = client.admin.organization.projects.service_accounts.api_keys.create(
      "service_account_test",
      project_id: "project_test",
      expires_in_seconds: 3600
    )

    assert_requested(:post, url, times: 1)
    assert_instance_of(OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse, response)
    assert_equal(1_700_003_600, response.expires_at)
  end
end
