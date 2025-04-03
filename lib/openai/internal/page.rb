# frozen_string_literal: true

module OpenAI
  module Internal
    # @example
    #   if page.has_next?
    #     page = page.next_page
    #   end
    #
    # @example
    #   page.auto_paging_each do |model|
    #     puts(model)
    #   end
    #
    # @example
    #   models =
    #     page
    #     .to_enum
    #     .lazy
    #     .select { _1.object_id.even? }
    #     .map(&:itself)
    #     .take(2)
    #     .to_a
    #
    #   models => Array
    class Page
      include OpenAI::Internal::Type::BasePage

      # @return [Array<Object>, nil]
      attr_accessor :data

      # @return [String]
      attr_accessor :object

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::BaseClient]
      # @param req [Hash{Symbol=>Object}]
      # @param headers [Hash{String=>String}, Net::HTTPHeader]
      # @param page_data [Array<Object>]
      def initialize(client:, req:, headers:, page_data:)
        super
        model = req.fetch(:model)

        case page_data
        in {data: Array | nil => data}
          @data = data&.map { OpenAI::Internal::Type::Converter.coerce(model, _1) }
        else
        end

        case page_data
        in {object: String => object}
          @object = object
        else
        end
      end

      # @return [Boolean]
      def next_page?
        false
      end

      # @raise [OpenAI::HTTP::Error]
      # @return [OpenAI::Internal::Page]
      def next_page
        RuntimeError.new("No more pages available.")
      end

      # @param blk [Proc]
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
      def inspect
        "#<#{self.class}:0x#{object_id.to_s(16)} data=#{data.inspect} object=#{object.inspect}>"
      end
    end
  end
end
