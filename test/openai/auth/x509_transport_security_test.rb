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
