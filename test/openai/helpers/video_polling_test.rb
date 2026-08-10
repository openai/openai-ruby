# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::VideoPollingTest < Minitest::Test
  class FakeClient
    attr_reader :requests

    def initialize(*responses)
      @requests = []
      @responses = responses
    end

    def request(request)
      @requests << request
      @responses.shift
    end
  end

  def setup
    super
    Thread.current.thread_variable_set(:mock_sleep, [])
  end

  def teardown
    Thread.current.thread_variable_set(:mock_sleep, nil)
    super
  end

  def test_poll_waits_until_the_video_reaches_a_terminal_state
    client = FakeClient.new(video(status: :queued), video(status: :in_progress), video(status: :completed))
    videos = OpenAI::Resources::Videos.new(client: client)

    result = videos.poll("video_123", poll_interval: 0.25)

    assert_equal(:completed, result.status)
    assert_equal([0.25, 0.25], Thread.current.thread_variable_get(:mock_sleep))
    assert_equal(3, client.requests.length)
  end

  def test_poll_returns_a_failed_video_without_raising
    client = FakeClient.new(video(status: :failed))
    videos = OpenAI::Resources::Videos.new(client: client)

    result = videos.poll("video_123")

    assert_equal(:failed, result.status)
    assert_empty(Thread.current.thread_variable_get(:mock_sleep))
  end

  def test_poll_uses_default_interval_without_marking_it_custom
    client = FakeClient.new(video(status: :queued), video(status: :completed))
    videos = OpenAI::Resources::Videos.new(client: client)

    videos.poll("video_123")

    assert_equal([1.0], Thread.current.thread_variable_get(:mock_sleep))
    assert_equal(
      {"x-stainless-poll-helper" => "true"},
      client.requests.fetch(0).fetch(:options).fetch(:extra_headers)
    )
  end

  def test_poll_preserves_request_options_and_adds_polling_headers
    client = FakeClient.new(video(status: :completed))
    videos = OpenAI::Resources::Videos.new(client: client)

    videos.poll(
      "video_123",
      poll_interval: 0.25,
      request_options: {timeout: 30, extra_headers: {"x-request-id" => "request_123"}}
    )

    assert_equal(
      {
        timeout: 30,
        extra_headers: {
          "x-request-id" => "request_123",
          "x-stainless-poll-helper" => "true",
          "x-stainless-custom-poll-interval" => "250"
        }
      },
      client.requests.fetch(0).fetch(:options)
    )
  end

  def test_create_and_poll_creates_then_waits_for_the_video
    client = FakeClient.new(video(status: :queued), video(status: :completed))
    videos = OpenAI::Resources::Videos.new(client: client)

    result = videos.create_and_poll(
      prompt: "Animate the radar sweep.",
      model: :"sora-2",
      poll_interval: 0.25,
      request_options: {timeout: 30}
    )

    assert_equal(:completed, result.status)
    assert_equal([:post, :get], client.requests.map { _1.fetch(:method) })
    refute(client.requests.fetch(0).fetch(:body).key?(:poll_interval))
    assert_equal({timeout: 30}, client.requests.fetch(0).fetch(:options))
    assert_equal(30, client.requests.fetch(1).fetch(:options).fetch(:timeout))
  end

  def test_create_and_poll_does_not_mutate_params
    client = FakeClient.new(video(status: :queued), video(status: :completed))
    videos = OpenAI::Resources::Videos.new(client: client)
    params = {prompt: "Animate the radar sweep.", poll_interval: 0.25}

    videos.create_and_poll(params)

    assert_equal({prompt: "Animate the radar sweep.", poll_interval: 0.25}, params)
  end

  def test_create_and_poll_rejects_invalid_intervals_before_creating_a_video
    client = FakeClient.new(video(status: :queued))
    videos = OpenAI::Resources::Videos.new(client: client)

    assert_raises(ArgumentError) do
      videos.create_and_poll(prompt: "Animate the radar sweep.", poll_interval: -1)
    end
    assert_empty(client.requests)
  end

  def test_poll_rejects_invalid_intervals_before_making_a_request
    [-1, Float::INFINITY, Float::NAN].each do |poll_interval|
      client = FakeClient.new(video(status: :completed))
      videos = OpenAI::Resources::Videos.new(client: client)

      assert_raises(ArgumentError) do
        videos.poll("video_123", poll_interval: poll_interval)
      end
      assert_empty(client.requests)
    end
  end

  private

  def video(status:)
    OpenAI::Video.new(
      id: "video_123",
      completed_at: status == :completed ? 1 : nil,
      created_at: 0,
      error: nil,
      expires_at: nil,
      model: :"sora-2",
      progress: status == :completed ? 100 : 0,
      prompt: "Animate the radar sweep.",
      remixed_from_video_id: nil,
      seconds: :"4",
      size: :"720x1280",
      status: status
    )
  end
end
