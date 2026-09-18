# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookEndpointList < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookEndpointList,
            OpenAI::Internal::AnyHash
          )
        end

        # The webhook endpoints in this page.
        sig { returns(T::Array[OpenAI::Webhooks::WebhookEndpoint]) }
        attr_accessor :data

        # The ID of the first endpoint in this page.
        sig { returns(T.nilable(String)) }
        attr_accessor :first_id

        # Whether more webhook endpoints are available.
        sig { returns(T::Boolean) }
        attr_accessor :has_more

        # The ID of the last endpoint in this page.
        sig { returns(T.nilable(String)) }
        attr_accessor :last_id

        # The object type, which is always list.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(

            data: T::Array[OpenAI::Webhooks::WebhookEndpoint::OrHash],

            first_id: T.nilable(String),

            has_more: T::Boolean,

            last_id: T.nilable(String),

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The webhook endpoints in this page.
          data:,

          # The ID of the first endpoint in this page.
          first_id:,

          # Whether more webhook endpoints are available.
          has_more:,

          # The ID of the last endpoint in this page.
          last_id:,

          # The object type, which is always list.

          object: :list
        )
        end

        sig do
          override.returns(
            {
              data: T::Array[OpenAI::Webhooks::WebhookEndpoint],
              first_id: T.nilable(String),
              has_more: T::Boolean,
              last_id: T.nilable(String),
              object: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
