# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Translations
        class Calls
          # Create a translation WebRTC call from an SDP offer.
          #
          # @param sdp [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          # @return [OpenAI::Models::Realtime::CallCreateResponse]
          def create(sdp:, request_options: nil)
            @client.realtime.calls.create_with_path(
              {sdp: sdp, request_options: request_options},
              path: "realtime/translations/calls",
              hangup_path: "realtime/translations/calls/%1$s/hangup"
            )
          end

          # @api private
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
