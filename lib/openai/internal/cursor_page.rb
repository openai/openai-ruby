# frozen_string_literal: true

module OpenAI
  module Internal
    # @generic Elem
    #
    # @example
    #   if cursor_page.has_next?
    #     cursor_page = cursor_page.next_page
    #   end
    #
    # @example
    #   cursor_page.auto_paging_each do |completion|
    #     puts(completion)
    #   end
    class CursorPage
      include OpenAI::Internal::Type::BasePage

      # @return [Array<generic<Elem>>, nil]
      attr_accessor :data

      # @return [Boolean]
      attr_accessor :has_more

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::BaseClient]
      # @param req [Hash{Symbol=>Object}]
      # @param headers [Hash{String=>String}, Net::HTTPHeader]
      # @param page_data [Hash{Symbol=>Object}]
      def initialize(client:, req:, headers:, page_data:)
        super
        model = req.fetch(:model)

        case page_data
        in {data: Array | nil => data}
          @data = data&.map { OpenAI::Internal::Type::Converter.coerce(model, _1) }
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
      # @return [OpenAI::Internal::CursorPage]
      def next_page
        unless next_page?
          message = "No more pages available. Please check #next_page? before calling ##{__method__}"
          raise RuntimeError.new(message)
        end

        req = OpenAI::Internal::Util.deep_merge(@req, {query: {after: data&.last&.id}})
        @client.request(req)
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
          page.data&.each { blk.call(_1) }
          break unless page.next_page?
          page = page.next_page
        end
      end

      # @return [String]
      def inspect
        "#<#{self.class}:0x#{object_id.to_s(16)} data=#{data.inspect} has_more=#{has_more.inspect}>"
      end
    end
  end
end
