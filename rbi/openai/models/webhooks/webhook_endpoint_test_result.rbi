# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookEndpointTestResult < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookEndpointTestResult,
            OpenAI::Internal::AnyHash
          )
        end

        # The event type sent in the test.
        sig { returns(String) }
        attr_accessor :event_type

        # The object type, which is always webhook_endpoint.test.
        sig { returns(Symbol) }
        attr_accessor :object

        # The HTTP status code returned by the endpoint.
        sig { returns(Integer) }
        attr_accessor :status_code

        # Whether the test request completed. Always true for returned results; use
        # status_code to determine the endpoint response.
        sig { returns(T::Boolean) }
        attr_accessor :success

        # The ID of the webhook endpoint that received the test.
        sig { returns(String) }
        attr_accessor :webhook_endpoint_id

        sig do
          params(

            event_type: String,

            status_code: Integer,

            success: T::Boolean,

            webhook_endpoint_id: String,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The event type sent in the test.
          event_type:,

          # The HTTP status code returned by the endpoint.
          status_code:,

          # Whether the test request completed. Always true for returned results; use
          # status_code to determine the endpoint response.
          success:,

          # The ID of the webhook endpoint that received the test.
          webhook_endpoint_id:,

          # The object type, which is always webhook_endpoint.test.

          object: :"webhook_endpoint.test"
        )
        end

        sig do
          override.returns(
            {event_type: String, object: Symbol, status_code: Integer, success: T::Boolean, webhook_endpoint_id: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
