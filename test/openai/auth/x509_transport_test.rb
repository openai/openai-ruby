# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/mtls_wire_harness"
require "open3"
require "rbconfig"

class OpenAI::Test::X509TransportTest < Minitest::Test
  extend Minitest::Serial

  Harness = OpenAI::Test::MTLSWireHarness
  WIRE_SUBPROCESS = "OPENAI_RUBY_X509_TRANSPORT_WIRE_SUBPROCESS"
  WIRE_SUBPROCESS_TIMEOUT = 15
  WIRE_SUBPROCESS_TERM_GRACE = 1

  def setup
    super
    @http_client = OpenAI::NetHTTPClient.new
  end

  def teardown
    @http_client.close
    super
  end

  def test_requires_a_concrete_native_client_and_an_explicit_static_identity
    assert_raises(ArgumentError) do
      OpenAI::Auth::X509Transport.new(http_client: Object.new, certificate_identity: :static)
    end

    assert_raises(ArgumentError) do
      OpenAI::Auth::X509Transport.new(http_client: @http_client, certificate_identity: :dynamic)
    end

    assert_raises(ArgumentError) do
      OpenAI::Auth::X509Transport.new(
        http_client: @http_client,
        certificate_identity: :static,
        proxy: :https_connect
      )
    end

    capability = capability_for(@http_client)
    assert_predicate(capability, :frozen?)
    assert_equal("https://mtls.api.openai.com", capability.api_origin)
    assert_equal(:direct, capability.proxy_mode)
  end

  def test_rejects_unapproved_api_origins_before_dispatch
    origins = [
      "http://mtls.api.openai.com",
      "https://api.openai.com",
      "https://tenant.openai.azure.com",
      "https://mtls.api.openai.com:8443",
      "https://user@mtls.api.openai.com",
      "https://mtls.api.openai.com/v1",
      "https://mtls.api.openai.com."
    ]

    origins.each do |origin|
      error = assert_raises(ArgumentError) do
        capability_for(@http_client, api_origin: origin)
      end

      assert_match(/approved OpenAI mTLS API origin/, error.message)
    end
  end

  def test_accepts_approved_regional_origins
    %w[mtls.api.openai.com mtls-us.api.openai.com mtls-eu.api.openai.com].each do |hostname|
      capability = capability_for(@http_client, api_origin: "https://#{hostname}:443")
      assert_equal("https://#{hostname}", capability.api_origin)
    end
  end

  def test_rejects_wrong_issuer_path_method_or_api_authority
    capability = capability_for(@http_client)
    invalid_requests = [
      request(:get, "https://mtls.auth.openai.com/oauth/token"),
      request(:post, "https://mtls.auth.openai.com/oauth/token/"),
      request(:post, "https://mtls.auth.openai.com/oauth/token?audience=other"),
      request(:get, "https://mtls-eu.api.openai.com/v1/models"),
      request(:get, "http://mtls.api.openai.com/v1/models"),
      request(:get, "https://user@mtls.api.openai.com/v1/models"),
      request(:get, "https://mtls.api.openai.com:8443/v1/models")
    ]

    @http_client.stub(:execute, -> (_value) { flunk("request must be rejected before dispatch") }) do
      invalid_requests.each do |invalid_request|
        assert_raises(ArgumentError) { capability.execute(invalid_request) }
      end
    end
  end

  def test_rejects_target_credentials_authority_confusion_and_duplicate_aliases
    capability = capability_for(@http_client)
    invalid_headers = [
      {"authorization" => "Basic fake"},
      {"authorization" => "Bearer fake-token", "x-api-key" => "fake-key"},
      {"authorization" => "Bearer fake-token", "X_API_KEY" => "fake-key"},
      {"authorization" => "Bearer fake-token", "Proxy_Authorization" => "Basic fake"},
      {"authorization" => "Bearer fake-token", "host" => "attacker.invalid"},
      {"authorization" => "Bearer fake-token", "Host" => "mtls.api.openai.com:8443"},
      {"authorization" => "Bearer fake-token", "AUTHORIZATION" => "Bearer other"},
      {"x: safe\r\nauthorization" => "Bearer injected"},
      {"bad\u0000name" => "fake-value"},
      {"bad\tname" => "fake-value"},
      {"bad:name" => "fake-value"},
      {"bad name" => "fake-value"},
      {"\u212Aey" => "fake-value"},
      {"" => "fake-value"}
    ]

    @http_client.stub(:execute, -> (_value) { flunk("request must be rejected before dispatch") }) do
      invalid_headers.each do |headers|
        assert_raises(ArgumentError) do
          capability.execute(request(:get, "https://mtls.api.openai.com/v1/models", headers: headers))
        end
      end
    end
  end

  def test_exchange_rejects_inherited_authorization_cookies_and_tenant_headers
    capability = capability_for(@http_client)
    rejected = [
      "authorization",
      "cookie",
      "openai-organization",
      "openai-project",
      "proxy_authorization",
      "x: safe\r\nauthorization",
      "x: safe\r\nhost",
      "x: safe\r\ncontent-length"
    ]

    @http_client.stub(:execute, -> (_value) { flunk("exchange must be rejected before dispatch") }) do
      rejected.each do |name|
        assert_raises(ArgumentError) do
          capability.execute(
            request(:post, "https://mtls.auth.openai.com/oauth/token", headers: {name => "fake-value"})
          )
        end
      end
    end
  end

  def test_preserves_underscores_in_safe_custom_header_names
    capability = capability_for(@http_client)
    observed = nil
    response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")

    @http_client.stub(
      :execute,
      -> (request) {
        observed = request
        response
      }
    ) do
      capability.execute(
        request(
          :get,
          "https://mtls.api.openai.com/v1/models",
          headers: {
            "authorization" => "Bearer fake-token",
            "x_trace_id" => "fake-trace",
            "x-trace-id" => "fake-dashed-trace"
          }
        )
      )
    end

    assert_equal("fake-trace", observed.headers.fetch("x_trace_id"))
    assert_equal("fake-dashed-trace", observed.headers.fetch("x-trace-id"))
  end

  def test_api_request_validation_returns_deeply_frozen_plain_string_headers
    capability = capability_for(@http_client)
    mutable_string = Class.new(String) do
      def to_s = self
    end

    original = mutable_string.new("Bearer fake-token")

    headers = capability.validate_api_request!(
      url: URI("https://mtls.api.openai.com/v1/models"),
      headers: {"authorization" => original, "x_trace_id" => mutable_string.new("fake-trace")}
    )

    assert_predicate(headers, :frozen?)
    headers.each do |name, value|
      assert_instance_of(String, name)
      assert_instance_of(String, value)
      assert_predicate(name, :frozen?)
      assert_predicate(value, :frozen?)
    end

    original.replace("Bearer fake-replacement")
    assert_equal("Bearer fake-token", headers.fetch("authorization"))
    assert_equal("fake-trace", headers.fetch("x_trace_id"))
  end

  def test_rejects_redirect_without_retaining_signed_location
    response = OpenAI::HTTPClient::Response.new(
      status: 307,
      headers: {"location" => "https://attacker.invalid/?signature=fake-secret"},
      body: ""
    )
    capability = capability_for(@http_client)

    error = @http_client.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::APIError) do
        capability.execute(
          request(
            :get,
            "https://mtls.api.openai.com/v1/models?signature=fake-request-secret&cursor=fake-cursor#fake-fragment",
            headers: {"authorization" => "Bearer fake-token"}
          )
        )
      end
    end

    assert_equal(307, error.status)
    refute_match(/fake-secret|attacker/, error.inspect)
    assert_equal("https://mtls.api.openai.com/v1/models", error.url.to_s)
    assert_nil(error.headers)
    assert_nil(error.body)
  end

  def test_transport_errors_redact_signed_query_data_and_sensitive_causes
    capability = capability_for(@http_client)
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    classes.each do |error_class|
      destination = URI("https://mtls.api.openai.com/v1/models?signature=fake-query-secret#fake-fragment")
      original = error_class.new(url: destination, message: "fake-error-secret")
      sensitive_cause = IOError.new("fake-cause-secret")
      dispatch = -> (_request) { raise original, cause: sensitive_cause }

      error = @http_client.stub(:execute, dispatch) do
        assert_raises(error_class) do
          capability.execute(request(:get, destination, headers: {"authorization" => "Bearer fake-token"}))
        end
      end

      assert_equal("https://mtls.api.openai.com/v1/models", error.url.to_s)
      assert_nil(error.cause)
      assert_nil(error.headers)
      assert_nil(error.body)
      refute_match(/fake-query-secret|fake-fragment|fake-error-secret|fake-cause-secret/, error.inspect)
    end
  end

  def test_transport_errors_never_retain_bearer_requests_without_signed_queries
    capability = capability_for(@http_client)
    destination = URI("https://mtls.api.openai.com/v1/models")
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    classes.each do |error_class|
      retained = Net::HTTP::Get.new(destination)
      retained["authorization"] = "Bearer fake-retained-secret"
      original = error_class.new(url: destination, request: retained, message: "fake-secret-diagnostics")
      dispatch = -> (_request) { raise original, cause: IOError.new("fake-cause-secret") }

      error = @http_client.stub(:execute, dispatch) do
        assert_raises(error_class) do
          capability.execute(
            request(:get, destination, headers: {"authorization" => "Bearer fake-retained-secret"})
          )
        end
      end

      assert_equal(destination.to_s, error.url.to_s)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_match(/fake-retained-secret|fake-secret-diagnostics|fake-cause-secret/, error.inspect)
    end
  end

  def test_transport_errors_never_retain_credential_free_request_bodies
    capability = capability_for(@http_client)
    destination = URI("https://mtls.auth.openai.com/oauth/token")
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    classes.product([false, true]).each do |error_class, deferred|
      retained = Net::HTTP::Post.new(destination)
      retained.body_stream = StringIO.new("fake-private-body")
      original = error_class.new(url: destination, request: retained, message: "fake-secret-diagnostics")
      failure = -> { raise original, cause: IOError.new("fake-cause-secret") }
      dispatch = if deferred
        -> (_request) {
          OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: Enumerator.new { failure.call })
        }
      else
        -> (_request) { failure.call }
      end

      error = @http_client.stub(:execute, dispatch) do
        assert_raises(error_class) do
          response = capability.execute(request(:post, destination, body: "fake-private-body"))
          response.body.to_a
        end
      end

      assert_equal(destination.to_s, error.url.to_s)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_match(/fake-private-body|fake-secret-diagnostics|fake-cause-secret/, error.inspect)
    end
  end

  def test_deferred_transport_errors_never_retain_signed_urls_or_bearer_requests
    capability = capability_for(@http_client)
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]
    destinations = [
      URI("https://mtls.api.openai.com/v1/models?signature=fake-query-secret#fake-fragment"),
      URI("https://mtls.api.openai.com/v1/models")
    ]

    classes.product(destinations).each do |error_class, destination|
      retained = Net::HTTP::Get.new(destination)
      retained["authorization"] = "Bearer fake-retained-secret"
      original = error_class.new(url: destination, request: retained, message: "fake-error-secret")
      events = []
      body = Enumerator.new do |chunks|
        events << :started
        chunks << "fake-safe-prefix"
        raise original, cause: IOError.new("fake-cause-secret")
      ensure
        events << :closed
      end

      native_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: body)

      response = @http_client.stub(:execute, -> (_request) { native_response }) do
        capability.execute(
          request(:get, destination, headers: {"authorization" => "Bearer fake-retained-secret"})
        )
      end

      assert_empty(events)
      observed_chunks = []
      error = assert_raises(error_class) { response.body.each { |chunk| observed_chunks << chunk } }

      assert_equal(["fake-safe-prefix"], observed_chunks)
      assert_equal([:started, :closed], events)
      assert_equal("https://mtls.api.openai.com/v1/models", error.url.to_s)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_match(
        /fake-query-secret|fake-fragment|fake-retained-secret|fake-error-secret|fake-cause-secret/,
        error.inspect
      )
    end
  end

  def test_deferred_credential_free_transport_errors_do_not_retain_causes
    capability = capability_for(@http_client)
    destination = URI("https://mtls.api.openai.com/v1/models")
    original = OpenAI::Errors::APIConnectionError.new(url: destination)
    safe_cause = IOError.new("safe connection failure")
    body = Enumerator.new { raise original, cause: safe_cause }
    native_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: body)

    response = @http_client.stub(:execute, -> (_request) { native_response }) do
      capability.execute(request(:get, destination))
    end

    error = assert_raises(OpenAI::Errors::APIConnectionError) { response.body.to_a }
    refute_same(original, error)
    assert_nil(error.cause)
  end

  def test_closing_wrapped_response_closes_the_original_stream
    capability = capability_for(@http_client)
    events = []
    source = Enumerator.new do |chunks|
      events << :started
      chunks << "fake-first-chunk"
      chunks << "fake-second-chunk"
    end

    body = OpenAI::Internal::Util.fused_enum(source) { events << :closed }
    native_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: body)

    response = @http_client.stub(:execute, -> (_request) { native_response }) do
      capability.execute(request(:get, "https://mtls.api.openai.com/v1/models"))
    end

    assert_empty(events)
    assert_equal("fake-first-chunk", response.body.next)
    assert_equal([:started], events)

    OpenAI::Internal::Util.close_fused!(response.body)

    assert_equal([:started, :closed], events)
  end

  def test_rejects_unredacted_net_http_debug_output_before_network_access
    debug_output = StringIO.new
    configured_client = OpenAI::NetHTTPClient.new { |connection| connection.set_debug_output(debug_output) }
    capability = capability_for(configured_client)

    Socket.stub(:tcp, -> (*_args, **_kwargs) { flunk("debug output must fail before network access") }) do
      error = assert_raises(ArgumentError) do
        capability.execute(
          request(:get, "https://mtls.api.openai.com/v1/models", headers: {"authorization" => "Bearer fake-token"})
        )
      end

      assert_match(/debug output/, error.message)
    end

    assert_empty(debug_output.string)
  ensure
    configured_client&.close
  end

  def test_connection_errors_before_url_or_header_validation_are_not_masked
    capability = capability_for(@http_client)
    destination = URI("https://mtls.api.openai.com/v1/models")
    url_failure = OpenAI::Errors::APIConnectionError.new(url: destination)
    header_failure = OpenAI::Errors::APIConnectionError.new(url: destination)
    raising_string = lambda do |failure|
      subclass = Class.new(String) do
        define_method(:to_s) { raise failure }
      end

      subclass.new(destination.to_s)
    end

    cases = [
      [raising_string.call(url_failure), {}, url_failure],
      [destination, {"authorization" => raising_string.call(header_failure)}, header_failure]
    ]

    @http_client.stub(:execute, -> (_value) { flunk("invalid request must fail before dispatch") }) do
      cases.each do |url, headers, expected|
        invalid_request = OpenAI::HTTPClient::Request.new(
          method: :get,
          url: url,
          headers: headers,
          body: nil,
          timeout: 2.0
        )

        error = assert_raises(OpenAI::Errors::APIConnectionError) { capability.execute(invalid_request) }
        assert_same(expected, error)
      end
    end
  end

  def test_transport_errors_do_not_retain_causes_when_no_query_is_present
    capability = capability_for(@http_client)
    destination = URI("https://mtls.api.openai.com/v1/models")
    original = OpenAI::Errors::APIConnectionError.new(url: destination)
    safe_cause = IOError.new("safe connection failure")
    dispatch = -> (_request) { raise original, cause: safe_cause }

    error = @http_client.stub(:execute, dispatch) do
      assert_raises(OpenAI::Errors::APIConnectionError) do
        capability.execute(request(:get, destination))
      end
    end

    refute_same(original, error)
    assert_nil(error.cause)
  end

  def test_real_wire_issuer_and_api_share_attested_client_identity
    return unless run_wire_subprocess

    hostnames = %w[mtls.auth.openai.com mtls.api.openai.com]
    pki = Harness::PKI.new(hostnames: hostnames)
    issuer = Harness::MTLSServer.new(
      hostname: hostnames.fetch(0),
      pki: pki,
      body: {access_token: "fake-workload-token"}
    )
    api = Harness::MTLSServer.new(hostname: hostnames.fetch(1), pki: pki)
    proxy = Harness::ConnectProxy.new(
      authority_ports: {
        "#{issuer.hostname}:443" => issuer.local_port,
        "#{api.hostname}:443" => api.local_port
      },
      expected_connections: 2
    )
    identity = pki.client_identity
    verification_results = []
    configured_client = OpenAI::NetHTTPClient.new(size: 1) do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.cert_store = pki.trust_store
      connection.cert = identity.certificate
      connection.extra_chain_cert = [pki.intermediate_certificate]
      connection.key = identity.key
      connection.verify_callback = -> (verified, _context) {
        verification_results << verified
        verified
      }
    end

    capability = capability_for(configured_client, proxy: :http_connect)

    Harness.with_proxy_environment(proxy.uri) do
      issuer_response = capability.execute(
        request(
          :post,
          "https://mtls.auth.openai.com/oauth/token",
          headers: {"content-type" => "application/json"},
          body: "{}"
        )
      )
      assert_equal("fake-workload-token", JSON.parse(issuer_response.body.to_a.join).fetch("access_token"))

      api_response = capability.execute(
        request(
          :get,
          "https://mtls.api.openai.com/v1/models",
          headers: {"authorization" => "Bearer fake-workload-token"}
        )
      )
      assert_equal(true, JSON.parse(api_response.body.to_a.join).fetch("ok"))
    end

    configured_client.close
    issuer_record = issuer.finish.fetch(0)
    api_record = api.finish.fetch(0)
    proxy_records = proxy.finish

    refute_empty(verification_results)
    assert(verification_results.all?)
    assert_equal(identity.certificate.to_der, issuer_record.peer_certificate.to_der)
    assert_equal(identity.certificate.to_der, api_record.peer_certificate.to_der)
    refute_includes(issuer_record.headers, "authorization")
    assert_equal("Bearer fake-workload-token", api_record.headers.fetch("authorization"))
    proxy_records.each do |record|
      assert_equal("Basic cHJveHktdXNlcjpwcm94eS1wYXNz", record.headers.fetch("proxy-authorization"))
      refute_includes(record.headers, "authorization")
    end

  rescue OpenAI::Errors::APIConnectionError => error
    cause = error.cause
    raise "Ephemeral mTLS fixture connection failed: #{cause&.class}: #{cause&.message}"
  ensure
    configured_client&.close
    proxy&.close
    issuer&.close
    api&.close
  end

  def test_real_wire_permissive_callback_cannot_override_untrusted_server_certificate
    return unless run_wire_subprocess

    hostname = "mtls.api.openai.com"
    pki = Harness::PKI.new(hostnames: [hostname])
    server = Harness::MTLSServer.new(hostname: hostname, pki: pki)
    proxy = Harness::ConnectProxy.new(
      authority_ports: {"#{hostname}:443" => server.local_port},
      expected_connections: 1
    )
    identity = pki.client_identity
    verification_results = []
    configured_client = OpenAI::NetHTTPClient.new do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.cert_store = OpenSSL::X509::Store.new
      connection.cert = identity.certificate
      connection.extra_chain_cert = [pki.intermediate_certificate]
      connection.key = identity.key
      connection.verify_callback = -> (verified, _context) {
        verification_results << verified
        true
      }
    end

    capability = capability_for(configured_client, proxy: :http_connect)
    assert_raises(OpenAI::Errors::APIConnectionError) do
      capability.execute(
        request(
          :get,
          "https://mtls.api.openai.com/v1/models",
          headers: {"authorization" => "Bearer fake-secret-token"}
        )
      )
    end

    configured_client.close
    record = server.finish.fetch(0)
    assert_includes(verification_results, false)
    assert_nil(record.request_line)
    assert_instance_of(OpenSSL::SSL::SSLError, record.handshake_error)
    assert_equal(1, proxy.finish.length)
  ensure
    configured_client&.close
    proxy&.close
    server&.close
  end

  def test_real_wire_transport_rejects_an_existing_unguarded_tls_connection
    return unless run_wire_subprocess

    hostname = "mtls.api.openai.com"
    pki = Harness::PKI.new(hostnames: [hostname])
    server, server_thread, records = start_keepalive_server(pki, hostname)
    proxy = Harness::ConnectProxy.new(
      authority_ports: {"#{hostname}:443" => server.local_address.ip_port},
      expected_connections: 1
    )
    identity = pki.client_identity
    configured_client = OpenAI::NetHTTPClient.new(size: 1) do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.cert_store = OpenSSL::X509::Store.new
      connection.cert = identity.certificate
      connection.extra_chain_cert = [pki.intermediate_certificate]
      connection.key = identity.key
      connection.verify_callback = -> (_verified, _context) { true }
    end

    destination = "https://mtls.api.openai.com/v1/models"
    first = configured_client.execute(request(:get, destination))
    first.body.to_a

    capability = capability_for(configured_client, proxy: :http_connect)
    error = assert_raises(ArgumentError) do
      capability.execute(request(:get, destination, headers: {"authorization" => "Bearer fake-secret-token"}))
    end

    assert_match(/unguarded TLS verification callback/, error.message)
    configured_client.close
    Timeout.timeout(2) { server_thread.join }
    assert_equal(1, records.length)
    refute_includes(records.first, "authorization")
    assert_equal(1, proxy.finish.length)
  ensure
    configured_client&.close
    proxy&.close
    server&.close
    server_thread&.kill&.join if server_thread&.alive?
  end

  def test_real_wire_transport_reuses_its_own_guarded_tls_connection
    return unless run_wire_subprocess

    hostname = "mtls.api.openai.com"
    pki = Harness::PKI.new(hostnames: [hostname])
    server, server_thread, records = start_keepalive_server(pki, hostname)
    proxy = Harness::ConnectProxy.new(
      authority_ports: {"#{hostname}:443" => server.local_address.ip_port},
      expected_connections: 1
    )
    identity = pki.client_identity
    callback_results = []
    configured_client = OpenAI::NetHTTPClient.new(size: 1) do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.cert_store = pki.trust_store
      connection.cert = identity.certificate
      connection.extra_chain_cert = [pki.intermediate_certificate]
      connection.key = identity.key
      connection.verify_callback = -> (verified, _context) {
        callback_results << verified
        verified
      }
    end

    capability = capability_for(configured_client, proxy: :http_connect)
    2.times do |index|
      response = capability.execute(
        request(
          :get,
          "https://mtls.api.openai.com/v1/models",
          headers: {"authorization" => "Bearer fake-token-#{index}"}
        )
      )
      response.body.to_a
    end

    configured_client.close
    Timeout.timeout(2) { server_thread.join }
    assert_equal(["Bearer fake-token-0", "Bearer fake-token-1"], records.map { _1.fetch("authorization") })
    refute_empty(callback_results)
    assert(callback_results.all?)
    assert_equal(1, proxy.finish.length)
  ensure
    configured_client&.close
    proxy&.close
    server&.close
    server_thread&.kill&.join if server_thread&.alive?
  end

  def test_real_wire_direct_transport_rejects_ambient_proxy_before_connect
    return unless run_wire_subprocess

    proxy = Harness::ConnectProxy.new(authority_ports: {}, expected_connections: 0)
    capability = capability_for(@http_client, proxy: :direct)

    Harness.with_proxy_environment(proxy.uri) do
      error = assert_raises(ArgumentError) do
        capability.execute(request(:post, "https://mtls.auth.openai.com/oauth/token"))
      end

      assert_match(/direct transport rejects ambient proxies/, error.message)
    end

    assert_empty(proxy.finish)
  ensure
    proxy&.close
  end

  def test_real_wire_connect_transport_rejects_https_proxy_before_credentials_are_sent
    return unless run_wire_subprocess

    proxy = Harness::ConnectProxy.new(authority_ports: {}, expected_connections: 0)
    unsupported_proxy = URI(proxy.uri.to_s.sub(/\Ahttp:/, "https:"))
    capability = capability_for(@http_client, proxy: :http_connect)

    Harness.with_proxy_environment(unsupported_proxy) do
      error = assert_raises(ArgumentError) do
        capability.execute(request(:post, "https://mtls.auth.openai.com/oauth/token"))
      end

      assert_match(/rejects non-HTTP proxy schemes/, error.message)
    end

    assert_empty(proxy.finish)
  ensure
    proxy&.close
  end

  def test_real_wire_connect_transport_rejects_explicit_https_proxy_before_credentials_are_sent
    unless Net::HTTP.method_defined?(:proxy_use_ssl=)
      refute_respond_to(Net::HTTP.new("localhost"), :proxy_use_ssl=)
      return
    end

    return unless run_wire_subprocess

    proxy = Harness::ConnectProxy.new(authority_ports: {}, expected_connections: 0)
    configured_client = OpenAI::NetHTTPClient.new do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.proxy_use_ssl = true
    end

    capability = capability_for(configured_client, proxy: :http_connect)

    error = assert_raises(ArgumentError) do
      capability.execute(request(:post, "https://mtls.auth.openai.com/oauth/token"))
    end

    assert_match(/rejects non-HTTP proxy schemes/, error.message)
    assert_empty(proxy.finish)
  ensure
    configured_client&.close
    proxy&.close
  end

  def test_real_wire_transport_rejects_disabled_server_verification_before_connect
    return unless run_wire_subprocess

    proxy = Harness::ConnectProxy.new(authority_ports: {}, expected_connections: 0)
    configured_client = nil
    unsafe_configurations = {
      "peer verification" => -> (connection) { connection.verify_mode = OpenSSL::SSL::VERIFY_NONE },
      "hostname verification" => -> (connection) { connection.verify_hostname = false }
    }

    unsafe_configurations.each do |verification, configure|
      configured_client = OpenAI::NetHTTPClient.new do |connection|
        Harness.configure_http_connect_proxy(connection, proxy.uri)
        configure.call(connection)
      end

      capability = capability_for(configured_client, proxy: :http_connect)

      error = assert_raises(ArgumentError) do
        capability.execute(request(:post, "https://mtls.auth.openai.com/oauth/token"))
      end

      assert_match(/#{Regexp.escape(verification)}/, error.message)
      configured_client.close
    end

    assert_empty(proxy.finish)
  ensure
    configured_client&.close
    proxy&.close
  end

  def test_native_execute_callback_cannot_disable_tls_before_connection
    proxy = Harness::ConnectProxy.new(authority_ports: {}, expected_connections: 0)
    configured_client = OpenAI::NetHTTPClient.new do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
    end

    error = assert_raises(ArgumentError) do
      configured_client.execute(request(:get, "https://mtls.api.openai.com/v1/models")) do |connection|
        connection.use_ssl = false
      end
    end

    assert_match(/preserve TLS/, error.message)
    assert_empty(proxy.finish)
  ensure
    configured_client&.close
    proxy&.close
  end

  def test_native_execute_recovers_after_a_callback_temporarily_disables_tls
    return unless run_wire_subprocess

    hostname = "mtls.api.openai.com"
    pki = Harness::PKI.new(hostnames: [hostname])
    server = Harness::MTLSServer.new(hostname: hostname, pki: pki)
    proxy = Harness::ConnectProxy.new(
      authority_ports: {"#{hostname}:443" => server.local_port},
      expected_connections: 1
    )
    identity = pki.client_identity
    configured_client = OpenAI::NetHTTPClient.new(size: 1) do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.cert_store = pki.trust_store
      connection.cert = identity.certificate
      connection.extra_chain_cert = [pki.intermediate_certificate]
      connection.key = identity.key
    end

    native_request = request(:get, "https://mtls.api.openai.com/v1/models")
    error = assert_raises(ArgumentError) do
      configured_client.execute(native_request) { |connection| connection.use_ssl = false }
    end

    assert_match(/preserve TLS/, error.message)
    response = configured_client.execute(native_request)
    assert_equal(true, JSON.parse(response.body.to_a.join).fetch("ok"))

    configured_client.close
    assert_equal(1, server.finish.length)
    assert_equal(1, proxy.finish.length)
  ensure
    configured_client&.close
    proxy&.close
    server&.close
  end

  def test_native_execute_callback_cannot_start_an_unstarted_connection
    server = TCPServer.new("127.0.0.1", 0)
    port = server.local_address.ip_port
    native_request = request(:get, "http://127.0.0.1:#{port}/probe")
    configured_client = OpenAI::NetHTTPClient.new
    observed_connection = nil

    error = assert_raises(ArgumentError) do
      configured_client.execute(native_request) do |connection|
        observed_connection = connection
        connection.start
      end
    end

    assert_match(/unstarted/, error.message)
    refute_predicate(observed_connection, :started?)
  ensure
    configured_client&.close
    server&.close
  end

  def test_wire_subprocess_timeout_terminates_stalled_child
    sleep if ENV[WIRE_SUBPROCESS] == "1"

    error = assert_raises(Minitest::Assertion) { run_wire_subprocess(timeout: 0.1) }
    assert_match(/X\.509 wire subprocess exceeded 0\.1 seconds/, error.message)
  end

  private def run_wire_subprocess(timeout: WIRE_SUBPROCESS_TIMEOUT)
    return true if ENV[WIRE_SUBPROCESS] == "1"

    input, output, waiter = Open3.popen2e(
      {WIRE_SUBPROCESS => "1"},
      RbConfig.ruby,
      File.expand_path(__FILE__),
      "--name",
      name
    )
    input.close
    reader = Thread.new { output.read }
    timed_out = waiter.join(timeout).nil?
    terminate_wire_subprocess(waiter) if timed_out
    captured = reader.value
    captured << "\nX.509 wire subprocess exceeded #{timeout} seconds\n" if timed_out

    assert_predicate(waiter.value, :success?, captured)
    false
  ensure
    unless waiter.nil?
      begin
        Process.kill("KILL", waiter.pid) if waiter.alive?
      rescue Errno::ESRCH
        nil
      end

      waiter.join
    end

    input&.close unless input&.closed?
    output&.close unless output&.closed?
    reader&.kill if reader&.alive?
    reader&.join
  end

  private def terminate_wire_subprocess(waiter)
    Process.kill("TERM", waiter.pid)
    return unless waiter.join(WIRE_SUBPROCESS_TERM_GRACE).nil?

    Process.kill("KILL", waiter.pid)
    waiter.join
  rescue Errno::ESRCH
    waiter.join
  end

  private def start_keepalive_server(pki, hostname)
    server = TCPServer.new("127.0.0.1", 0)
    ssl_server = OpenSSL::SSL::SSLServer.new(server, pki.server_context(hostname))
    records = []
    worker = Thread.new do
      socket = ssl_server.accept
      while socket.gets
        headers = {}
        while (line = socket.gets) && line != "\r\n"
          name, value = line.split(":", 2)
          headers[name.downcase] = value.to_s.strip
        end

        records << headers.freeze
        body = JSON.generate(ok: true)
        socket.write(
          "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n" \
            "Content-Length: #{body.bytesize}\r\nConnection: keep-alive\r\n\r\n#{body}"
        )
      end

    ensure
      socket&.close
    end

    worker.report_on_exception = false

    [server, worker, records]
  end

  private def capability_for(http_client, proxy: :direct, api_origin: "https://mtls.api.openai.com")
    OpenAI::Auth::X509Transport.new(
      http_client: http_client,
      certificate_identity: :static,
      proxy: proxy,
      api_origin: api_origin
    )
  end

  private def request(method, url, headers: {}, body: nil)
    OpenAI::HTTPClient::Request.new(
      method: method,
      url: URI(url),
      headers: headers,
      body: body,
      timeout: 2.0
    )
  end
end
