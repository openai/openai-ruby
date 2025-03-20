# frozen_string_literal: true

module OpenAI
  # @example
  #   if page.has_next?
  #     page = page.next_page
  #   end
  #
  # @example
  #   page.auto_paging_each do |completion|
  #     puts(completion)
  #   end
  #
  # @example
  #   completions =
  #     page
  #     .to_enum
  #     .lazy
  #     .select { _1.object_id.even? }
  #     .map(&:itself)
  #     .take(2)
  #     .to_a
  #
  #   completions => Array
  module BasePage
    # rubocop:disable Lint/UnusedMethodArgument

    # @return [Boolean]
    def next_page? = (raise NotImplementedError)

    # @raise [OpenAI::APIError]
    # @return [OpenAI::BasePage]
    def next_page = (raise NotImplementedError)

    # @param blk [Proc]
    #
    # @return [void]
    def auto_paging_each(&) = (raise NotImplementedError)

    # @return [Enumerable]
    def to_enum = super(:auto_paging_each)

    alias_method :enum_for, :to_enum

    # @api private
    #
    # @param client [OpenAI::BaseClient]
    # @param req [Hash{Symbol=>Object}]
    # @param headers [Hash{String=>String}, Net::HTTPHeader]
    # @param page_data [Object]
    def initialize(client:, req:, headers:, page_data:)
      @client = client
      @req = req
      super()
    end

    # rubocop:enable Lint/UnusedMethodArgument
  end
end
