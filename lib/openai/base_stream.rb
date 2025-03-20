# frozen_string_literal: true

module OpenAI
  # @example
  #   stream.each do |chunk|
  #     puts(chunk)
  #   end
  #
  # @example
  #   chunks =
  #     stream
  #     .lazy
  #     .select { _1.object_id.even? }
  #     .map(&:itself)
  #     .take(2)
  #     .to_a
  #
  #   chunks => Array
  module BaseStream
    include Enumerable

    # @return [void]
    def close = OpenAI::Util.close_fused!(@iterator)

    # @api private
    #
    # @return [Enumerable]
    private def iterator = (raise NotImplementedError)

    # @param blk [Proc]
    #
    # @return [void]
    def each(&)
      unless block_given?
        raise ArgumentError.new("A block must be given to ##{__method__}")
      end
      @iterator.each(&)
    end

    # @return [Enumerator]
    def to_enum = @iterator

    alias_method :enum_for, :to_enum

    # @api private
    #
    # @param model [Class, OpenAI::Converter]
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
