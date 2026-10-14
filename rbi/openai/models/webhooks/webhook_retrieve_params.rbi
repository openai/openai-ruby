# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookRetrieveParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookRetrieveParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :webhook_endpoint_id

        sig do
          params(

            webhook_endpoint_id: String,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          webhook_endpoint_id:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {webhook_endpoint_id: String, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
