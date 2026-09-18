# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookCreateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookCreateParams,
            OpenAI::Internal::AnyHash
          )
        end

        # The event types that trigger deliveries to this endpoint.
        sig { returns(T::Array[OpenAI::Webhooks::WebhookCreateParams::EventType::OrSymbol]) }
        attr_accessor :event_types

        # A human-readable name for the webhook endpoint.
        sig { returns(String) }
        attr_accessor :name

        # The HTTPS URL that receives webhook deliveries.
        sig { returns(String) }
        attr_accessor :url

        sig do
          params(

            event_types: T::Array[OpenAI::Webhooks::WebhookCreateParams::EventType::OrSymbol],

            name: String,

            url: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The event types that trigger deliveries to this endpoint.
          event_types:,

          # A human-readable name for the webhook endpoint.
          name:,

          # The HTTPS URL that receives webhook deliveries.
          url:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              event_types: T::Array[OpenAI::Webhooks::WebhookCreateParams::EventType::OrSymbol],
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

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Webhooks::WebhookCreateParams::EventType) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          BATCH_COMPLETED = T.let(:"batch.completed", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          BATCH_FAILED = T.let(:"batch.failed", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          BATCH_EXPIRED = T.let(:"batch.expired", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          BATCH_CANCELLED = T.let(:"batch.cancelled", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          RESPONSE_COMPLETED = T.let(
            :"response.completed",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          RESPONSE_FAILED = T.let(:"response.failed", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          RESPONSE_CANCELLED = T.let(
            :"response.cancelled",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          RESPONSE_INCOMPLETE = T.let(
            :"response.incomplete",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          EVAL_RUN_SUCCEEDED = T.let(
            :"eval.run.succeeded",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          EVAL_RUN_FAILED = T.let(:"eval.run.failed", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          EVAL_RUN_CANCELED = T.let(
            :"eval.run.canceled",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_SUCCEEDED = T.let(
            :"fine_tuning.job.succeeded",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_FAILED = T.let(
            :"fine_tuning.job.failed",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_CANCELLED = T.let(
            :"fine_tuning.job.cancelled",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          REALTIME_CALL_INCOMING = T.let(
            :"realtime.call.incoming",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )
          VIDEO_COMPLETED = T.let(:"video.completed", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          VIDEO_FAILED = T.let(:"video.failed", OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol)
          SAFETY_ALERT_CREATED = T.let(
            :"safety.alert.created",
            OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol
          )

          sig { override.returns(T::Array[OpenAI::Webhooks::WebhookCreateParams::EventType::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
