# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::AgentsPaginationTest < Minitest::Test
  def test_sessions_preserve_order_and_limit
    assert_two_pages("agents/sessions", {limit: 1, order: "asc"}) do |client|
      client.beta.agents.sessions.list(limit: 1, order: :asc, after: "before_first")
    end
  end

  def test_vaults_preserve_status_filter_and_limit
    assert_two_pages("vaults", {limit: 1, status: "archived"}) do |client|
      client.beta.agents.vaults.list(limit: 1, status: :archived, after: "before_first")
    end
  end

  def test_credentials_preserve_vault_path_and_status_filter
    assert_two_pages("vaults/vault_fake/credentials", {:limit => 1, "status[]" => %w[active archived]}) do |client|
      client.beta.agents.vaults.credentials.list(
        "vault_fake",
        limit: 1,
        status: [:active, :archived],
        after: "before_first"
      )
    end
  end

  def test_items_preserve_filter_and_follow_response_cursor
    assert_two_pages(
      "agents/sessions/session_test/items",
      {limit: 1, order: "asc"},
      cursor_key: :after
    ) do |client|
      client.beta.agents.sessions.items.list(
        "session_test",
        limit: 1,
        order: :asc,
        after: "before_first"
      )
    end
  end

  def test_turns_preserve_filter_and_follow_last_id
    assert_two_pages(
      "agents/sessions/session_test/turns",
      {limit: 1, order: "asc"},
      cursor_key: :last_id
    ) do |client|
      client.beta.agents.sessions.turns.list(
        "session_test",
        limit: 1,
        order: :asc,
        after: "before_first"
      )
    end
  end

  private def assert_two_pages(path, filters, cursor_key: nil)
    requests = []
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    [true, false].each_with_index do |has_more, index|
      item_id = "item_#{index + 1}"
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json", "x-request-id" => "request_#{index + 1}"},
        body: JSON.generate(
          {object: "list", data: [{id: item_id}], has_more: has_more, last_id: item_id}.merge(
            cursor_key ? {cursor_key => "item_#{index + 1}"} : {}
          )
        )
      )
      transport.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://sdk-test.example/v1",
      http_client: transport
    )

    first_page = yield(client)
    assert_instance_of(OpenAI::Internal::CursorPage, first_page)
    assert_equal("request_1", first_page._request_id)
    assert_equal(["item_1", "item_2"], first_page.to_enum.map(&:id))
    transport.verify
    assert_equal(2, requests.length)
    requests.each_with_index do |request, index|
      assert_equal("/v1/#{path}", request.url.path)
      query = URI.decode_www_form(request.url.query).group_by(&:first).transform_values { |pairs| pairs.map(&:last) }
      assert_equal([index.zero? ? "before_first" : "item_1"], query.fetch("after"))
      filters.each { |key, value| assert_equal(Array(value).map(&:to_s), query.fetch(key.to_s)) }
      assert_equal("agents=v1", request.headers.fetch("openai-beta"))
    end
  end
end
