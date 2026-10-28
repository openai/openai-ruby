# frozen_string_literal: true

require_relative "openai/test_helper"

class ExternalKeysContractTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @keys = OpenAI::Client
      .new(
        base_url: "http://localhost/v1",
        api_key: "project-key",
        admin_api_key: "admin-key",
        max_retries: 0
      )
      .admin
      .organization
      .external_keys
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def key(id = "key_1")
    {
      id: id,
      object: "organization.external_key",
      name: "Example",
      type: "aws",
      created_at: 1,
      workspace_id: "org_1",
      api_project_ids: []
    }
  end

  def test_provider_payloads_preserve_versions_and_omit_default_purpose
    [
      {type: "aws", name: "Example", external_id: "org_1", kms_arn: "arn:key", role_arn: "arn:role"},
      {
        type: "gcp",
        name: "Example",
        audience: "org_1",
        kms_project_id: "project",
        kms_key_location: "global",
        kms_key_ring_name: "ring",
        kms_key_name: "key",
        kms_key_version: "7",
        workload_identity_pool_id: "pool",
        workload_identity_project_number: "123",
        workload_identity_provider_id: "provider",
        purpose: "psp_decryption"
      },
      {
        type: "azure",
        name: "Example",
        tenant_id: "tenant",
        vault_uri: "https://vault.example",
        key_name: "key",
        key_version: "version",
        purpose: "psp_decryption"
      }
    ].each do |body|
      request = stub_request(:post, "http://localhost/v1/organization/external_keys")
        .with(headers: {"Authorization" => "Bearer admin-key"})
        .with { |req| JSON.parse(req.body) == body.transform_keys(&:to_s) }
        .to_return(headers: {"content-type" => "application/json"}, body: JSON.generate(key))

      model = {
        "aws" => OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws,
        "gcp" => OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp,
        "azure" => OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure
      }.fetch(body.fetch(:type))

      assert_equal("key_1", @keys.create(body: body).id)
      assert_equal("key_1", @keys.create(body: model.new(**body.except(:type))).id)
      assert_requested(request, times: 2)
      WebMock.reset!
    end
  end

  def test_filtered_pagination_preserves_filter_and_advances_after
    base_query = {"purpose" => "psp_decryption", "limit" => "1", "order" => "asc"}
    first = stub_request(:get, "http://localhost/v1/organization/external_keys")
      .with(query: base_query, headers: {"Authorization" => "Bearer admin-key"})
      .to_return(
        headers: {"content-type" => "application/json"},
        body: JSON.generate(
          object: "list",
          data: [key],
          has_more: true,
          first_id: "key_1",
          last_id: "key_1"
        )
      )
    second = stub_request(:get, "http://localhost/v1/organization/external_keys")
      .with(query: base_query.merge("after" => "key_1"), headers: {"Authorization" => "Bearer admin-key"})
      .to_return(
        headers: {"content-type" => "application/json"},
        body: JSON.generate(
          object: "list",
          data: [key("key_2")],
          has_more: false,
          first_id: "key_2",
          last_id: "key_2"
        )
      )

    ids = []
    @keys.list(purpose: :psp_decryption, limit: 1, order: :asc).auto_paging_each { |item| ids << item.id }

    assert_equal(%w[key_1 key_2], ids)
    assert_requested(first, times: 1)
    assert_requested(second, times: 1)
  end

  def test_lifecycle_uses_admin_key_and_delete_returns_full_resource
    url = "http://localhost/v1/organization/external_keys/key_1"
    [:get, :delete].each do |method|
      request = stub_request(method, url)
        .with(headers: {"Authorization" => "Bearer admin-key"})
        .to_return(headers: {"content-type" => "application/json"}, body: JSON.generate(key))
      response = method == :get ? @keys.retrieve("key_1") : @keys.delete("key_1")

      assert_equal("key_1", response.id)
      assert_equal("organization.external_key", response.object)
      assert_equal("org_1", response.workspace_id)
      assert_requested(request, times: 1)
    end

    request = stub_request(:post, "#{url}/validate")
      .with(headers: {"Authorization" => "Bearer admin-key"})
      .to_return(headers: {"content-type" => "application/json"}, body: "{\"status\":\"valid\"}")

    assert_equal("valid", @keys.validate("key_1").status.to_s)
    assert_requested(request, times: 1)
  end
end
