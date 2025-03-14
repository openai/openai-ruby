# frozen_string_literal: true

module OpenAI
  # @example
  # ```ruby
  # stream.for_each do |chunk|
  #   puts(chunk)
  # end
  # ```
  #
  # @example
  # ```ruby
  # chunks = stream
  #   .to_enum
  #   .lazy
  #   .select { _1.object_id.even? }
  #   .map(&:itself)
  #   .take(2)
  #   .to_a
  #
  # chunks => Array
  # ```
  module BaseStream
    # @return [void]
    def close = OpenAI::Util.close_fused!(@iterator)

    # @api private
    #
    # @return [Enumerable]
    private def iterator = (raise NotImplementedError)

    # @param blk [Proc]
    #
    # @return [void]
    def for_each(&)
      unless block_given?
        raise ArgumentError.new("A block must be given to ##{__method__}")
      end
      @iterator.each(&)
    end

    # @return [Enumerable]
    def to_enum = @iterator

    alias_method :enum_for, :to_enum

    # @api private
    #
    # @param model [Class, OpenAI::Converter]
    # @param url [URI::Generic]
    # @param status [Integer]
    # @param response [Net::HTTPResponse]
    # @param messages [Enumerable]
    def initialize(model:, url:, status:, response:, messages:)
      @model = model
      @url = url
      @status = status
      @response = response
      @messages = messages
      @iterator = iterator
    end
  end
end
