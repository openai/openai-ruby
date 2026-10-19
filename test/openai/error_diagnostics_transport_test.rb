# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ErrorDiagnosticsTransportTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  [:responses, :beta, :videos].each do |route|
    [:values, :nulls, :omitted].each do |shape|
      define_method("test_#{route}_#{shape}") do
        error = {code: "server_error", message: "Synthetic failure"}
        unless shape == :omitted
          error[:type] = shape == :values ? "synthetic_error" : nil
          error[:param] = shape == :values ? "input[0]" : nil
        end

        video = route == :videos
        identifier = video ? "video_synthetic" : "resp_synthetic"
        url = "http://localhost/#{video ? "videos" : "responses"}/#{identifier}#{route == :beta ? "?beta=true" : ""}"
        stub_request(:get, url).to_return_json(body: {id: identifier, error: error})
        client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic-key", max_retries: 0)
        result = case route
        when :responses
          client.responses.retrieve(identifier)
        when :beta
          client.beta.responses.retrieve(identifier)
        when :videos
          client.videos.retrieve(identifier)
        end

        assert_requested(:get, url, times: 1)
        if shape == :values
          assert_equal("synthetic_error", result.error.type)
          assert_equal("input[0]", result.error.param)
        else
          assert_nil(result.error.type)
          assert_nil(result.error.param)
        end

        assert_equal(shape != :omitted, result.error.to_hash.key?(:type))
        assert_equal(shape != :omitted, result.error.to_hash.key?(:param))
        assert_equal("server_error", result.error.code.to_s)
        assert_equal("Synthetic failure", result.error.message)
      end
    end
  end
end
