# frozen_string_literal: true

require "json"
require "open3"
require "openssl"
require "rbconfig"

require_relative "test_helper"

class OpenAI::Test::WebhookReadmeDispatchTest < Minitest::Test
  README_PATH = File.expand_path("../../README.md", __dir__)
  LIB_PATH = File.expand_path("../../lib", __dir__)
  WEBHOOK_ID = "wh_synthetic_readme_dispatch"
  WEBHOOK_SECRET = "synthetic readme webhook secret"

  def test_unwrap_handler_dispatches_typed_response_events_and_retains_fallback
    completed = dispatch("response.completed")
    failed = dispatch("response.failed")
    fallback = dispatch("response.cancelled")

    assert_match(/\AResponse completed:/, completed)
    assert_match(/\AResponse failed:/, failed)
    assert_equal("Unhandled event type: response.cancelled\n", fallback)
  end

  private

  def dispatch(type)
    timestamp = Time.now.to_i.to_s
    payload = JSON.generate(
      id: "evt_synthetic_readme_dispatch",
      object: "event",
      created_at: timestamp.to_i,
      type: type,
      data: {id: "resp_synthetic_readme_dispatch"}
    )
    script = <<~RUBY
        require "json"
        require "openai"
        require "webmock"

        WebMock.disable_net_connect!
        client = OpenAI::Client.new(api_key: "sk-synthetic", webhook_secret: ARGV.fetch(2))
        payload = ARGV.fetch(0)
        headers = JSON.parse(ARGV.fetch(1))
        event = client.webhooks.unwrap(payload, headers)
      #{readme_dispatch}
    RUBY
    stdout, stderr, status = Open3.capture3(
      {"RUBYLIB" => $LOAD_PATH.join(File::PATH_SEPARATOR)},
      RbConfig.ruby,
      "-I",
      LIB_PATH,
      "-e",
      script,
      "--",
      payload,
      JSON.generate(signed_headers(payload, timestamp)),
      WEBHOOK_SECRET,
      unsetenv_others: true
    )

    assert(status.success?, stderr)
    stdout
  end

  def readme_dispatch
    File.read(README_PATH).match(/^    case event\.type\n(?:.*\n)*?^    end$/).to_s
  end

  def signed_headers(payload, timestamp)
    signed_payload = "#{WEBHOOK_ID}.#{timestamp}.#{payload}"
    signature = [OpenSSL::HMAC.digest("sha256", WEBHOOK_SECRET, signed_payload)].pack("m0")

    {
      "webhook-signature" => "v1,#{signature}",
      "webhook-timestamp" => timestamp,
      "webhook-id" => WEBHOOK_ID
    }
  end
end
