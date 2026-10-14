# frozen_string_literal: true

require_relative "../test_helper"

# Real AWS requests are disabled unless BEDROCK_LIVE_TEST=1 is explicitly set.
#
# AWS_REGION=us-east-1 BEDROCK_LIVE_TEST=1 \
#   BUNDLE_GEMFILE=gemfiles/bedrock.gemfile \
#   bundle exec ruby test/openai/providers/bedrock_live_test.rb
#
# BEDROCK_AUTH_MODE selects auto, bearer, token-provider, sigv4, static, or profile.
# BEDROCK_MODEL selects one profile; BEDROCK_LIVE_MODELS selects comma-separated profiles.
# Set BEDROCK_LIVE_RESPONSES=1 or BEDROCK_LIVE_STREAM=1 for optional API coverage.
class OpenAI::Test::BedrockLiveTest < Minitest::Test
  extend Minitest::Serial

  DEFAULT_MODELS = %w[
    us.openai.gpt-5.6-sol
    us.openai.gpt-5.6-terra
    us.openai.gpt-5.6-luna
  ].freeze

  def test_bedrock_runtime_live_requests
    skip("Set BEDROCK_LIVE_TEST=1 to run real Bedrock Runtime requests.") unless live_enabled?

    client = OpenAI::Client.new(provider: OpenAI::Providers.bedrock(**provider_options))

    models.each do |model|
      assert_live_chat(client, model)
      assert_live_response(client, model) if ENV["BEDROCK_LIVE_RESPONSES"] == "1"
      assert_live_stream(client, model) if ENV["BEDROCK_LIVE_STREAM"] == "1"
    end
  end

  private def live_enabled?
    ENV["BEDROCK_LIVE_TEST"] == "1"
  end

  private def provider_options
    options = {
      endpoint: :runtime,
      region: ENV["AWS_REGION"] || ENV["AWS_DEFAULT_REGION"]
    }

    case ENV.fetch("BEDROCK_AUTH_MODE", "auto")
    when "auto"
      options
    when "bearer"
      options.merge(api_key: ENV.fetch("AWS_BEARER_TOKEN_BEDROCK"))
    when "token-provider"
      options.merge(token_provider: -> { ENV.fetch("AWS_BEARER_TOKEN_BEDROCK") })
    when "sigv4"
      options.merge(api_key: nil)
    when "static"
      options.merge(
        access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
        secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
        session_token: ENV["AWS_SESSION_TOKEN"]
      )
    when "profile"
      options.merge(profile: ENV.fetch("AWS_PROFILE"))
    else
      raise ArgumentError, "Unsupported BEDROCK_AUTH_MODE."
    end
  end

  private def models
    configured_models = ENV["BEDROCK_LIVE_MODELS"] || ENV["BEDROCK_MODEL"]
    return DEFAULT_MODELS unless configured_models

    values = configured_models.split(",").map(&:strip).reject(&:empty?)
    raise ArgumentError, "Configure at least one Bedrock model." if values.empty?

    values
  end

  private def assert_live_chat(client, model)
    completion = client.chat.completions.create(
      model: model,
      messages: [{role: :user, content: "Reply with the single word hello."}]
    )

    refute_empty(completion.choices)
    refute_nil(completion.choices.fetch(0).message.content)
  end

  private def assert_live_response(client, model)
    response = client.responses.create(model: model, input: "Reply with the single word hello.")

    refute_empty(response.output_text)
  end

  private def assert_live_stream(client, model)
    stream = client.chat.completions.stream(
      model: model,
      messages: [{role: :user, content: "Reply with the single word hello."}]
    )

    refute_empty(stream.text.to_a.join)
  ensure
    stream&.close
  end
end
