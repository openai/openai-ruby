# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::WebhookErrorTypesTest < Minitest::Test
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

  def test_invalid_signature_raises_the_declared_sdk_error_without_network
    client = OpenAI::Client.new(
      api_key: "synthetic-key",
      webhook_secret: "synthetic-webhook-secret"
    )

    error = assert_raises(OpenAI::Errors::InvalidWebhookSignatureError) do
      client.webhooks.verify_signature("{}", invalid_signature_headers)
    end

    assert_kind_of(OpenAI::Errors::Error, error)
  end

  def test_shipped_rbi_types_the_public_rescue_path
    stdout, stderr, status = sorbet_typecheck(typed_rescue_source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_typecheck_has_a_negative_control
    source = typed_rescue_source.sub(
      "T.let(error, OpenAI::Errors::Error)",
      "T.let(error, String)"
    )
    stdout, stderr, status = sorbet_typecheck(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "String")
  end

  private

  def invalid_signature_headers
    {
      "webhook-id" => "evt_synthetic",
      "webhook-timestamp" => Time.now.to_i.to_s,
      "webhook-signature" => "v1,synthetic-invalid-signature"
    }
  end

  def typed_rescue_source
    <<~RUBY
      # typed: true

      client = OpenAI::Client.new(api_key: "synthetic-key", webhook_secret: "synthetic-webhook-secret")
      headers = {
        "webhook-id" => "evt_synthetic",
        "webhook-timestamp" => Time.now.to_i.to_s,
        "webhook-signature" => "v1,synthetic-invalid-signature"
      }

      begin
        client.webhooks.verify_signature("{}", headers)
      rescue OpenAI::Errors::InvalidWebhookSignatureError => error
        exception = T.let(error, OpenAI::Errors::Error)
        puts(exception.class.name)
      end
    RUBY
  end

  def sorbet_typecheck(source)
    root = File.expand_path("../../..", __dir__)

    Tempfile.create(["webhook-error-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "typecheck",
        file.path,
        chdir: root
      )
    end
  end

end
