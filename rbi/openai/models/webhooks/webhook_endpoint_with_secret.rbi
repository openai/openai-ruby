# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookEndpointWithSecret < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookEndpointWithSecret,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the webhook endpoint.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp when the endpoint was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The event types that trigger deliveries to this endpoint.
        sig { returns(T::Array[String]) }
        attr_accessor :event_types

        # The human-readable name of the endpoint.
        sig { returns(String) }
        attr_accessor :name

        # The object type, which is always webhook_endpoint.
        sig { returns(Symbol) }
        attr_accessor :object

        # The endpoint's signing secret. This is returned only when the endpoint is
        # created or the secret is rotated.
        sig { returns(String) }
        attr_accessor :signing_secret

        # A masked hint for the endpoint's signing secret.
        sig { returns(T.nilable(String)) }
        attr_accessor :signing_secret_hint

        # The HTTPS URL that receives webhook deliveries.
        sig { returns(String) }
        attr_accessor :url

        # The Unix timestamp of the last endpoint configuration or signing-secret change.
        # Initialized at creation; tests and unchanged updates do not advance it.
        sig { returns(T.nilable(Integer)) }
        attr_reader :updated_at

        sig { params(updated_at: Integer).void }
        attr_writer :updated_at

        sig do
          params(

            id: String,

            created_at: Integer,

            event_types: T::Array[String],

            name: String,

            signing_secret: String,

            signing_secret_hint: T.nilable(String),

            url: String,

            updated_at: Integer,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the webhook endpoint.
          id:,

          # The Unix timestamp when the endpoint was created.
          created_at:,

          # The event types that trigger deliveries to this endpoint.
          event_types:,

          # The human-readable name of the endpoint.
          name:,

          # The endpoint's signing secret. This is returned only when the endpoint is
          # created or the secret is rotated.
          signing_secret:,

          # A masked hint for the endpoint's signing secret.
          signing_secret_hint:,

          # The HTTPS URL that receives webhook deliveries.
          url:,

          # The Unix timestamp of the last endpoint configuration or signing-secret change.
          # Initialized at creation; tests and unchanged updates do not advance it.
          updated_at: nil,

          # The object type, which is always webhook_endpoint.

          object: :webhook_endpoint
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              event_types: T::Array[String],
              name: String,
              object: Symbol,
              signing_secret: String,
              signing_secret_hint: T.nilable(String),
              url: String,
              updated_at: Integer
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
