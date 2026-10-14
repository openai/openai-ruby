# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::DecisionsUsageQueryTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @client = OpenAI::Client.new(
      api_key: "fake-project-key",
      admin_api_key: "fake-admin-key",
      base_url: "http://localhost",
      max_retries: 0
    )
    @queries = []
    stub_request(:get, %r{\Ahttp://localhost/organization/usage/}).to_return do |request|
      @queries << URI.decode_www_form(request.uri.query.to_s).group_by(&:first).transform_values { _1.map(&:last) }
      {
        status: 200,
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate({object: "page", data: [], has_more: false, next_page: nil})
      }
    end
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_omits_nil_filters_like_absent_filters
    @client.admin.organization.usage.decisions(start_time: 100)
    @client
      .admin
      .organization
      .usage
      .decisions(
        start_time: 100,
        api_key_ids: nil,
        batch: nil,
        bucket_width: nil,
        end_time: nil,
        group_by: nil,
        limit: nil,
        models: nil,
        page: nil,
        project_ids: nil,
        user_ids: nil
      )
    assert_equal([{"start_time" => ["100"]}, {"start_time" => ["100"]}], @queries)
  end

  def test_preserves_false_zero_lists_cursor_and_caller_hash
    params = {
      start_time: 0,
      batch: false,
      end_time: 0,
      limit: 0,
      page: "cursor",
      project_ids: ["a", "b"],
      models: [""],
      user_ids: nil
    }.freeze
    @client.admin.organization.usage.decisions(params)
    query = @queries.fetch(0)
    assert_equal(["false"], query["batch"])
    %w[start_time end_time limit].each { assert_equal(["0"], query[_1]) }
    assert_equal(["cursor"], query["page"])
    assert_equal(["a", "b"], query["project_ids[]"])
    assert_equal([""], query["models[]"])
    assert_nil(params[:user_ids])
    refute(query.key?("user_ids"))
  end

  def test_preserves_other_queries_and_json_body_nil
    @client.admin.organization.usage.completions(start_time: 100, batch: nil)
    assert_equal([""], @queries.fetch(0)["batch"])
    request = stub_request(:post, "http://localhost/other")
      .with(body: {value: nil}.to_json)
      .to_return(status: 200, headers: {"Content-Type" => "application/json"}, body: "{}")
    @client.request(method: :post, path: "other", body: {value: nil})
    assert_requested(request, times: 1)
  end
end
