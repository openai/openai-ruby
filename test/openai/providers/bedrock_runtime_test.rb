# frozen_string_literal: true

require_relative "bedrock_test_helper"

class OpenAI::Test::BedrockRuntimeProviderTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::BedrockTestHelper

  def test_runtime_derives_partition_aware_hosts_and_signing_services
    endpoints = {
      "us-east-1" => "amazonaws.com",
      "cn-north-1" => "amazonaws.com.cn",
      "eusc-de-east-1" => "amazonaws.eu",
      "us-iso-east-1" => "c2s.ic.gov",
      "us-isob-east-1" => "sc2s.sgov.gov",
      "eu-isoe-west-1" => "cloud.adc-e.uk",
      "us-isof-south-1" => "csp.hci.ic.gov"
    }

    endpoints.each do |region, suffix|
      base_url = "https://bedrock-runtime.#{region}.#{suffix}/openai/v1"
      bearer_client = OpenAI::Client.new(
        provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: region, api_key: "token")
      )
      assert_equal(base_url, bearer_client.base_url.to_s)

      runtime = OpenAI::Internal::Provider.configure(
        OpenAI::Providers.bedrock(
          endpoint: "runtime",
          region: region,
          access_key_id: "access-key",
          secret_access_key: "secret-key",
          session_token: "session-token"
        )
      )
      prepared = runtime.prepare_request.call(bedrock_request("#{base_url}/models"))

      assert_includes(prepared.dig(:headers, "authorization"), "/#{region}/bedrock/aws4_request")
      assert_equal("session-token", prepared.dig(:headers, "x-amz-security-token"))
    end
  end

  def test_runtime_infers_canonical_fips_dual_stack_and_partition_hosts
    hosts = {
      "bedrock-runtime.us-east-1.amazonaws.com" => "us-east-1",
      "bedrock-runtime.us-east-1.amazonaws.com." => "us-east-1",
      "bedrock-runtime.us-east-1.api.aws" => "us-east-1",
      "bedrock-runtime-fips.us-east-1.amazonaws.com" => "us-east-1",
      "bedrock-runtime-fips.us-east-1.api.aws" => "us-east-1",
      "bedrock-runtime.cn-north-1.api.amazonwebservices.com.cn" => "cn-north-1",
      "bedrock-runtime.eusc-de-east-1.api.amazonwebservices.eu" => "eusc-de-east-1",
      "bedrock-runtime.us-iso-east-1.api.aws.ic.gov" => "us-iso-east-1",
      "bedrock-runtime.us-isob-east-1.api.aws.scloud" => "us-isob-east-1",
      "bedrock-runtime.eu-isoe-west-1.api.cloud-aws.adc-e.uk" => "eu-isoe-west-1",
      "bedrock-runtime.us-isof-south-1.api.aws.hci.ic.gov" => "us-isof-south-1"
    }

    hosts.each do |host, region|
      base_url = "https://#{host}/openai/v1"
      client = OpenAI::Client.new(
        provider: OpenAI::Providers.bedrock(region: region, base_url: base_url, api_key: "token")
      )
      assert_equal(base_url, client.base_url.to_s)

      runtime = OpenAI::Internal::Provider.configure(
        OpenAI::Providers.bedrock(
          region: region,
          base_url: base_url,
          access_key_id: "access-key",
          secret_access_key: "secret-key"
        )
      )
      prepared = runtime.prepare_request.call(bedrock_request("#{base_url}/models"))

      assert_includes(prepared.dig(:headers, "authorization"), "/#{region}/bedrock/aws4_request")
    end

    ENV["AWS_BEDROCK_BASE_URL"] = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "token")
    )
    assert_equal(ENV.fetch("AWS_BEDROCK_BASE_URL"), client.base_url.to_s)
  end

  def test_bearer_custom_urls_ignore_malformed_ambient_regions
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "environment-token"
    ENV["AWS_BEDROCK_BASE_URL"] = "https://environment.example/openai/v1"
    custom_url = "https://proxy.example/openai/v1"

    %w[AWS_REGION AWS_DEFAULT_REGION].each do |variable|
      ENV[variable] = "local"

      runtime_bearer_authentication_options.each do |authentication|
        explicit_client = OpenAI::Client.new(
          provider: OpenAI::Providers.bedrock(base_url: custom_url, **authentication)
        )
        environment_client = OpenAI::Client.new(
          provider: OpenAI::Providers.bedrock(**authentication)
        )

        assert_equal(custom_url, explicit_client.base_url.to_s)
        assert_equal(ENV.fetch("AWS_BEDROCK_BASE_URL"), environment_client.base_url.to_s)
      end

      ENV.delete(variable)
    end

    error = assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(region: "local", base_url: custom_url, api_key: "token")
    end

    assert_match(/AWS `region` is invalid/, error.message)
  end

  def test_bearer_canonical_urls_ignore_conflicting_ambient_regions
    ENV["AWS_REGION"] = "us-west-2"
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "environment-token"
    canonical_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    ENV["AWS_BEDROCK_BASE_URL"] = canonical_url

    runtime_bearer_authentication_options.each do |authentication|
      explicit_client = OpenAI::Client.new(
        provider: OpenAI::Providers.bedrock(base_url: canonical_url, **authentication)
      )
      environment_client = OpenAI::Client.new(
        provider: OpenAI::Providers.bedrock(**authentication)
      )

      assert_equal(canonical_url, explicit_client.base_url.to_s)
      assert_equal(canonical_url, environment_client.base_url.to_s)
    end

    error = assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(region: "us-west-2", base_url: canonical_url, api_key: "token")
    end

    assert_match(/region `us-east-1` does not match/, error.message)
  end

  def test_runtime_rejects_insecure_mismatched_or_invalid_configuration
    authentication_options = [
      {api_key: "token"},
      {access_key_id: "access-key", secret_access_key: "secret-key"}
    ]
    invalid_endpoints = [
      ["http://bedrock-runtime.us-east-1.amazonaws.com/openai/v1", :runtime, "us-east-1", /HTTPS/],
      [
        "https://bedrock-runtime.us-west-2.amazonaws.com/openai/v1",
        :runtime,
        "us-east-1",
        /region `us-west-2` does not match/
      ],
      [
        "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1",
        :mantle,
        "us-east-1",
        /hostname does not match/
      ],
      [
        "https://bedrock-mantle.us-east-1.api.aws/v1",
        :runtime,
        "us-east-1",
        /hostname does not match/
      ]
    ]

    authentication_options.each do |authentication|
      invalid_endpoints.each do |base_url, endpoint, region, message|
        error = assert_raises(ArgumentError) do
          OpenAI::Providers.bedrock(
            endpoint: endpoint,
            region: region,
            base_url: base_url,
            **authentication
          )
        end

        assert_match(message, error.message)
      end
    end

    [:invalid, "runtime-fips", true].each do |endpoint|
      error = assert_raises(ArgumentError) do
        OpenAI::Providers.bedrock(endpoint: endpoint, region: "us-east-1", api_key: "token")
      end

      assert_match(/must be either `mantle` or `runtime`/, error.message)
    end

    ["US-EAST-1", "us-east-1.example", "../us-east-1"].each do |region|
      error = assert_raises(ArgumentError) do
        OpenAI::Providers.bedrock(endpoint: :runtime, region: region, api_key: "token")
      end

      assert_match(/AWS `region` is invalid/, error.message)
    end

    ENV["AWS_REGION"] = "us-east-1.example"
    error = assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(endpoint: :runtime, api_key: "token")
    end

    assert_match(/AWS `region` is invalid/, error.message)
  end

  def test_runtime_custom_signed_proxies_require_explicit_runtime_selection
    mantle = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        base_url: "http://localhost:8090/openai/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    prepared = mantle.prepare_request.call(bedrock_request("http://localhost:8090/openai/v1/models"))
    assert_includes(prepared.dig(:headers, "authorization"), "/us-east-1/bedrock-mantle/aws4_request")

    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        endpoint: :runtime,
        region: "us-east-1",
        base_url: "http://localhost:8090/openai/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    prepared = runtime.prepare_request.call(bedrock_request("http://localhost:8090/openai/v1/models"))
    assert_includes(prepared.dig(:headers, "authorization"), "/us-east-1/bedrock/aws4_request")

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(
        endpoint: :runtime,
        base_url: "http://localhost:8090/openai/v1",
        api_key: "token"
      )
    )
    assert_equal("http://localhost:8090/openai/v1", client.base_url.to_s)
  end

  def test_runtime_authenticates_chat_and_responses_with_bearer_and_sigv4
    runtime_authentication_options.each { assert_runtime_api_requests(_1) }
  end

  private def assert_runtime_api_requests(authentication)
    WebMock.reset!
    model = "us.openai.gpt-5.6-sol"
    base_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    chat_url = "#{base_url}/chat/completions"
    responses_url = "#{base_url}/responses"
    stub_request(:post, chat_url).to_return_json(
      status: 200,
      headers: {"x-request-id" => "runtime-chat-request"},
      body: {
        id: "chatcmpl_runtime",
        choices: [{finish_reason: "stop", index: 0, message: {content: "Hello", role: "assistant"}}],
        created: 1_700_000_000,
        model: model,
        object: "chat.completion",
        usage: {completion_tokens: 4, prompt_tokens: 3, total_tokens: 7}
      }
    )
    stub_request(:post, responses_url).to_return_json(
      status: 200,
      headers: {"x-request-id" => "runtime-response-request"},
      body: {
        id: "resp_runtime",
        object: "response",
        model: model,
        output: [
          {
            id: "msg_runtime",
            type: "message",
            role: "assistant",
            content: [{type: "output_text", text: "Hello", annotations: []}]
          }
        ],
        status: "completed"
      }
    )

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: "us-east-1", **authentication)
    )
    completion = client.chat.completions.create(model: model, messages: [{role: :user, content: "Hi"}])
    response = client.responses.create(model: model, input: "Hi")

    assert_equal("Hello", completion.choices.fetch(0).message.content)
    assert_equal(:stop, completion.choices.fetch(0).finish_reason)
    assert_equal(7, completion.usage.total_tokens)
    assert_equal("runtime-chat-request", completion._request_id)
    assert_equal("Hello", response.output_text)
    assert_equal("runtime-response-request", response._request_id)

    [chat_url, responses_url].each do |url|
      assert_requested(:post, url, times: 1) do |request|
        assert_runtime_authorization(request, authentication)
      end
    end
  end

  def test_runtime_streams_chat_and_responses_with_bearer_and_sigv4
    runtime_authentication_options.each { assert_runtime_streaming_requests(_1) }
  end

  private def assert_runtime_streaming_requests(authentication)
    WebMock.reset!
    base_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    chat_url = "#{base_url}/chat/completions"
    responses_url = "#{base_url}/responses"
    stream_bodies = {
      chat_url => runtime_chat_stream_body,
      responses_url => runtime_response_stream_body
    }
    stream_bodies.each do |url, body|
      stub_request(:post, url).to_return(
        status: 200,
        body: body,
        headers: {"content-type" => "text/event-stream", "x-request-id" => "runtime-stream-request"}
      )
    end

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: "us-east-1", **authentication)
    )
    chat_stream = client.chat.completions.stream(
      model: "us.openai.gpt-5.6-terra",
      messages: [{role: :user, content: "Hi"}]
    )
    response_stream = client.responses.stream(model: "us.openai.gpt-5.6-luna", input: "Hi")

    assert_instance_of(OpenAI::Streaming::ChatCompletionStream, chat_stream)
    assert_instance_of(OpenAI::Streaming::ResponseStream, response_stream)
    assert_equal("runtime-stream-request", chat_stream.last_response.request_id)
    assert_equal("runtime-stream-request", response_stream.last_response.request_id)

    chat_events = chat_stream.to_a
    chat_deltas = chat_events.grep(OpenAI::Streaming::ChatContentDeltaEvent)
    assert_equal(["Hello"], chat_deltas.map(&:delta))
    assert(chat_events.any? { _1.is_a?(OpenAI::Streaming::ChatContentDoneEvent) })

    response_events = response_stream.to_a
    response_deltas = response_events.grep(OpenAI::Streaming::ResponseTextDeltaEvent)
    assert_equal(["Hello"], response_deltas.map(&:delta))
    assert_equal(:"response.completed", response_events.last.type)
    assert_equal("Hello", response_stream.get_final_response.output_text)

    [chat_url, responses_url].each do |url|
      assert_requested(:post, url, times: 1) do |request|
        assert_equal(true, JSON.parse(request.body).fetch("stream"))
        assert_runtime_authorization(request, authentication)
      end
    end

    chat_stream.close
    response_stream.close
  end

  def test_runtime_refreshes_bearer_tokens_and_aws_credentials_on_retries
    [false, true].each { assert_runtime_retry_authentication(_1) }
  end

  private def assert_runtime_retry_authentication(use_aws_credentials)
    base_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1/models"
    WebMock.reset!
    calls = 0
    options = if use_aws_credentials
      {
        credentials_provider: lambda do
          calls += 1
          Aws::Credentials.new("runtime-access-#{calls}", "runtime-secret-#{calls}")
        end
      }
    else
      {
        token_provider: lambda do
          calls += 1
          "runtime-token-#{calls}"
        end
      }
    end

    authorizations = []
    stub_request(:get, base_url).to_return do |request|
      authorizations << request.headers.fetch("Authorization")
      {
        status: authorizations.length == 1 ? 429 : 200,
        body: "{}",
        headers: {"content-type" => "application/json"}
      }
    end

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: "us-east-1", **options),
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    client.request({method: :get, path: "models"})

    assert_equal(2, calls)
    if use_aws_credentials
      assert_includes(authorizations.fetch(0), "Credential=runtime-access-1/")
      assert_includes(authorizations.fetch(1), "Credential=runtime-access-2/")
      assert_includes(authorizations.fetch(1), "/bedrock/aws4_request")
    else
      assert_equal(["Bearer runtime-token-1", "Bearer runtime-token-2"], authorizations)
    end
  end

  def test_runtime_preserves_environment_token_precedence_and_default_aws_chain
    ENV["AWS_REGION"] = "us-east-1"
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "environment-token"
    ENV["AWS_ACCESS_KEY_ID"] = "environment-access-key"
    ENV["AWS_SECRET_ACCESS_KEY"] = "environment-secret-key"
    ENV["AWS_SESSION_TOKEN"] = "environment-session-token"
    request = bedrock_request("https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1/models")

    bearer_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(endpoint: :runtime)
    )
    bearer_request = bearer_runtime.prepare_request.call(request)
    assert_equal("Bearer environment-token", bearer_request.dig(:headers, "authorization"))

    aws_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(endpoint: :runtime, api_key: nil)
    )
    aws_request = aws_runtime.prepare_request.call(request)
    assert_includes(aws_request.dig(:headers, "authorization"), "Credential=environment-access-key/")
    assert_includes(aws_request.dig(:headers, "authorization"), "/bedrock/aws4_request")
    assert_equal("environment-session-token", aws_request.dig(:headers, "x-amz-security-token"))
  end

  def test_runtime_resolves_profile_region_without_changing_signing_service
    File.write(
      ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"),
      <<~INI
        [engineering]
        aws_access_key_id = profile-access-key
        aws_secret_access_key = profile-secret-key
      INI
    )
    File.write(
      ENV.fetch("AWS_CONFIG_FILE"),
      <<~INI
        [profile engineering]
        region = us-west-2
      INI
    )
    reset_shared_config
    base_url = "https://bedrock-runtime.us-west-2.amazonaws.com/openai/v1"

    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(endpoint: :runtime, profile: "engineering")
    )
    prepared = runtime.prepare_request.call(bedrock_request("#{base_url}/models"))

    assert_includes(prepared.dig(:headers, "authorization"), "Credential=profile-access-key/")
    assert_includes(prepared.dig(:headers, "authorization"), "/us-west-2/bedrock/aws4_request")
  end

  private def runtime_authentication_options
    [
      {api_key: "runtime-token"},
      {access_key_id: "runtime-access-key", secret_access_key: "runtime-secret-key"}
    ]
  end

  private def runtime_bearer_authentication_options
    [
      {api_key: "runtime-token"},
      {token_provider: -> { "runtime-token" }},
      {}
    ]
  end

  private def runtime_chat_stream_body
    base = {
      id: "chatcmpl_runtime_stream",
      object: "chat.completion.chunk",
      created: 1_700_000_000,
      model: "us.openai.gpt-5.6-terra"
    }
    chunks = [
      base.merge(choices: [{index: 0, delta: {role: "assistant", content: "Hello"}, finish_reason: nil}]),
      base.merge(choices: [{index: 0, delta: {}, finish_reason: "stop"}])
    ]

    "#{chunks.map { "data: #{JSON.generate(_1)}\n\n" }.join}data: [DONE]\n\n"
  end

  private def runtime_response_stream_body
    response = {
      id: "resp_runtime_stream",
      object: "response",
      model: "us.openai.gpt-5.6-luna",
      status: "in_progress",
      output: []
    }
    item = {id: "msg_runtime_stream", type: "message", status: "in_progress", role: "assistant", content: []}
    output = {type: "output_text", text: "Hello", annotations: []}
    indexes = {response_id: response.fetch(:id), item_id: item.fetch(:id), output_index: 0, content_index: 0}
    completed_item = item.merge(status: "completed", content: [output])
    completed_response = response.merge(status: "completed", output: [completed_item])
    events = [
      {type: "response.created", response: response},
      {type: "response.output_item.added", response_id: response.fetch(:id), output_index: 0, item: item},
      {type: "response.content_part.added", **indexes, part: output.merge(text: "")},
      {type: "response.output_text.delta", **indexes, delta: "Hello"},
      {type: "response.output_text.done", **indexes, text: "Hello"},
      {type: "response.content_part.done", **indexes, part: output},
      {
        type: "response.output_item.done",
        response_id: response.fetch(:id),
        output_index: 0,
        item: completed_item
      },
      {type: "response.completed", response: completed_response}
    ]

    events
      .each_with_index
      .map do |event, index|
        "event: #{event.fetch(:type)}\ndata: #{JSON.generate(event.merge(sequence_number: index + 1))}\n\n"
      end
      .join
  end

  private def assert_runtime_authorization(request, authentication)
    authorization = request.headers.fetch("Authorization")
    if authentication.key?(:api_key)
      assert_equal("Bearer runtime-token", authorization)
    else
      assert_includes(authorization, "Credential=runtime-access-key/")
      assert_includes(authorization, "/us-east-1/bedrock/aws4_request")
    end
  end
end
