# frozen_string_literal: true

module OpenAI
  # @example
  # ```ruby
  # if page.has_next?
  #   page = page.next_page
  # end
  # ```
  #
  # @example
  # ```ruby
  # page.auto_paging_each do |model|
  #   puts(model)
  # end
  # ```
  #
  # @example
  # ```ruby
  # models = page.to_enum.take(2)
  #
  # models => Array
  # ```
  class Page
    include OpenAI::BasePage

    # @return [Array<Object>]
    attr_accessor :data

    # @return [String]
    attr_accessor :object

    # @private
    #
    # @param client [OpenAI::BaseClient]
    # @param req [Hash{Symbol=>Object}]
    # @param headers [Hash{String=>String}, Net::HTTPHeader]
    # @param page_data [Array<Object>]
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
      in {object: String | nil => object}
        @object = object
      else
      end
    end

    # @return [Boolean]
    def next_page?
      false
    end

    # @raise [OpenAI::HTTP::Error]
    # @return [OpenAI::Page]
    #
    def next_page
      RuntimeError.new("No more pages available.")
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
      "#<#{self.class}:0x#{object_id.to_s(16)} data=#{data.inspect} object=#{object.inspect}>"
    end
  end
end
