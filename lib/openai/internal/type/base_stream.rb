# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @generic Elem
      #
      # This module provides a base implementation for streaming responses in the SDK.
      #
      # @see https://rubyapi.org/3.3/o/enumerable
      module BaseStream
        include Enumerable

        # @return [Integer]
        def status = last_response.status

        # @return [Hash{String=>String}]
        def headers = last_response.headers

        # Metadata from the HTTP response that opened this stream.
        #
        # @api public
        #
        # @return [OpenAI::ResponseMetadata]
        attr_reader :last_response

        # @api public
        #
        # @return [void]
        def close = OpenAI::Internal::Util.close_fused!(@iterator)

        # @api private
        #
        # @return [Enumerable<generic<Elem>>]
        private def iterator = (raise NotImplementedError)

        # @api public
        #
        # @param blk [Proc]
        #
        # @yieldparam [generic<Elem>]
        # @return [void]
        def each(&blk)
          unless block_given?
            raise ArgumentError.new("A block must be given to ##{__method__}")
          end
          @iterator.each(&blk)
        end

        # @api public
        #
        # @return [Enumerator<generic<Elem>>]
        def to_enum = @iterator

        alias_method :enum_for, :to_enum

        # @api private
        #
        # @param model [Class, OpenAI::Internal::Type::Converter]
        # @param url [URI::Generic]
        # @param response_metadata [OpenAI::ResponseMetadata]
        # @param response [OpenAI::HTTPClient::Response]
        # @param unwrap [Symbol, Integer, Array<Symbol, Integer>, Proc]
        # @param stream [Enumerable<Object>]
        def initialize(model:, url:, response_metadata:, response:, unwrap:, stream:)
          @model = model
          @url = url
          @last_response = response_metadata
          @response = response
          @unwrap = unwrap
          @stream = stream
          @iterator = iterator
        end

        # @api private
        #
        # @return [String]
        def inspect
          model = OpenAI::Internal::Type::Converter.inspect(@model, depth: 1)

          "#<#{self.class}[#{model}]:0x#{object_id.to_s(16)}>"
        end
      end
    end
  end
end
