# frozen_string_literal: true

module OpenAI
  module Resources
    class Live
      class Sessions
        # Accept an incoming SIP call. Supply session with type live, the model, and
        # startup configuration. Before accepting calls, follow the
        # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting)
        # to write frontend conversation instructions and a separate backend prompt. SIP
        # media format is negotiated; omit audio.format.
        #
        # @overload accept(session_id, session:, request_options: {})
        #
        # @param session_id [String]
        #   Opaque Live session identifier from the creation response or incoming-call
        #   webhook. Preserve the returned value unchanged, including its prefix.
        #
        # @param session [OpenAI::Models::Live::SessionAcceptParams::Session]
        #   Model and startup configuration for the Live session that answers the incoming
        #   SIP call.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Live::SessionAcceptParams
        def accept(session_id, params)
          parsed, options = OpenAI::Live::SessionAcceptParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["live/sessions/%1$s/accept", session_id],
            body: parsed,
            model: NilClass,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Get Live session content
        #
        # @overload download_recording(session_id, request_options: {})
        #
        # @param session_id [String]
        #   The ID of the stored Live session to download. Use the session ID returned when
        #   the session started with storage enabled.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [StringIO]
        #
        # @see OpenAI::Models::Live::SessionDownloadRecordingParams
        def download_recording(session_id, params = {})
          @client.request(
            method: :get,
            path: ["live/sessions/%1$s/content", session_id],
            headers: {"accept" => "application/binary"},
            model: StringIO,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # Fork a stored Live session onto a new WebRTC connection.
        #
        # @overload fork(session_id, transport:, session: nil, request_options: {})
        #
        # @param session_id [String]
        #   The ID of the stored Live session to fork.
        #
        # @param transport [OpenAI::Models::Live::SessionForkParams::Transport]
        #   WebRTC transport with an SDP offer for the new connection to the forked session.
        #
        # @param session [OpenAI::Models::Live::MediaSessionForkConfig]
        #   Optional configuration overrides for the new Live session. Omit this object or
        #   send an empty object to inherit the stored session's settings.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Live::SessionForkResponse]
        #
        # @see OpenAI::Models::Live::SessionForkParams
        def fork(session_id, params)
          parsed, options = OpenAI::Live::SessionForkParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["live/sessions/%1$s/fork", session_id],
            body: parsed,
            model: OpenAI::Models::Live::SessionForkResponse,
            security: {bearer_auth: true},
            options: options
          )
        end

        # End a SIP call identified by session_id.
        #
        # @overload hangup(session_id, request_options: {})
        #
        # @param session_id [String]
        #   Opaque Live session identifier from the creation response or incoming-call
        #   webhook. Preserve the returned value unchanged, including its prefix.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Live::SessionHangupParams
        def hangup(session_id, params = {})
          @client.request(
            method: :post,
            path: ["live/sessions/%1$s/hangup", session_id],
            model: NilClass,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # Transfer a SIP call to another destination. Supply a nonblank target_uri for the
        # SIP Refer-To header.
        #
        # @overload refer(session_id, target_uri:, request_options: {})
        #
        # @param session_id [String]
        #   Opaque Live session identifier from the creation response or incoming-call
        #   webhook. Preserve the returned value unchanged, including its prefix.
        #
        # @param target_uri [String]
        #   Nonblank URI for the SIP Refer-To header, such as tel:+14155550123 or
        #   sip:agent@example.com.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Live::SessionReferParams
        def refer(session_id, params)
          parsed, options = OpenAI::Live::SessionReferParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["live/sessions/%1$s/refer", session_id],
            body: parsed,
            model: NilClass,
            security: {bearer_auth: true},
            options: options
          )
        end

        # Reject an incoming SIP call. Send a required SIP rejection status_code between
        # 300 and 699.
        #
        # @overload reject(session_id, status_code:, request_options: {})
        #
        # @param session_id [String]
        #   Opaque Live session identifier from the creation response or incoming-call
        #   webhook. Preserve the returned value unchanged, including its prefix.
        #
        # @param status_code [Integer]
        #   SIP rejection status sent to the caller. This field is required.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Live::SessionRejectParams
        def reject(session_id, params)
          parsed, options = OpenAI::Live::SessionRejectParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["live/sessions/%1$s/reject", session_id],
            body: parsed,
            model: NilClass,
            security: {bearer_auth: true},
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
