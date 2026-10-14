# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::EnvironmentTokenPageTest < Minitest::Test
  def test_files_forward_token_and_preserve_filters_and_request_options
    token = "synthetic:token/+="
    requests = []
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    2.times do |index|
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(
          object: "page",
          data: [
            {
              object: "agent.environment.file",
              environment_id: "env_test",
              path: "/workspace/test/#{index}.txt",
              size_bytes: 1
            }
          ],
          next: index.zero? ? token : nil,
          has_more: index.zero?
        )
      )
      transport.expect(:execute, response) { |request|
        requests << request
        true
      }
    end

    client = OpenAI::Client.new(api_key: "synthetic", base_url: "https://sdk-test.example/v1", http_client: transport)
    page = client.beta.agents.environments.files.list(
      "env_test",
      path: "/workspace/test",
      order: :asc,
      limit: 1,
      request_options: {extra_headers: {"x-pagination-test" => "preserved", "OpenAI-Beta" => "agents=v1"}}
    )
    assert_instance_of(OpenAI::Internal::TokenPage, page)
    assert_equal(["/workspace/test/0.txt", "/workspace/test/1.txt"], page.to_enum.map(&:path))
    transport.verify
    assert_equal(2, requests.length)
    requests.each_with_index do |request, index|
      assert_equal("/v1/agents/environments/env_test/files", request.url.path)
      query = URI.decode_www_form(request.url.query).to_h
      expected = {"path" => "/workspace/test", "order" => "asc", "limit" => "1"}
      expected["page"] = token unless index.zero?
      assert_equal(expected, query)
      assert_equal("preserved", request.headers.fetch("x-pagination-test"))
      assert_equal("agents=v1", request.headers.fetch("openai-beta"))
    end
  end
end
