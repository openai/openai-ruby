# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ProjectAPIKeyScopesTest < Minitest::Test
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

  def setup
    super
    @client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "fake-project-key",
      admin_api_key: "fake-admin-key",
      max_retries: 0
    )
    @keys = @client.admin.organization.projects.api_keys
    @url = "http://localhost/organization/projects/project_test/api_keys/key_test"
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_scope_only_request_preserves_expiration_and_uses_admin_auth
    stub = stub_update({scopes: ["api.all.read"]})
    response = @keys.update_scopes("key_test", project_id: "project_test", scopes: ["api.all.read"])

    assert_requested(stub, times: 1)
    assert_instance_of(OpenAI::Admin::Organization::Projects::ProjectAPIKey, response)
    assert_equal(1_700_003_600, response.expires_at)
    assert_equal("key_test", response.id)
  end

  def test_empty_scopes_are_sent_without_expiry
    stub = stub_update({scopes: []})
    response = @keys.update_scopes("key_test", project_id: "project_test", scopes: [])
    assert_equal("key_test", response.id)
    assert_requested(stub, times: 1)
  end

  def test_scopes_and_expiration_can_be_updated_in_one_request
    scopes = ["api.all.read"].freeze
    options = {extra_body: {expires_in_seconds: 3600}.freeze}.freeze
    stub = stub_update({scopes: scopes, expires_in_seconds: 3600})

    @keys.update_scopes("key_test", project_id: "project_test", scopes: scopes, request_options: options)

    assert_requested(stub, times: 1)
    assert_equal({extra_body: {expires_in_seconds: 3600}}, options)
    assert_equal(["api.all.read"], scopes)
  end

  def test_request_options_and_inputs_are_preserved
    scopes = ["api.files.read"].freeze
    headers = {"X-Test-Request" => "scope-test"}.freeze
    options = {extra_headers: headers}.freeze
    stub = stub_update({scopes: scopes}, {"X-Test-Request" => "scope-test"})
    @keys.update_scopes("key_test", project_id: "project_test", scopes: scopes, request_options: options)
    assert_requested(stub, times: 1)
    assert_equal(["api.files.read"], scopes)
    assert_equal({extra_headers: headers}, options)
  end

  def test_expiry_only_request_and_model_remain_compatible
    params = OpenAI::Admin::Organization::Projects::APIKeyUpdateParams.new(
      project_id: "project_test",
      api_key_id: "key_test",
      expires_in_seconds: 3600
    )
    assert_equal(3660, params.expires_in_seconds + 60)
    assert_equal(3600, params.to_hash.fetch(:expires_in_seconds))
    stub = stub_update({expires_in_seconds: 3600})
    @keys.update("key_test", project_id: "project_test", expires_in_seconds: 3600)
    assert_requested(stub, times: 1)
  end

  def test_update_accepts_scopes_without_expiration
    [["api.all.read"], []].each do |scopes|
      stub = stub_update({scopes: scopes})
      response = @keys.update("key_test", project_id: "project_test", scopes: scopes)
      assert_equal("key_test", response.id)
      assert_requested(stub, times: 1)
    end
  end

  def test_update_accepts_scopes_and_expiration_together
    stub = stub_update({scopes: ["api.all.read"], expires_in_seconds: 3600})
    response = @keys.update(
      "key_test",
      project_id: "project_test",
      scopes: ["api.all.read"],
      expires_in_seconds: 3600
    )
    assert_equal("key_test", response.id)
    assert_requested(stub, times: 1)
  end

  def test_update_model_omits_unspecified_expiration
    params = OpenAI::Admin::Organization::Projects::APIKeyUpdateParams.new(
      project_id: "project_test",
      api_key_id: "key_test",
      scopes: ["api.all.read"]
    )
    assert_nil(params.expires_in_seconds)
    assert_equal(["api.all.read"], params.scopes)
    refute_includes(params.to_hash.keys, :expires_in_seconds)
  end

  def test_scope_model_exports_typed_scopes_without_expiry
    params = OpenAI::Admin::Organization::Projects::APIKeyUpdateScopesParams.new(
      project_id: "project_test",
      scopes: ["api.all.read"]
    )
    assert_equal(["api.all.read"], params.scopes)
    refute_includes(params.to_hash.keys, :expires_in_seconds)
    stub = stub_update({scopes: ["api.all.read"]})
    response = @keys.update_scopes("key_test", **params)
    assert_requested(stub, times: 1)
    assert_equal("key_test", response.id)
  end

  def test_missing_scopes_and_expiry_keyword_are_rejected
    assert_raises(ArgumentError) { @keys.update_scopes("key_test", project_id: "project_test") }
    assert_raises(ArgumentError) do
      @keys.update_scopes("key_test", project_id: "project_test", scopes: [], expires_in_seconds: 3600)
    end

    assert_not_requested(:post, @url)
  end

  private

  def stub_update(body, headers = {})
    stub_request(:post, @url)
      .with do |request|
        JSON.parse(request.body, symbolize_names: true) == body &&
          request.headers["Authorization"] == "Bearer fake-admin-key" &&
          headers.all? { |key, value| request.headers[key] == value }
      end
      .to_return_json(
        body: {
          id: "key_test",
          object: "organization.project.api_key",
          name: "Synthetic key",
          redacted_value: "fake-redacted-key",
          created_at: 1_700_000_000,
          expires_at: 1_700_003_600,
          owner: {
            type: "service_account",
            service_account: {id: "sa_test", name: "Synthetic owner", role: "member", created_at: 1_700_000_000}
          }
        }
      )
  end
end
