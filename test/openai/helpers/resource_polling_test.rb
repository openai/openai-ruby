# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResourcePollingTest < Minitest::Test
  Result = Data.define(:status, :last_response)

  def test_polling_preserves_retrieve_overrides_and_result_identity
    polling_cases.each do |test_case|
      [false, true].each do |async|
        pending = Result.new(test_case.fetch(:pending), nil)
        terminal = Result.new(test_case.fetch(:terminal), nil)
        responses = [pending, terminal]
        requests = []
        resource = overridden_resource(test_case.fetch(:resource_class)) do |id, **params|
          requests << [id, params]
          responses.shift
        end

        options = {extra_headers: {"X-Test" => "yes"}, max_retries: 7}
        original_options = {extra_headers: options.fetch(:extra_headers).dup, max_retries: 7}
        sleeps = []
        Thread.current.thread_variable_set(:mock_sleep, sleeps)

        operation = -> do
          test_case.fetch(:call).call(
            resource,
            poll_interval: 0.02,
            timeout: nil,
            request_options: options
          )
        end

        result = async ? Sync { Async { operation.call }.wait } : operation.call

        assert_same(terminal, result)
        assert_equal([0.02], sleeps)
        assert_equal(2, requests.length)
        requests.each do |id, params|
          assert_equal(test_case.fetch(:id), id)
          assert_equal(test_case.fetch(:retrieve_params), params.except(:request_options))
          request_options = params.fetch(:request_options)
          assert_equal(7, request_options.fetch(:max_retries))
          assert_equal(
            {
              **test_case.fetch(:headers),
              "x-test" => "yes",
              "x-stainless-poll-helper" => "true",
              "x-stainless-custom-poll-interval" => "20"
            },
            request_options.fetch(:extra_headers)
          )
        end

        assert_equal(original_options, options)
      ensure
        Thread.current.thread_variable_set(:mock_sleep, nil)
      end
    end
  end

  def test_polling_preserves_shorter_request_timeout_error_identity
    polling_cases.each do |test_case|
      error = OpenAI::Errors::APITimeoutError.new(url: URI("http://example.test/v1/resource"))
      timeouts = []
      resource = overridden_resource(test_case.fetch(:resource_class)) do |_id, **params|
        timeouts << params.fetch(:request_options).fetch(:timeout)
        raise error
      end

      raised = assert_raises(OpenAI::Errors::APITimeoutError) do
        test_case.fetch(:call).call(resource, timeout: 10, request_options: {timeout: 0.01})
      end

      assert_same(error, raised)
      assert_equal([0.01], timeouts)
    end
  end

  def test_polling_preserves_unknown_status_error_messages
    polling_cases.each do |test_case|
      resource = overridden_resource(test_case.fetch(:resource_class)) do |_id, **_params|
        Result.new("mystery", nil)
      end

      error = assert_raises(OpenAI::Errors::PollingError) do
        test_case.fetch(:call).call(resource, timeout: nil)
      end

      assert_equal(
        "Unexpected status while waiting for #{test_case.fetch(:operation)}: \"mystery\"",
        error.message
      )
    end
  end

  def test_public_polling_method_parameters_are_unchanged
    optional_keywords = [[:key, :poll_interval], [:key, :timeout], [:key, :request_options]]

    assert_equal(
      [[:req, :file_id], *optional_keywords],
      OpenAI::Resources::Files.instance_method(:wait_for_processing).parameters
    )
    assert_equal(
      [[:req, :file_id], [:keyreq, :vector_store_id], *optional_keywords],
      OpenAI::Resources::VectorStores::Files.instance_method(:poll).parameters
    )
    assert_equal(
      [[:req, :batch_id], [:keyreq, :vector_store_id], *optional_keywords],
      OpenAI::Resources::VectorStores::FileBatches.instance_method(:poll).parameters
    )
  end

  private def overridden_resource(resource_class, &retrieve)
    Class
      .new(resource_class) do
        define_method(:retrieve, retrieve)
      end
      .new(client: OpenAI::Client.new(api_key: "test-api-key"))
  end

  private def polling_cases
    [
      {
        resource_class: OpenAI::Resources::Files,
        id: "file_123",
        retrieve_params: {},
        headers: {},
        pending: :uploaded,
        terminal: :processed,
        operation: "file file_123",
        call: -> (resource, **options) { resource.wait_for_processing("file_123", **options) }
      },
      {
        resource_class: OpenAI::Resources::VectorStores::Files,
        id: "file_123",
        retrieve_params: {vector_store_id: "vs_123"},
        headers: {"openai-beta" => "assistants=v2"},
        pending: :in_progress,
        terminal: :completed,
        operation: "vector store file file_123",
        call: -> (resource, **options) { resource.poll("file_123", vector_store_id: "vs_123", **options) }
      },
      {
        resource_class: OpenAI::Resources::VectorStores::FileBatches,
        id: "batch_123",
        retrieve_params: {vector_store_id: "vs_123"},
        headers: {"openai-beta" => "assistants=v2"},
        pending: :in_progress,
        terminal: :completed,
        operation: "vector store file batch batch_123",
        call: -> (resource, **options) { resource.poll("batch_123", vector_store_id: "vs_123", **options) }
      }
    ]
  end
end
