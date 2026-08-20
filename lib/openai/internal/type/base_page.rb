# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @generic Elem
      #
      # This module provides a base implementation for paginated responses in the SDK.
      module BasePage
        # rubocop:disable Lint/UnusedMethodArgument

        # The ID of the API request, returned via the `x-request-id` response
        # header. This is only populated on top-level response objects returned
        # by the client.
        #
        # @api public
        #
        # @return [String, nil]
        def _request_id = last_response.request_id

        # Metadata from the HTTP response that produced this page.
        #
        # @api public
        #
        # @return [OpenAI::ResponseMetadata]
        attr_reader :last_response

        # @api public
        #
        # @return [Boolean]
        def next_page? = (raise NotImplementedError)

        # @api public
        #
        # @raise [OpenAI::Errors::APIError]
        # @return [self]
        def next_page = (raise NotImplementedError)

        # @api public
        #
        # @param blk [Proc]
        #
        # @yieldparam [generic<Elem>]
        # @return [void]
        def auto_paging_each(&blk) = (raise NotImplementedError)

        # @return [Enumerable<generic<Elem>>]
        def to_enum = super(:auto_paging_each)

        alias_method :enum_for, :to_enum

        # @api private
        #
        # @param client [OpenAI::Internal::Transport::BaseClient]
        # @param req [Hash{Symbol=>Object}]
        # @param response_metadata [OpenAI::ResponseMetadata]
        # @param page_data [Object]
        def initialize(client:, req:, response_metadata:, page_data:)
          options = req[:options].to_h
          query = OpenAI::Internal::Util
            .deep_merge(req[:query].to_h, options[:extra_query].to_h)
            .to_h { |key, value| [key == "after" ? :after : key, value] }

          @client = client
          # Keep the effective query with a canonical cursor key, but clear its
          # higher-precedence copy so a page can replace the caller's original cursor.
          @req = {
            **req,
            query: query,
            options: {**options, extra_query: {}}
          }
          @model = req.fetch(:model)
          @last_response = response_metadata
          super()
        end

        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end
