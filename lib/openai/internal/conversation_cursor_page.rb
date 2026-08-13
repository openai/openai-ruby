# frozen_string_literal: true

module OpenAI
  module Internal
    # @generic Elem
    #
    # @example
    #   if conversation_cursor_page.has_next?
    #     conversation_cursor_page = conversation_cursor_page.next_page
    #   end
    #
    # @example
    #   conversation_cursor_page.auto_paging_each do |permission|
    #     puts(permission)
    #   end
    class ConversationCursorPage
      include OpenAI::Internal::Type::BasePage

      # @return [Array<generic<Elem>>, nil]
      attr_accessor :data

      # @return [Boolean]
      attr_accessor :has_more

      # @return [String]
      attr_accessor :last_id

      # @return [Boolean]
      def next_page?
        has_more
      end

      # @raise [OpenAI::HTTP::Error]
      # @return [self]
      def next_page
        unless next_page?
          message = "No more pages available. Please check #next_page? before calling ##{__method__}"
          raise message
        end

        req = OpenAI::Internal::Util.deep_merge(@req, {query: {after: last_id}})
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
          page.data&.each(&blk)

          break unless page.next_page?
          page = page.next_page
        end
      end

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::BaseClient]
      # @param req [Hash{Symbol=>Object}]
      # @param response_metadata [OpenAI::ResponseMetadata]
      # @param page_data [Hash{Symbol=>Object}]
      def initialize(client:, req:, response_metadata:, page_data:)
        super

        case page_data
        in {data: Array => data}
          @data = data.map { OpenAI::Internal::Type::Converter.coerce(@model, _1) }
        else
        end
        @has_more = page_data[:has_more]
        @last_id = page_data[:last_id]
      end

      # @api private
      #
      # @return [String]
      def inspect
        model = OpenAI::Internal::Type::Converter.inspect(@model, depth: 1)

        "#<#{self.class}[#{model}]:0x#{object_id.to_s(16)} has_more=#{has_more.inspect} last_id=#{last_id.inspect}>"
      end
    end
  end
end
