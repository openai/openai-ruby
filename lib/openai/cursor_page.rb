# frozen_string_literal: true

module OpenAI
  # @example
  # ```ruby
  # if cursor_page.has_next?
  #   cursor_page = cursor_page.next_page
  # end
  # ```
  #
  # @example
  # ```ruby
  # cursor_page.auto_paging_each do |completion|
  #   puts(completion)
  # end
  # ```
  #
  # @example
  # ```ruby
  # completions = cursor_page.to_enum.take(2)
  #
  # completions => Array
  # ```
  class CursorPage
    include OpenAI::BasePage

    # @return [Array<Object>]
    attr_accessor :data

    # @return [Boolean]
    attr_accessor :has_more

    # @private
    #
    # @param client [OpenAI::BaseClient]
    # @param req [Hash{Symbol=>Object}]
    # @param headers [Hash{String=>String}, Net::HTTPHeader]
    # @param page_data [Hash{Symbol=>Object}]
    #
    def initialize(client:, req:, headers:, page_data:)
      super
      model = req.fetch(:model)

      case page_data
      in {data: Array | nil => data}
        @data = data&.map { model.coerce(_1) }
      else
      end

      case page_data
      in {has_more: true | false | nil => has_more}
        @has_more = has_more
      else
      end
    end

    # @return [Boolean]
    def next_page?
      has_more
    end

    # @raise [OpenAI::HTTP::Error]
    # @return [OpenAI::CursorPage]
    #
    def next_page
      unless next_page?
        raise RuntimeError.new("No more pages available. Please check #next_page? before calling ##{__method__}")
      end

      req = OpenAI::Util.deep_merge(@req, {query: {after: data&.last&.id}})
      @client.request(req)
    end

    # @param blk [Proc]
    #
    def auto_paging_each(&blk)
      unless block_given?
        raise ArgumentError.new("A block must be given to ##{__method__}")
      end
      page = self
      loop do
        page.data&.each { blk.call(_1) }
        break unless page.next_page?
        page = page.next_page
      end
    end

    # @return [String]
    #
    def inspect
      "#<#{self.class}:0x#{object_id.to_s(16)} data=#{data.inspect} has_more=#{has_more.inspect}>"
    end
  end
end
