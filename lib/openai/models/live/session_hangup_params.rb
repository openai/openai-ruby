# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#hangup
      class SessionHangupParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session_id
        #
        #   @return [String]
        required :session_id, String

        # @!method initialize(session_id:, request_options: {})
        #   @param session_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
