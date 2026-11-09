# frozen_string_literal: true

require_relative "../helpers/websocket/typed_resource"

module OpenAI
  module Resources
    class Live
      include OpenAI::WebSocket::TypedResource

      # @api private
      def __websocket_request(query: {})
        {method: :get, path: "live/sessions", query: query, security: {bearer_auth: true}}
      end

      # @api private
      def __websocket_client_event
        OpenAI::Models::Live::ClientEvent
      end

      # @api private
      def __websocket_server_event
        OpenAI::Models::Live::ServerEvent
      end

      # @return [OpenAI::Resources::Live::Sideband]
      attr_reader :sideband

      # @return [OpenAI::Resources::Live::Forks]
      attr_reader :forks

      # @return [OpenAI::Resources::Live::Sessions]
      attr_reader :sessions

      # Create a Live WebRTC session. Start with the
      # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting).
      #
      # @overload create(session:, transport:, request_options: {})
      #
      # @param session [OpenAI::Models::Live::MediaSessionConfig]
      #   Startup configuration for the Live session.
      #
      # @param transport [OpenAI::Models::Live::LiveCreateParams::Transport]
      #   WebRTC transport with the browser's SDP offer.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Live::LiveCreateResponse]
      #
      # @see OpenAI::Models::Live::LiveCreateParams
      def create(params)
        parsed, options = OpenAI::Live::LiveCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "live/sessions",
          body: parsed,
          model: OpenAI::Models::Live::LiveCreateResponse,
          security: {bearer_auth: true},
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @sideband = OpenAI::Resources::Live::Sideband.new(client: client)
        @forks = OpenAI::Resources::Live::Forks.new(client: client)
        @sessions = OpenAI::Resources::Live::Sessions.new(client: client)
      end
    end
  end
end
