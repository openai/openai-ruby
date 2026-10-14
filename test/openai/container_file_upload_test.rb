# frozen_string_literal: true

require_relative "test_helper"
require "tempfile"

class OpenAI::Test::ContainerFileUploadTest < Minitest::Test
  def test_create_with_file_streams_multipart_content
    Tempfile.create(["container-file-", ".txt"]) do |file|
      file.write("container contents")
      file.flush

      request = create_request(file: Pathname(file.path))
      body = request.body.to_a.join

      assert_match(%r{\Amultipart/form-data; boundary=}, request.headers.fetch("content-type"))
      refute_instance_of(String, request.body)
      assert_includes(body, "name=\"file\"; filename=\"#{File.basename(file.path)}\"")
      assert_includes(body, "container contents")
      refute_includes(body, file.path)
    end
  end

  def test_create_with_file_id_preserves_json_request
    request = create_request(file: nil, file_id: "file_123")

    assert_equal("application/json", request.headers.fetch("content-type"))
    assert_equal(JSON.generate(file: nil, file_id: "file_123"), request.body)
  end

  private def create_request(params)
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(
        id: "cfile_123",
        bytes: 18,
        container_id: "container_id",
        created_at: 1,
        object: "container.file",
        path: "/mnt/data/file.txt",
        source: "user"
      )
    )
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    request = nil
    transport.expect(:execute, response) do |value|
      request = value
      true
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://example.test/v1",
      http_client: transport,
      max_retries: 0
    )

    result = client.containers.files.create("container_id", params)

    assert_instance_of(OpenAI::Models::Containers::FileCreateResponse, result)
    assert_mock(transport)
    request
  end
end
