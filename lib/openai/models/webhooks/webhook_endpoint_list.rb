# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class WebhookEndpointList < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   The webhook endpoints in this page.
        #
        #   @return [Array<OpenAI::Models::Webhooks::WebhookEndpoint>]
        required :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Webhooks::WebhookEndpoint] }

        # @!attribute first_id
        #   The ID of the first endpoint in this page.
        #
        #   @return [String, nil]
        required :first_id, String, nil?: true

        # @!attribute has_more
        #   Whether more webhook endpoints are available.
        #
        #   @return [Boolean]
        required :has_more, OpenAI::Internal::Type::Boolean

        # @!attribute last_id
        #   The ID of the last endpoint in this page.
        #
        #   @return [String, nil]
        required :last_id, String, nil?: true

        # @!attribute object
        #   The object type, which is always list.
        #
        #   @return [Symbol, :list]
        required :object, const: :list

        # @!method initialize(data:, first_id:, has_more:, last_id:, object: :list)
        #   @param data [Array<OpenAI::Models::Webhooks::WebhookEndpoint>]
        #     The webhook endpoints in this page.
        #
        #   @param first_id [String, nil]
        #     The ID of the first endpoint in this page.
        #
        #   @param has_more [Boolean]
        #     Whether more webhook endpoints are available.
        #
        #   @param last_id [String, nil]
        #     The ID of the last endpoint in this page.
        #
        #   @param object [Symbol, :list]
        #     The object type, which is always list.
      end
    end
  end
end
