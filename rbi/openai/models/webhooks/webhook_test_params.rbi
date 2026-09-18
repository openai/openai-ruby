# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookTestParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookTestParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :webhook_endpoint_id

        # The event type to send as a sample delivery.
        sig { returns(OpenAI::Webhooks::WebhookTestParams::EventType::OrSymbol) }
        attr_accessor :event_type

        sig do
          params(

            webhook_endpoint_id: String,

            event_type: OpenAI::Webhooks::WebhookTestParams::EventType::OrSymbol,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          webhook_endpoint_id:,

          # The event type to send as a sample delivery.
          event_type:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              webhook_endpoint_id: String,
              event_type: OpenAI::Webhooks::WebhookTestParams::EventType::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # The event type to send as a sample delivery.
        module EventType
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Webhooks::WebhookTestParams::EventType) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          BATCH_COMPLETED = T.let(:"batch.completed", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          BATCH_FAILED = T.let(:"batch.failed", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          BATCH_EXPIRED = T.let(:"batch.expired", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          BATCH_CANCELLED = T.let(:"batch.cancelled", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          RESPONSE_COMPLETED = T.let(
            :"response.completed",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          RESPONSE_FAILED = T.let(:"response.failed", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          RESPONSE_CANCELLED = T.let(
            :"response.cancelled",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          RESPONSE_INCOMPLETE = T.let(
            :"response.incomplete",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          EVAL_RUN_SUCCEEDED = T.let(
            :"eval.run.succeeded",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          EVAL_RUN_FAILED = T.let(:"eval.run.failed", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          EVAL_RUN_CANCELED = T.let(:"eval.run.canceled", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          FINE_TUNING_JOB_SUCCEEDED = T.let(
            :"fine_tuning.job.succeeded",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_FAILED = T.let(
            :"fine_tuning.job.failed",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          FINE_TUNING_JOB_CANCELLED = T.let(
            :"fine_tuning.job.cancelled",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          REALTIME_CALL_INCOMING = T.let(
            :"realtime.call.incoming",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )
          VIDEO_COMPLETED = T.let(:"video.completed", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          VIDEO_FAILED = T.let(:"video.failed", OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol)
          SAFETY_ALERT_CREATED = T.let(
            :"safety.alert.created",
            OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol
          )

          sig { override.returns(T::Array[OpenAI::Webhooks::WebhookTestParams::EventType::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
