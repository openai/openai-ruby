# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::VideoErrorTest < Minitest::Test
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

  def teardown
    WebMock.reset!
    super
  end

  def test_failed_video_preserves_retry_headers
    headers = {"Retry-After" => "2", "Retry-After-Ms" => "2000"}
    payload = {
      id: "video_test",
      completed_at: nil,
      created_at: 123,
      error: {code: "rate_limit_exceeded", message: "Try again later", headers: headers},
      expires_at: nil,
      model: "sora-2",
      object: "video",
      progress: 0,
      prompt: "A test video",
      remixed_from_video_id: nil,
      seconds: "4",
      size: "720x1280",
      status: "failed"
    }
    url = "http://localhost/videos/video_test"
    stub_request(:get, url).to_return_json(body: payload)
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "fake-project-key", max_retries: 0)

    response = client.videos.retrieve("video_test")

    assert_requested(:get, url, times: 1)
    assert_instance_of(OpenAI::Video, response)
    assert_instance_of(OpenAI::VideoCreateError, response.error)
    assert_equal(headers.transform_keys(&:to_sym), response.error.headers)
    assert_equal(JSON.parse(payload.to_json), JSON.parse(response.to_json))
  end
end
