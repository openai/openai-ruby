# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#reject
      class SessionRejectParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session_id
        #
        #   @return [String]
        required :session_id, String

        # @!attribute status_code
        #   SIP rejection status sent to the caller. This field is required.
        #
        #   @return [Integer]
        required :status_code, Integer

        # @!method initialize(session_id:, status_code:, request_options: {})
        #   @param session_id [String]
        #
        #   @param status_code [Integer]
        #     SIP rejection status sent to the caller. This field is required.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
