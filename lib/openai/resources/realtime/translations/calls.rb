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
            response = @client.request_raw(
              method: :post,
              path: "realtime/translations/calls",
              headers: {"accept" => "application/sdp", "content-type" => "application/sdp"},
              body: String(sdp),
              security: {bearer_auth: true},
              options: request_options
            )
            location = response.headers["location"]
            call_id = location&.then { URI.parse(_1).path.split("/").last }
            OpenAI::Realtime::CallCreateResponse.new(
              sdp: response.body.to_a.join,
              call_id: call_id,
              headers: response.headers
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
