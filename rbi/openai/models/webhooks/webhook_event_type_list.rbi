# typed: strong

module OpenAI
  module Models

    module Webhooks

      class WebhookEventTypeList < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::WebhookEventTypeList,
            OpenAI::Internal::AnyHash
          )
        end

        # The webhook event types available to the authenticated project.
        sig { returns(T::Array[String]) }
        attr_accessor :data

        # The object type, which is always list.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(

            data: T::Array[String],

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The webhook event types available to the authenticated project.
          data:,

          # The object type, which is always list.

          object: :list
        )
        end

        sig do
          override.returns(
            {data: T::Array[String], object: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
