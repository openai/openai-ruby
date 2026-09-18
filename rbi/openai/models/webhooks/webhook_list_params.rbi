# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookListParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookListParams,
            OpenAI::Internal::AnyHash
          )
        end

        # ID of the last webhook endpoint from the previous page.
        sig { returns(T.nilable(String)) }
        attr_accessor :after

        # Maximum number of webhook endpoints to return. Defaults to 20.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        sig do
          params(

            after: T.nilable(String),

            limit: Integer,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # ID of the last webhook endpoint from the previous page.
          after: nil,

          # Maximum number of webhook endpoints to return. Defaults to 20.
          limit: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {after: T.nilable(String), limit: Integer, request_options: OpenAI::RequestOptions}
          )
        end
        def to_hash
        end

      end

    end

  end
end
