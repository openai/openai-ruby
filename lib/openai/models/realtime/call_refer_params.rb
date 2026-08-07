# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::Calls#refer
      class CallReferParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute call_id
        #
        #   @return [String]
        required :call_id, String

        # @!attribute target_uri
        #   URI that should appear in the SIP Refer-To header. Supports values like
        #   `tel:+14155550123` or `sip:agent@example.com`.
        #
        #   @return [String]
        required :target_uri, String

        # @!method initialize(call_id:, target_uri:, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::CallReferParams} for more details.
        #
        #   @param call_id [String]
        #
        #   @param target_uri [String] URI that should appear in the SIP Refer-To header. Supports values like
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
