# typed: strong

module OpenAI
  module Internal
    module Transport
      # @api private
      module RequestClient
        extend T::Helpers

        interface!

        sig do
          abstract.params(
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents
          ).returns(T.anything)
        end
        def request(req)
        end
      end
    end
  end
end
