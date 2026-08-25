# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509TransportSecurityTest < Minitest::Test
  def setup
    super
    @http_client = OpenAI::NetHTTPClient.new
    @transport = OpenAI::Auth::X509Transport.new(
      http_client: @http_client,
      certificate_identity: :static
    )
  end

  def teardown
    @http_client.close
    super
  end

  def test_verification_callbacks_cannot_enable_raw_debug_output_during_handshake
    output = StringIO.new
    connection = Net::HTTP.new("mtls.api.openai.com", 443, nil)
    connection.use_ssl = true
    connection.verify_callback = -> (verified, _context) {
      connection.set_debug_output(output)
      verified
    }
    dispatch = lambda do |_request, &validator|
      validator.call(connection)
      connection.verify_callback.call(true, nil)
      flunk("a verification callback enabled raw debug output")
    end

    error = @http_client.stub(:execute, dispatch) do
      assert_raises(ArgumentError) do
        @transport.execute(request(headers: {"authorization" => "Bearer fake-secret-token"}))
      end
    end

    assert_match(/debug output/, error.message)
    refute_includes(output.string, "fake-secret-token")
  end

  def test_redirect_cleanup_errors_never_retain_sensitive_request_data
    destination = URI("https://mtls.api.openai.com/v1/models?signature=fake-query-secret#fake-fragment")
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    classes.each do |error_class|
      retained = Net::HTTP::Get.new(destination)
      retained["authorization"] = "Bearer fake-retained-secret"
      original = error_class.new(url: destination, request: retained, message: "fake-error-secret")
      source = OpenAI::Internal::Util.fused_enum([].each) do
        raise original, cause: IOError.new("fake-cause-secret")
      end

      response = OpenAI::HTTPClient::Response.new(status: 307, headers: {}, body: source)

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(error_class) do
          @transport.execute(
            request(url: destination, headers: {"authorization" => "Bearer fake-retained-secret"})
          )
        end
      end

      assert_equal("https://mtls.api.openai.com/v1/models", error.url.to_s)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_match(/fake-query-secret|fake-retained-secret|fake-error-secret|fake-cause-secret/, error.inspect)
    end
  end

  def test_closing_never_started_bodies_sanitizes_cleanup_failures
    destination = URI("https://mtls.api.openai.com/v1/models?signature=fake-query-secret#fake-fragment")
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    classes.each do |error_class|
      retained = Net::HTTP::Get.new(destination)
      retained["authorization"] = "Bearer fake-retained-secret"
      original = error_class.new(url: destination, request: retained, message: "fake-error-secret")
      started = false
      source = OpenAI::Internal::Util.fused_enum(Enumerator.new { started = true }) do
        raise original, cause: IOError.new("fake-cause-secret")
      end

      native_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: source)
      response = @http_client.stub(:execute, -> (_request) { native_response }) do
        @transport.execute(request(url: destination, headers: {"authorization" => "Bearer fake-retained-secret"}))
      end

      error = assert_raises(error_class) { OpenAI::Internal::Util.close_fused!(response.body) }

      refute(started)
      assert_equal("https://mtls.api.openai.com/v1/models", error.url.to_s)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_match(/fake-query-secret|fake-retained-secret|fake-error-secret|fake-cause-secret/, error.inspect)
    end
  end

  def test_bodyless_protocol_failures_never_expose_malformed_wire_data
    destination = URI("https://mtls.api.openai.com/v1/models")
    nested = begin
      begin
        raise Net::HTTPBadResponse, "fake-sensitive-wire-line"
      rescue Net::HTTPBadResponse
        raise IOError, "safe outer protocol wrapper"
      end

    rescue IOError => error
      error
    end

    cyclic = Class.new(IOError) do
      def cause = self
    end

    inaccessible = Class.new(IOError) do
      def cause
        raise "fake-sensitive-cause-accessor"
      end
    end

    causes = [
      Net::HTTPBadResponse.new("fake-sensitive-wire-line"),
      Net::HTTPHeaderSyntaxError.new("fake-sensitive-wire-line"),
      Net::ProtocolError.new("fake-sensitive-wire-line"),
      Zlib::DataError.new("fake-sensitive-wire-line"),
      nested,
      cyclic.new("safe cyclic cause"),
      inaccessible.new("safe inaccessible cause")
    ]

    causes.product([false, true]).each do |cause, deferred|
      original = OpenAI::Errors::APIConnectionError.new(url: destination)
      failure = -> { raise original, cause: cause }
      dispatch = if deferred
        -> (_request) {
          OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: Enumerator.new { failure.call })
        }
      else
        -> (_request) { failure.call }
      end

      error = @http_client.stub(:execute, dispatch) do
        assert_raises(OpenAI::Errors::APIConnectionError) do
          response = @transport.execute(request(url: destination))
          response.body.to_a
        end
      end

      assert_equal(destination.to_s, error.url.to_s)
      assert_nil(error.cause)
      refute_includes(error.full_message(highlight: false), "fake-sensitive-wire-line")
    end
  end

  def test_unrecognized_custom_credential_headers_never_survive_transport_failures
    destination = URI("https://mtls.api.openai.com/v1/models")
    classes = [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError]

    classes.product([false, true]).each do |error_class, deferred|
      retained = Net::HTTP::Get.new(destination)
      retained["x-client-assertion"] = "fake-custom-credential-secret"
      original = error_class.new(url: destination, request: retained, message: "fake-error-secret")
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
          response = @transport.execute(
            request(url: destination, headers: {"x-client-assertion" => "fake-custom-credential-secret"})
          )
          response.body.to_a
        end
      end

      assert_equal(destination.to_s, error.url.to_s)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_match(/fake-custom-credential-secret|fake-error-secret|fake-cause-secret/, error.inspect)
    end
  end

  private def request(url: URI("https://mtls.api.openai.com/v1/models"), headers: {})
    OpenAI::HTTPClient::Request.new(
      method: :get,
      url: url,
      headers: headers,
      body: nil,
      timeout: 2.0
    )
  end
end
