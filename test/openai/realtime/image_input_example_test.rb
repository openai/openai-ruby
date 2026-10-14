# frozen_string_literal: true

require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/image_input"
require_relative "example_test_support"

class OpenAI::Test::RealtimeImageInputExampleTest < Minitest::Test
  include OpenAI::Test::RealtimeExampleTestSupport

  def test_passes_an_application_validated_png_data_uri_through_and_returns_completed_text
    image_url = "data:image/png;base64,application-owned-payload"
    prompt = "private image question"
    client, connection, realtime = recording_client(
      [response_done(id: "response_image", text: "Application-owned image.")]
    )
    diagnostics = StringIO.new

    text = OpenAI::Examples::Realtime::ImageInput.run(
      client: client,
      model: "gpt-realtime-2.1",
      image_url: image_url,
      prompt: prompt,
      output: diagnostics
    )

    assert_equal("Application-owned image.", text)
    assert_equal(["gpt-realtime-2.1"], realtime.models)
    assert_equal([:text], connection.session.calls.fetch(0).fetch(:output_modalities))
    content = connection.conversation.items.calls.fetch(0).fetch(:content)
    assert_equal(image_url, content.fetch(0).fetch(:image_url))
    assert_equal(prompt, content.fetch(1).fetch(:text))
    assert_equal([{}], connection.response.calls)
    assert_includes(diagnostics.string, "response.done status=completed")
    refute_includes(diagnostics.string, image_url)
    refute_includes(diagnostics.string, prompt)
    refute_includes(diagnostics.string, text)
  end

  def test_accepts_an_application_validated_jpeg_data_uri
    image_url = "data:image/jpeg;base64,application-owned-payload"
    client, connection, = recording_client(
      [response_done(id: "response_image", text: "Application-owned image.")]
    )

    OpenAI::Examples::Realtime::ImageInput.run(
      client: client,
      model: "gpt-realtime-2.1",
      image_url: image_url,
      prompt: "private image question",
      output: StringIO.new
    )

    assert_equal(image_url, connection.conversation.items.calls.fetch(0).dig(:content, 0, :image_url))
  end

  def test_requires_a_caller_validated_png_or_jpeg_data_uri_before_connecting
    invalid_image_urls = [
      nil,
      "",
      " \n",
      "https://images.example.test/application-validated.png",
      "data:image/gif;base64,application-owned-payload",
      "data:image/png;base64,"
    ]

    invalid_image_urls.each do |image_url|
      client, _connection, realtime = recording_client([])

      error = assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::ImageInput.run(
          client: client,
          model: "gpt-realtime-2.1",
          image_url: image_url,
          prompt: "private prompt",
          output: StringIO.new
        )
      end

      assert_equal(
        "Realtime image input must be a caller-validated PNG or JPEG base64 data URI",
        error.message
      )
      assert_empty(realtime.models)
    end
  end

  def test_requires_a_completed_response_with_text
    failure_client, = recording_client([response_done(status: :failed)])
    failure = assert_raises(RuntimeError) { run_example(failure_client) }
    assert_equal("Realtime response did not complete.", failure.message)

    empty_client, = recording_client([response_done])
    empty = assert_raises(RuntimeError) { run_example(empty_client) }
    assert_equal("Realtime image response completed without text output.", empty.message)

    eof_client, = recording_client([])
    eof = assert_raises(RuntimeError) { run_example(eof_client) }
    assert_equal("Realtime connection closed before response.done.", eof.message)
  end

  def test_redacts_api_error_details
    client, = recording_client([api_error("private image details")])

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime API error.", error.message)
    refute_includes(error.message, "private image details")
  end

  private def run_example(client)
    OpenAI::Examples::Realtime::ImageInput.run(
      client: client,
      model: "gpt-realtime-2.1",
      image_url: "data:image/png;base64,application-owned-payload",
      prompt: "private prompt",
      output: StringIO.new
    )
  end
end
