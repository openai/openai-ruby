# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#delete
      class WebhookDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute webhook_endpoint_id
        #
        #   @return [String]
        required :webhook_endpoint_id, String

        # @!method initialize(webhook_endpoint_id:, request_options: {})
        #   @param webhook_endpoint_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
