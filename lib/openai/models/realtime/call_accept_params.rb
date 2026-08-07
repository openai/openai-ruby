# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::Calls#accept
      class CallAcceptParams < OpenAI::Models::Realtime::RealtimeSessionCreateRequest
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute call_id
        #
        #   @return [String]
        required :call_id, String

        # @!method initialize(call_id:, request_options: {})
        #   @param call_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
