# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#rotate_secret
      class WebhookRotateSecretParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute webhook_endpoint_id
        #
        #   @return [String]
        required :webhook_endpoint_id, String

        # @!attribute keep_old_secret_active_for_24_hours
        #   Whether to keep the previous signing secret valid for 24 hours after rotation.
        #   Defaults to false, which invalidates the previous secret immediately.
        #
        #   @return [Boolean, nil]
        optional :keep_old_secret_active_for_24_hours, OpenAI::Internal::Type::Boolean

        # @!method initialize(webhook_endpoint_id:, keep_old_secret_active_for_24_hours: nil, request_options: {})
        #   @param webhook_endpoint_id [String]
        #
        #   @param keep_old_secret_active_for_24_hours [Boolean]
        #     Whether to keep the previous signing secret valid for 24 hours after rotation.
        #     Defaults to false, which invalidates the previous secret immediately.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
