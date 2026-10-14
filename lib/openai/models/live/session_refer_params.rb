# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#refer
      class SessionReferParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session_id
        #
        #   @return [String]
        required :session_id, String

        # @!attribute target_uri
        #   Nonblank URI for the SIP Refer-To header, such as tel:+14155550123 or
        #   sip:agent@example.com.
        #
        #   @return [String]
        required :target_uri, String

        # @!method initialize(session_id:, target_uri:, request_options: {})
        #   @param session_id [String]
        #
        #   @param target_uri [String]
        #     Nonblank URI for the SIP Refer-To header, such as tel:+14155550123 or
        #     sip:agent@example.com.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
