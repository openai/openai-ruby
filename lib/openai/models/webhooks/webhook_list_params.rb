# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      # @see OpenAI::Resources::Webhooks#list
      class WebhookListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   ID of the last webhook endpoint from the previous page.
        #
        #   @return [String, nil]
        optional :after, String, nil?: true

        # @!attribute limit
        #   Maximum number of webhook endpoints to return. Defaults to 20.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!method initialize(after: nil, limit: nil, request_options: {})
        #   @param after [String, nil]
        #     ID of the last webhook endpoint from the previous page.
        #
        #   @param limit [Integer]
        #     Maximum number of webhook endpoints to return. Defaults to 20.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
