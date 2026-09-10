# typed: strong

module OpenAI
  module Resources

    class Live

      class Sessions

        # Accept an incoming SIP call. Supply session with type live, the model, and
        # startup configuration. Before accepting calls, follow the
        # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting)
        # to write frontend conversation instructions and a separate backend prompt. SIP
        # media format is negotiated; omit audio.format.
        sig {
          params(
            session_id: String,
            session: OpenAI::Live::SessionAcceptParams::Session::OrHash,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .void
        }
        def accept(
          # Opaque Live session identifier from the creation response or incoming-call
          # webhook. Preserve the returned value unchanged, including its prefix.
          session_id,
          # Model and startup configuration for the Live session that answers the incoming
          # SIP call.
          session:,
          request_options: {}
        )
        end

        # Get Live session content
        sig {
          params(session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
            T.all(StringIO, OpenAI::ResponseCarrier)
          )
        }
        def download_recording(
          # The ID of the stored Live session to download. Use the session ID returned when
          # the session started with storage enabled.
          session_id,
          request_options: {}
        )
        end

        # Fork a stored Live session onto a new WebRTC connection.
        sig {
          params(
            session_id: String,
            transport: OpenAI::Live::SessionForkParams::Transport::OrHash,
            session: OpenAI::Live::MediaSessionForkConfig::OrHash,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Models::Live::SessionForkResponse)
        }
        def fork(
          # The ID of the stored Live session to fork.
          session_id,
          # WebRTC transport with an SDP offer for the new connection to the forked session.
          transport:,
          # Optional configuration overrides for the new Live session. Omit this object or
          # send an empty object to inherit the stored session's settings.
          session: nil,
          request_options: {}
        )
        end

        # End a SIP call identified by session_id.
        sig { params(session_id: String, request_options: OpenAI::RequestOptions::OrHash).void }
        def hangup(
          # Opaque Live session identifier from the creation response or incoming-call
          # webhook. Preserve the returned value unchanged, including its prefix.
          session_id,
          request_options: {}
        )
        end

        # Transfer a SIP call to another destination. Supply a nonblank target_uri for the
        # SIP Refer-To header.
        sig { params(session_id: String, target_uri: String, request_options: OpenAI::RequestOptions::OrHash).void }
        def refer(
          # Opaque Live session identifier from the creation response or incoming-call
          # webhook. Preserve the returned value unchanged, including its prefix.
          session_id,
          # Nonblank URI for the SIP Refer-To header, such as tel:+14155550123 or
          # sip:agent@example.com.
          target_uri:,
          request_options: {}
        )
        end

        # Reject an incoming SIP call. Send a required SIP rejection status_code between
        # 300 and 699.
        sig { params(session_id: String, status_code: Integer, request_options: OpenAI::RequestOptions::OrHash).void }
        def reject(
          # Opaque Live session identifier from the creation response or incoming-call
          # webhook. Preserve the returned value unchanged, including its prefix.
          session_id,
          # SIP rejection status sent to the caller. This field is required.
          status_code:,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
