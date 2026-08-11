# typed: strong

module OpenAI
  module Internal
    module Transport
      # @api private
      class RawResponseClient
        include OpenAI::Internal::Transport::RequestClient

        sig { params(client: OpenAI::Internal::Transport::BaseClient).void }
        def initialize(client)
        end

        sig do
          override.params(
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents
          ).returns(OpenAI::RawResponse[T.anything])
        end
        def request(req)
        end
      end
    end
  end
end
