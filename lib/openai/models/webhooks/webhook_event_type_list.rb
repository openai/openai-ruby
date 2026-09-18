# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class WebhookEventTypeList < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   The webhook event types available to the authenticated project.
        #
        #   @return [Array<String>]
        required :data, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute object
        #   The object type, which is always list.
        #
        #   @return [Symbol, :list]
        required :object, const: :list

        # @!method initialize(data:, object: :list)
        #   @param data [Array<String>]
        #     The webhook event types available to the authenticated project.
        #
        #   @param object [Symbol, :list]
        #     The object type, which is always list.
      end
    end
  end
end
