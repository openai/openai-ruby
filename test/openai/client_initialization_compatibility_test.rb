# frozen_string_literal: true

require_relative "test_helper"

# Consumer subclasses may already use this private name for their own setup.
# SDK construction and copying must not start dispatching to that method.
class OpenAI::Test::ClientInitializationCompatibilityTest < Minitest::Test
  def test_customer_private_initializer_with_arguments_does_not_affect_client_construction
    customer_client = Class.new(OpenAI::Client) do
      private def initialize_resources(config)
        config
      end
    end

    client = customer_client.new(api_key: "synthetic-test-key", admin_api_key: nil)
    copy = client.with_options(base_url: "https://example.invalid/v1")

    assert_instance_of(OpenAI::Resources::Responses, client.responses)
    assert_instance_of(OpenAI::Resources::Responses, copy.responses)
    refute_same(client.responses, copy.responses)
  end

  def test_customer_private_initializer_is_not_silently_used_for_sdk_resources
    customer_client = Class.new(OpenAI::Client) do
      attr_reader(:customer_initializer_called)

      private def initialize_resources
        @customer_initializer_called = true
      end
    end

    client = customer_client.new(api_key: "synthetic-test-key", admin_api_key: nil)

    refute(client.customer_initializer_called)
    assert_instance_of(OpenAI::Resources::Responses, client.responses)
  end
end
