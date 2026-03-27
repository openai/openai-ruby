# typed: strong

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # This module provides a base implementation for paginated responses in the SDK.
      module BasePage
        Elem = type_member(:out)

        # The ID of the API request, returned via the `x-request-id` response
        # header. This is only populated on top-level response objects returned
        # by the client.
        sig { returns(T.nilable(String)) }
        def _request_id
        end

        # The normalized HTTP response headers for this page.
        sig { returns(T::Hash[String, String]) }
        def response_headers
        end

        sig { overridable.returns(T::Boolean) }
        def next_page?
        end

        sig { overridable.returns(T.self_type) }
        def next_page
        end

        sig { overridable.params(blk: T.proc.params(arg0: Elem).void).void }
        def auto_paging_each(&blk)
        end

        sig { returns(T::Enumerable[Elem]) }
        def to_enum
        end

        # @api private
        sig do
          params(
            client: OpenAI::Internal::Transport::BaseClient,
            req: OpenAI::Internal::Transport::BaseClient::RequestComponents,
            headers: T::Hash[String, String],
            page_data: T.anything
          ).void
        end
        def initialize(client:, req:, headers:, page_data:)
        end
      end
    end
  end
end
