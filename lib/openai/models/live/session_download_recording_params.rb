# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#download_recording
      class SessionDownloadRecordingParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session_id
        #   The ID of the stored Live session to download. Use the session ID returned when
        #   the session started with storage enabled.
        #
        #   @return [String]
        required :session_id, String

        # @!method initialize(session_id:, request_options: {})
        #   @param session_id [String]
        #     The ID of the stored Live session to download. Use the session ID returned when
        #     the session started with storage enabled.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
