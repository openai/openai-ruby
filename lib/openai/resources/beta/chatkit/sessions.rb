# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class ChatKit
        class Sessions
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::ChatKit::SessionCreateParams} for more details.
          #
          # Create a ChatKit session
          #
          # @overload create(user:, workflow:, chatkit_configuration: nil, expires_after: nil, rate_limits: nil, request_options: {})
          #
          # @param user [String] A free-form string that identifies your end user; ensures this Session can acces
          #
          # @param workflow [OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam] Workflow that powers the session.
          #
          # @param chatkit_configuration [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam] Optional overrides for ChatKit runtime configuration features
          #
          # @param expires_after [OpenAI::Models::Beta::ChatKit::ChatSessionExpiresAfterParam] Optional override for session expiration timing in seconds from creation. Defaul
          #
          # @param rate_limits [OpenAI::Models::Beta::ChatKit::ChatSessionRateLimitsParam] Optional override for per-minute request limits. When omitted, defaults to 10.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::ChatKit::ChatSession]
          #
          # @see OpenAI::Models::Beta::ChatKit::SessionCreateParams
          def create(params)
            parsed, options = OpenAI::Beta::ChatKit::SessionCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "chatkit/sessions",
              body: parsed,
              model: OpenAI::Beta::ChatKit::ChatSession,
              options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **options}
            )
          end

          # Cancel a ChatKit session
          #
          # @overload cancel(session_id, request_options: {})
          #
          # @param session_id [String] Unique identifier for the ChatKit session to cancel.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::ChatKit::ChatSession]
          #
          # @see OpenAI::Models::Beta::ChatKit::SessionCancelParams
          def cancel(session_id, params = {})
            @client.request(
              method: :post,
              path: ["chatkit/sessions/%1$s/cancel", session_id],
              model: OpenAI::Beta::ChatKit::ChatSession,
              options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **params[:request_options].to_h}
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
end
