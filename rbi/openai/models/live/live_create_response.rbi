# typed: strong

module OpenAI
  module Models

    module Live

      class LiveCreateResponse < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Models::Live::LiveCreateResponse,
            OpenAI::Internal::AnyHash
          )
        end

        # The newly created Live session. Use its ID for session controls and sideband
        # connections.
        sig { returns(OpenAI::Models::Live::LiveCreateResponse::Session) }
        attr_reader :session

        sig { params(session: OpenAI::Models::Live::LiveCreateResponse::Session::OrHash).void }
        attr_writer :session

        # WebRTC transport with the SDP answer.
        sig { returns(OpenAI::Models::Live::LiveCreateResponse::Transport) }
        attr_reader :transport

        sig { params(transport: OpenAI::Models::Live::LiveCreateResponse::Transport::OrHash).void }
        attr_writer :transport

        # The created Live session identifier and WebRTC answer. Apply transport.sdp as
        # the peer's remote answer and wait for session.started on the data channel before
        # sending commands.
        sig do
          params(

            session: OpenAI::Models::Live::LiveCreateResponse::Session::OrHash,

            transport: OpenAI::Models::Live::LiveCreateResponse::Transport::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The newly created Live session. Use its ID for session controls and sideband
          # connections.
          session:,

          # WebRTC transport with the SDP answer.

          transport:
        )
        end

        sig do
          override.returns(
            {
              session: OpenAI::Models::Live::LiveCreateResponse::Session,
              transport: OpenAI::Models::Live::LiveCreateResponse::Transport
            }
          )
        end
        def to_hash
        end

        class Session < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::Live::LiveCreateResponse::Session,
              OpenAI::Internal::AnyHash
            )
          end

          # Opaque session identifier. Preserve the returned value unchanged, including its
          # prefix.
          sig { returns(String) }
          attr_accessor :id

          # The newly created Live session. Use its ID for session controls and sideband
          # connections.
          sig do
            params(

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Opaque session identifier. Preserve the returned value unchanged, including its
            # prefix.

            id:
          )
          end

          sig do
            override.returns(
              {id: String}
            )
          end
          def to_hash
          end

        end

        class Transport < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::Live::LiveCreateResponse::Transport,
              OpenAI::Internal::AnyHash
            )
          end

          # Session Description Protocol message for the WebRTC connection.
          sig { returns(String) }
          attr_accessor :sdp

          # The transport used for the Live session. Always `webrtc`.
          sig { returns(Symbol) }
          attr_accessor :type

          # WebRTC transport with the SDP answer.
          sig do
            params(

              sdp: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Session Description Protocol message for the WebRTC connection.
            sdp:,

            # The transport used for the Live session. Always `webrtc`.

            type: :webrtc
          )
          end

          sig do
            override.returns(
              {sdp: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
