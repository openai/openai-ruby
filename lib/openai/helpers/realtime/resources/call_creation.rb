# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # WebRTC call creation layered onto the generated Realtime Calls resource.
      module CallCreation
        # Create a WebRTC call from an SDP offer. When `session` is supplied, the SDK
        # sends the offer and session configuration as typed multipart form parts.
        #
        # @overload create(sdp:, session: nil, request_options: {})
        # @return [OpenAI::Models::Realtime::CallCreateResponse]
        def create(params)
          parsed, options = OpenAI::Realtime::CallCreateParams.dump_request(params)
          sdp = parsed.fetch(:sdp)
          session = parsed[:session]
          options = {max_retries: 0, **options.to_h}
          headers, body = request_body(sdp: sdp, session: session)

          response = @client.request_raw(
            method: :post,
            path: "realtime/calls",
            headers: headers,
            body: body,
            security: {bearer_auth: true},
            options: options
          )
          call_id = call_id_from_location(response.headers["location"])
          attributes = {
            sdp: read_sdp(response, call_id: call_id),
            headers: response.headers
          }
          attributes[:call_id] = call_id if call_id
          OpenAI::Realtime::CallCreateResponse.new(attributes)._set_last_response(response.metadata)
        end

        private def request_body(sdp:, session:)
          if session.nil?
            [{"accept" => "application/sdp", "content-type" => "application/sdp"}, sdp]
          else
            [
              {"accept" => "application/sdp", "content-type" => "multipart/form-data"},
              {
                sdp: OpenAI::FilePart.new(sdp, content_type: "application/sdp"),
                session: OpenAI::FilePart.new(JSON.generate(session), content_type: "application/json")
              }
            ]
          end
        end

        private def read_sdp(response, call_id:)
          response.body.to_a.join
        rescue StandardError
          cleanup_created_call(call_id)
          raise
        end

        private def cleanup_created_call(call_id)
          return if call_id.nil?

          hangup(call_id)
        rescue StandardError
          nil
        end

        # A Location header is helpful metadata, but the SDP answer remains usable
        # when an intermediary supplies a malformed value.
        private def call_id_from_location(location)
          path = location&.then { URI.parse(_1).path }
          match = path&.match(%r{(?:\A|/)realtime/calls/([^/]+)\z})
          match && match[1]
        rescue URI::InvalidURIError
          nil
        end
      end
    end
  end
end

OpenAI::Resources::Realtime::Calls.include(OpenAI::Helpers::Realtime::CallCreation)
