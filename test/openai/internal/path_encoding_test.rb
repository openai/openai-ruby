# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::PathEncodingTest < Minitest::Test
  def test_encode_path_rejects_dot_only_segments
    %w[. ..].each do |segment|
      error = assert_raises(ArgumentError) { OpenAI::Internal::Util.encode_path(segment) }

      assert_match(/path segment/, error.message)
    end
  end

  def test_encode_path_preserves_identifiers_and_escapes_slashes
    {
      "group_123" => "group_123",
      "group.id" => "group.id",
      ".group" => ".group",
      "group." => "group.",
      "..." => "...",
      "group/../role" => "group%2F..%2Frole",
      "../role" => "..%2Frole",
      "%2e" => "%252e",
      "%2e%2e" => "%252e%252e",
      123 => "123"
    }.each do |segment, expected|
      assert_equal(expected, OpenAI::Internal::Util.encode_path(segment))
    end
  end

  def test_interpolate_path_rejects_dot_segments_in_every_position
    %w[. ..].each do |segment|
      [
        [segment, "group_123", "role_123"],
        ["proj_123", segment, "role_123"],
        ["proj_123", "group_123", segment]
      ].each do |identifiers|
        assert_raises(ArgumentError) do
          OpenAI::Internal::Util.interpolate_path(
            ["projects/%1$s/groups/%2$s/roles/%3$s", *identifiers]
          )
        end
      end
    end
  end

  def test_nested_admin_deletes_reject_dot_segments_before_transport
    transport = OpenAI::HTTPClient.new
    unexpected_request = lambda do |request|
      flunk("Unexpected #{request.method.to_s.upcase} #{request.url.path}")
    end

    transport.stub(:execute, unexpected_request) do
      client = OpenAI::Client.new(
        admin_api_key: "test-admin-key",
        base_url: "https://example.com/v1",
        http_client: transport
      )
      resources = [
        [client.admin.organization.projects.groups.roles, :group_id],
        [client.admin.organization.projects.users.roles, :user_id]
      ]

      %w[.. .].each do |segment|
        resources.each do |resource, scoped_identifier|
          [
            ["proj_123", segment, "role_123"],
            [segment, "scoped_123", "role_123"],
            ["proj_123", "scoped_123", segment]
          ].each do |project_id, scoped_id, role_id|
            assert_raises(ArgumentError) do
              resource.delete(role_id, project_id: project_id, scoped_identifier => scoped_id)
            end
          end
        end
      end
    end
  end

  def test_nested_admin_deletes_preserve_endpoint_and_escape_slashes
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    [
      "/v1/projects/proj.123/groups/group%2F123/roles/role%2F123",
      "/v1/projects/proj.123/users/user%2F123/roles/role%2F123"
    ].each do |expected_path|
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: ['{"deleted":true,"object":"role.deleted"}']
      )
      transport.expect(:execute, response) do |request|
        assert_equal(:delete, request.method)
        assert_equal(expected_path, request.url.path)
        assert_equal("Bearer test-admin-key", request.headers.fetch("authorization"))

        true
      end
    end

    client = OpenAI::Client.new(
      admin_api_key: "test-admin-key",
      base_url: "https://example.com/v1",
      http_client: transport
    )
    client.admin.organization.projects.groups.roles.delete(
      "role/123",
      project_id: "proj.123",
      group_id: "group/123"
    )
    client.admin.organization.projects.users.roles.delete(
      "role/123",
      project_id: "proj.123",
      user_id: "user/123"
    )

    assert_mock(transport)
  end
end
