# typed: strong

module OpenAI
  module Models

    module Live

      class LiveCreateParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::LiveCreateParams,
            OpenAI::Internal::AnyHash
          )
        end

        # Startup configuration for the Live session.
        sig { returns(OpenAI::Live::MediaSessionConfig) }
        attr_reader :session

        sig { params(session: OpenAI::Live::MediaSessionConfig::OrHash).void }
        attr_writer :session

        # WebRTC transport with the browser's SDP offer.
        sig { returns(OpenAI::Live::LiveCreateParams::Transport) }
        attr_reader :transport

        sig { params(transport: OpenAI::Live::LiveCreateParams::Transport::OrHash).void }
        attr_writer :transport

        sig do
          params(

            session: OpenAI::Live::MediaSessionConfig::OrHash,

            transport: OpenAI::Live::LiveCreateParams::Transport::OrHash,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Startup configuration for the Live session.
          session:,

          # WebRTC transport with the browser's SDP offer.
          transport:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              session: OpenAI::Live::MediaSessionConfig,
              transport: OpenAI::Live::LiveCreateParams::Transport,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class Transport < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::LiveCreateParams::Transport,
              OpenAI::Internal::AnyHash
            )
          end

          # Session Description Protocol message for the WebRTC connection.
          sig { returns(String) }
          attr_accessor :sdp

          # The transport used for the Live session. Always `webrtc`.
          sig { returns(Symbol) }
          attr_accessor :type

          # WebRTC transport with the browser's SDP offer.
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
