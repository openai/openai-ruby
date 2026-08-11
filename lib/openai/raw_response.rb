# frozen_string_literal: true

module OpenAI
  # A successful HTTP response whose body has not yet been decoded into an SDK
  # return type.
  #
  # Raw responses are buffered so callers can inspect the response body and
  # still parse it through the SDK's normal response conversion path.
  #
  # @generic Elem
  class RawResponse
    UNPARSED = Object.new.freeze
    private_constant :UNPARSED

    # @return [Integer]
    attr_reader :status

    # Normalized, immutable HTTP response headers. Header names are lowercase
    # and values are strings.
    #
    # @return [Hash{String=>String}]
    attr_reader :headers

    # The undecoded response body.
    #
    # @return [String]
    attr_reader :body

    # @return [String, nil]
    def request_id = @headers["x-request-id"]

    # Returns a mutable copy of the undecoded response body.
    #
    # @return [String]
    def read = @body.dup

    # Decodes the response through the same conversion path as the ordinary
    # resource method. The result is cached after the first successful parse.
    #
    # @return [Object]
    def parse
      parsed = @parsed
      return parsed unless parsed.equal?(UNPARSED)

      @parse_mutex.synchronize do
        return @parsed unless @parsed.equal?(UNPARSED)

        parsed = @parser.call
        @parsed = parsed
        @parser = nil
        parsed
      end
    end

    # @return [String]
    def inspect
      "#<#{self.class.name}:0x#{object_id.to_s(16)} status=#{@status} body_bytes=#{@body.bytesize}>"
    end

    # @api private
    #
    # @param status [Integer]
    # @param headers [Hash{String=>String}]
    # @param body [String]
    # @param parser [Proc]
    def initialize(status:, headers:, body:, parser:)
      @status = Integer(status)
      @headers = headers.to_h do |name, value|
        [name.to_s.downcase.freeze, value.to_s.dup.freeze]
      end.freeze
      @body = body.frozen? ? body : body.dup.freeze
      @parser = parser
      @parsed = UNPARSED
      @parse_mutex = Mutex.new
    end
  end
end
