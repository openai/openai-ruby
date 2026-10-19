# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::UsageCacheWriteTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def setup
    super
    @client = OpenAI::Client.new(
      api_key: "fake-project-key",
      admin_api_key: "fake-admin-key",
      base_url: "http://localhost",
      max_retries: 0
    )
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_completions_cache_write
    check_metric("completions") { |start| @client.admin.organization.usage.completions(start_time: start) }
  end

  def test_decisions_cache_write
    check_metric("decisions") { |start| @client.admin.organization.usage.decisions(start_time: start) }
  end

  private

  def check_metric(endpoint)
    [73, 0, nil, :omitted].each_with_index do |value, start|
      result = {
        object: "organization.usage.#{endpoint}.result",
        input_tokens: 200,
        output_tokens: 20,
        num_model_requests: 1,
        input_cache_write_tokens: 17,
        input_cache_write_12h_tokens: 19
      }
      result[:input_cache_write_30m_tokens] = value unless value == :omitted
      request = stub_request(:get, "http://localhost/organization/usage/#{endpoint}")
        .with(query: {start_time: start.to_s})
        .to_return(
          headers: {"Content-Type" => "application/json"},
          body: JSON.generate(
            object: "page",
            data: [{object: "bucket", start_time: 0, end_time: 60, results: [result]}],
            has_more: false,
            next_page: nil
          )
        )
      row = yield(start).data.fetch(0).results.fetch(0)
      if value.nil? || value == :omitted
        assert_nil(row.input_cache_write_30m_tokens)
      else
        assert_equal(value, row.input_cache_write_30m_tokens)
      end

      assert_equal(17, row.input_cache_write_tokens)
      assert_equal(19, row.input_cache_write_12h_tokens)
      assert_requested(request, times: 1)
    end
  end
end
