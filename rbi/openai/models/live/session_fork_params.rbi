# typed: strong

module OpenAI
  module Models

    module Live

      class SessionForkParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionForkParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :session_id

        # WebRTC transport with an SDP offer for the new connection to the forked session.
        sig { returns(OpenAI::Live::SessionForkParams::Transport) }
        attr_reader :transport

        sig { params(transport: OpenAI::Live::SessionForkParams::Transport::OrHash).void }
        attr_writer :transport

        # Optional configuration overrides for the new Live session. Omit this object or
        # send an empty object to inherit the stored session's settings.
        sig { returns(T.nilable(OpenAI::Live::MediaSessionForkConfig)) }
        attr_reader :session

        sig { params(session: OpenAI::Live::MediaSessionForkConfig::OrHash).void }
        attr_writer :session

        sig do
          params(

            session_id: String,

            transport: OpenAI::Live::SessionForkParams::Transport::OrHash,

            session: OpenAI::Live::MediaSessionForkConfig::OrHash,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          session_id:,

          # WebRTC transport with an SDP offer for the new connection to the forked session.
          transport:,

          # Optional configuration overrides for the new Live session. Omit this object or
          # send an empty object to inherit the stored session's settings.
          session: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              session_id: String,
              transport: OpenAI::Live::SessionForkParams::Transport,
              session: OpenAI::Live::MediaSessionForkConfig,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class Transport < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::SessionForkParams::Transport,
              OpenAI::Internal::AnyHash
            )
          end

          # Session Description Protocol message for the WebRTC connection.
          sig { returns(String) }
          attr_accessor :sdp

          # The transport used for the Live session. Always `webrtc`.
          sig { returns(Symbol) }
          attr_accessor :type

          # WebRTC transport with an SDP offer for the new connection to the forked session.
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
