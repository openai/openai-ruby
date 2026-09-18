# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookRotateSecretParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookRotateSecretParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :webhook_endpoint_id

        # Whether to keep the previous signing secret valid for 24 hours after rotation.
        # Defaults to false, which invalidates the previous secret immediately.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :keep_old_secret_active_for_24_hours

        sig { params(keep_old_secret_active_for_24_hours: T::Boolean).void }
        attr_writer :keep_old_secret_active_for_24_hours

        sig do
          params(

            webhook_endpoint_id: String,

            keep_old_secret_active_for_24_hours: T::Boolean,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          webhook_endpoint_id:,

          # Whether to keep the previous signing secret valid for 24 hours after rotation.
          # Defaults to false, which invalidates the previous secret immediately.
          keep_old_secret_active_for_24_hours: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              webhook_endpoint_id: String,
              keep_old_secret_active_for_24_hours: T::Boolean,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
