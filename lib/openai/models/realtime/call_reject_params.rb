# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::Calls#reject
      class CallRejectParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute status_code
        #   SIP response code to send back to the caller. Defaults to `603` (Decline) when
        #   omitted.
        #
        #   @return [Integer, nil]
        optional :status_code, Integer

        # @!method initialize(status_code: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::CallRejectParams} for more details.
        #
        #   @param status_code [Integer] SIP response code to send back to the caller. Defaults to `603` (Decline)
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
