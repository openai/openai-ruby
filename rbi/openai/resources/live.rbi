# typed: strong

module OpenAI
  module Resources

    class Live

      sig { returns(OpenAI::Resources::Live::Sideband) }
      attr_reader :sideband

      sig { returns(OpenAI::Resources::Live::Forks) }
      attr_reader :forks

      sig { returns(OpenAI::Resources::Live::Sessions) }
      attr_reader :sessions

      # Create a Live WebRTC session. Start with the
      # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting).
      sig {
        params(
          session: OpenAI::Live::MediaSessionConfig::OrHash,
          transport: OpenAI::Live::LiveCreateParams::Transport::OrHash,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Models::Live::LiveCreateResponse)
      }
      def create(
        # Startup configuration for the Live session.
        session:,
        # WebRTC transport with the browser's SDP offer.
        transport:,
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
