# frozen_string_literal: true

module OpenAI
  module Internal
    # @generic Elem
    #
    # @example
    #   if page.has_next?
    #     page = page.next_page
    #   end
    #
    # @example
    #   page.auto_paging_each do |model|
    #     puts(model)
    #   end
    class Page
      include OpenAI::Internal::Type::BasePage

      # @return [Array<generic<Elem>>, nil]
      attr_accessor :data

      # @return [String]
      attr_accessor :object

      # @return [Boolean]
      def next_page?
        false
      end

      # @raise [OpenAI::HTTP::Error]
      # @return [self]
      def next_page
        RuntimeError.new("No more pages available.")
      end

      # @param blk [Proc]
      #
      # @yieldparam [generic<Elem>]
      def auto_paging_each(&blk)
        unless block_given?
          raise ArgumentError.new("A block must be given to ##{__method__}")
        end

        page = self
        loop do
          page.data&.each(&blk)

          break unless page.next_page?
          page = page.next_page
        end
      end

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::BaseClient]
      # @param req [Hash{Symbol=>Object}]
      # @param headers [Hash{String=>String}, Net::HTTPHeader]
      # @param page_data [Array<Object>]
      def initialize(client:, req:, headers:, page_data:)
        super

        case page_data
        in {data: Array | nil => data}
          @data = data&.map { OpenAI::Internal::Type::Converter.coerce(@model, _1) }
        else
        end
        @object = page_data[:object]
      end

      # @api private
      #
      # @return [String]
      def inspect
        model = OpenAI::Internal::Type::Converter.inspect(@model, depth: 1)

        "#<#{self.class}[#{model}]:0x#{object_id.to_s(16)} object=#{object.inspect}>"
      end
    end
  end
end
