# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # This module provides a base implementation for streaming responses in the SDK.
      #
      # @see https://rubyapi.org/3.1/o/enumerable
      module BaseStream
        include Enumerable

        # @return [void]
        def close = OpenAI::Internal::Util.close_fused!(@iterator)

        # @api private
        #
        # @return [Enumerable]
        private def iterator = (raise NotImplementedError)

        # @param blk [Proc]
        #
        # @return [void]
        def each(&blk)
          unless block_given?
            raise ArgumentError.new("A block must be given to ##{__method__}")
          end
          @iterator.each(&blk)
        end

        # @return [Enumerator]
        def to_enum = @iterator

        alias_method :enum_for, :to_enum

        # @api private
        #
        # @param model [Class, OpenAI::Internal::Type::Converter]
        # @param url [URI::Generic]
        # @param status [Integer]
        # @param response [Net::HTTPResponse]
        # @param stream [Enumerable]
        def initialize(model:, url:, status:, response:, stream:)
          @model = model
          @url = url
          @status = status
          @response = response
          @stream = stream
          @iterator = iterator
        end
      end
    end
  end
end
