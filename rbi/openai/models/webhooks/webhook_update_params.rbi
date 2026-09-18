# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookUpdateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookUpdateParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :webhook_endpoint_id

        # The complete set of event types that should trigger deliveries.
        sig { returns(T.nilable(T::Array[OpenAI::Webhooks::WebhookUpdateParams::EventType::OrSymbol])) }
        attr_reader :event_types

        sig { params(event_types: T::Array[OpenAI::Webhooks::WebhookUpdateParams::EventType::OrSymbol]).void }
        attr_writer :event_types

        # A new human-readable name for the webhook endpoint.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # A new HTTPS URL that receives webhook deliveries.
        sig { returns(T.nilable(String)) }
        attr_reader :url

        sig { params(url: String).void }
        attr_writer :url

        sig do
          params(

            webhook_endpoint_id: String,

            event_types: T::Array[OpenAI::Webhooks::WebhookUpdateParams::EventType::OrSymbol],

            name: String,

            url: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          webhook_endpoint_id:,

          # The complete set of event types that should trigger deliveries.
          event_types: nil,

          # A new human-readable name for the webhook endpoint.
          name: nil,

          # A new HTTPS URL that receives webhook deliveries.
          url: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              webhook_endpoint_id: String,
              event_types: T::Array[OpenAI::Webhooks::WebhookUpdateParams::EventType::OrSymbol],
              name: String,
              url: String,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # The event type to send as a sample delivery.
        module EventType
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Webhooks::WebhookUpdateParams::EventType) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          BATCH_COMPLETED = T.let(:"batch.completed", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          BATCH_FAILED = T.let(:"batch.failed", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          BATCH_EXPIRED = T.let(:"batch.expired", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          BATCH_CANCELLED = T.let(:"batch.cancelled", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          RESPONSE_COMPLETED = T.let(
            :"response.completed",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          RESPONSE_FAILED = T.let(:"response.failed", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          RESPONSE_CANCELLED = T.let(
            :"response.cancelled",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          RESPONSE_INCOMPLETE = T.let(
            :"response.incomplete",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          EVAL_RUN_SUCCEEDED = T.let(
            :"eval.run.succeeded",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          EVAL_RUN_FAILED = T.let(:"eval.run.failed", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          EVAL_RUN_CANCELED = T.let(
            :"eval.run.canceled",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_SUCCEEDED = T.let(
            :"fine_tuning.job.succeeded",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_FAILED = T.let(
            :"fine_tuning.job.failed",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_CANCELLED = T.let(
            :"fine_tuning.job.cancelled",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          REALTIME_CALL_INCOMING = T.let(
            :"realtime.call.incoming",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )
          VIDEO_COMPLETED = T.let(:"video.completed", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          VIDEO_FAILED = T.let(:"video.failed", OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol)
          SAFETY_ALERT_CREATED = T.let(
            :"safety.alert.created",
            OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol
          )

          sig { override.returns(T::Array[OpenAI::Webhooks::WebhookUpdateParams::EventType::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
