# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ExternalStorageTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  Organization = OpenAI::Admin::Organization
  COLLECTION_URL = "http://localhost/organization/external_storage"
  ADMIN_HEADERS = {"Authorization" => "Bearer fake-admin-key"}.freeze

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def setup
    super
    @openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "fake-project-key",
      admin_api_key: "fake-admin-key",
      max_retries: 0
    )
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_create_aws_provider_with_distinct_response_metadata
    provider = Organization::ExternalStorageCreateParams::Provider::Aws.new(
      bucket: "test-bucket",
      role_arn: "arn:aws:iam::000000000000:role/test"
    )
    metadata = {
      **provider.to_h,
      type: "aws",
      account_id: "000000000000",
      region: "us-east-1",
      external_id: "test-external-id",
      future_provider_field: true
    }
    payload = configuration(metadata)
    stub_request(:post, COLLECTION_URL)
      .with(body: {project_id: "proj_test", provider: {**provider.to_h, type: "aws"}}, headers: ADMIN_HEADERS)
      .to_return_json(body: payload)

    response = @openai.admin.organization.external_storage.create(project_id: "proj_test", provider: provider)

    assert_requested(:post, COLLECTION_URL, times: 1)
    assert_instance_of(Organization::ExternalStorageConfiguration, response)
    assert_instance_of(Organization::AwsExternalStorageProvider, response.provider)
    assert_equal("test-external-id", response.provider.external_id)
    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
  end

  def test_create_azure_provider_with_distinct_response_metadata
    provider = Organization::ExternalStorageCreateParams::Provider::Azure.new(
      account_name: "test-account",
      container: "test-container",
      resource_group: "test-group",
      subscription_id: "test-subscription",
      tenant_id: "test-tenant"
    )
    payload = configuration({**provider.to_h, type: "azure", region: "eastus", future_provider_field: true})
    stub_request(:post, COLLECTION_URL)
      .with(body: {project_id: "proj_test", provider: {**provider.to_h, type: "azure"}}, headers: ADMIN_HEADERS)
      .to_return_json(body: payload)

    response = @openai.admin.organization.external_storage.create(project_id: "proj_test", provider: provider)

    assert_requested(:post, COLLECTION_URL, times: 1)
    assert_instance_of(Organization::AzureExternalStorageProvider, response.provider)
    assert_equal("eastus", response.provider.region)
    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
  end

  def test_create_gcp_provider_with_distinct_response_metadata
    provider = Organization::ExternalStorageCreateParams::Provider::Gcp.new(
      bucket: "test-bucket",
      workload_identity_pool_id: "test-pool",
      workload_identity_project_number: "000000000000",
      workload_identity_provider_id: "test-provider"
    )
    request_provider = {
      type: "gcp",
      bucket: "test-bucket",
      workload_identity_pool_id: "test-pool",
      workload_identity_project_number: "000000000000",
      workload_identity_provider_id: "test-provider"
    }
    payload = configuration(
      {**request_provider, audience: "test-audience", region: "us-central1", future_provider_field: true}
    )
    stub_request(:post, COLLECTION_URL)
      .with(body: {project_id: "proj_test", provider: request_provider}, headers: ADMIN_HEADERS)
      .to_return_json(body: payload)

    response = @openai.admin.organization.external_storage.create(project_id: "proj_test", provider: provider)

    assert_requested(:post, COLLECTION_URL, times: 1)
    assert_instance_of(Organization::GcpExternalStorageProvider, response.provider)
    assert_equal("test-audience", response.provider.audience)
    assert_equal("us-central1", response.provider.region)
    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
  end

  def test_id_operations_escape_paths_and_preserve_future_provider
    url = "#{COLLECTION_URL}/ext%2Fstorage%3Ftest"
    payload = configuration({type: "future", future_provider_field: true}, "ext/storage?test")
    deleted = {id: "ext/storage?test", object: "organization.external_storage.deleted", deleted: true}
    stub_request(:get, url).with(headers: ADMIN_HEADERS).to_return_json(body: payload)
    stub_request(:post, "#{url}/validate").with(body: "", headers: ADMIN_HEADERS).to_return_json(body: payload)
    stub_request(:delete, url).with(headers: ADMIN_HEADERS).to_return_json(body: deleted)

    retrieved = @openai.admin.organization.external_storage.retrieve("ext/storage?test")
    validated = @openai.admin.organization.external_storage.validate("ext/storage?test")
    response = @openai.admin.organization.external_storage.delete("ext/storage?test")

    assert_equal(JSON.parse(payload.to_json), JSON.parse(retrieved.to_json))
    assert_equal(JSON.parse(payload.to_json), JSON.parse(validated.to_json))
    assert_instance_of(Organization::ExternalStorageDeleted, response)
    assert_equal("ext/storage?test", response.id)
    assert(response.deleted)
    assert_requested(:get, url, times: 1)
    assert_requested(:post, "#{url}/validate", times: 1)
    assert_requested(:delete, url, times: 1)
  end

  def test_pagination_preserves_filters_and_admin_auth
    filters = {project_id: "proj_test", order: "desc", limit: "1"}
    ["extstorage_first", "extstorage_last"].each_with_index do |id, index|
      query = index.zero? ? filters : filters.merge(after: "extstorage_first")
      stub_request(:get, COLLECTION_URL).with(query: query, headers: ADMIN_HEADERS).to_return_json(
        body: {
          object: "list",
          data: [configuration({type: "future"}, id)],
          first_id: id,
          last_id: id,
          has_more: index.zero?
        }
      )
    end

    page = @openai.admin.organization.external_storage.list(project_id: "proj_test", order: :desc, limit: 1)

    assert_instance_of(OpenAI::Internal::CursorPage, page)
    assert_equal(["extstorage_first", "extstorage_last"], page.to_enum.map(&:id))
    assert_requested(:get, COLLECTION_URL, query: filters, headers: ADMIN_HEADERS, times: 1)
    assert_requested(
      :get,
      COLLECTION_URL,
      query: filters.merge(after: "extstorage_first"),
      headers: ADMIN_HEADERS,
      times: 1
    )
  end

  def test_missing_admin_key_never_falls_back_to_project_key
    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "fake-project-key",
      admin_api_key: nil,
      max_retries: 0
    )

    error = assert_raises(ArgumentError) { client.admin.organization.external_storage.retrieve("extstorage_test") }

    assert_match(/Could not resolve authentication method/, error.message)
    assert_not_requested(:any, /./)
  end

  private def configuration(provider, id = "extstorage_test")
    {
      id: id,
      object: "organization.external_storage",
      project_id: "proj_test",
      provider: provider,
      geography: "US",
      status: "validated",
      created_at: 123,
      future_configuration_field: true
    }
  end
end
