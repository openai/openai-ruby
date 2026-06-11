# typed: strong

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # This module provides a base implementation for paginated responses in the SDK.
      module BasePage
        Elem = type_member(:out)

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

        sig { returns(T.nilable(T::Hash[String, String])) }
        attr_reader :response_headers
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

        sig { params(headers: T::Hash[String, String]).returns(T.self_type) }
        def __set_response_headers(headers)
        end
      end
    end
  end
end
