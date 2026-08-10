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
        attr_reader :_request_id

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
        # @param headers [Hash{String=>String}]
        # @param page_data [Object]
        def initialize(client:, req:, headers:, page_data:)
          @client = client
          @req = req
          @model = req.fetch(:model)
          @_request_id = headers["x-request-id"]
          super()
        end

        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end
