# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Translations
        class ClientSecrets
          # Create a short-lived client secret for a Realtime translation session.
          #
          # @param session [OpenAI::Models::Realtime::RealtimeTranslationSessionCreateRequest, Hash]
          # @param expires_after [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter, Hash, nil]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          # @return [OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateResponse]
          def create(session:, expires_after: nil, request_options: nil)
            input = {session: session}
            input[:expires_after] = expires_after unless expires_after.nil?
            state = OpenAI::Internal::Type::Converter.new_coerce_state
            request = OpenAI::Internal::Type::Converter.coerce(
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest,
              input,
              state: state
            )
            cause = state[:error]
            if cause.nil? && !state.fetch(:exactness).fetch(:no).zero?
              cause = ArgumentError.new("request is missing required fields or contains invalid values")
            end
            if cause
              message = "Invalid translation client secret request: #{cause.message}"
              raise ArgumentError.new(message), cause: cause
            end
            body = OpenAI::Internal::Type::Converter.dump(
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest,
              request
            )

            @client.request(
              method: :post,
              path: "realtime/translations/client_secrets",
              body: body,
              model: OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse,
              security: {bearer_auth: true},
              options: request_options
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
