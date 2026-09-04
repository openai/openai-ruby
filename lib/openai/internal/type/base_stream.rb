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

        # The ID of the API request, returned via the x-request-id response
        # header.
        #
        # @api public
        #
        # @return [String, nil]
        def _request_id = last_response.request_id

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

        # Attach request lifecycle logging without changing the stream's identity.
        #
        # @api private
        #
        # @param context [OpenAI::Internal::Logging::Context]
        # @param response [OpenAI::HTTPClient::Response]
        # @return [self]
        def observe(context:, response:)
          source = @iterator
          @iterator = OpenAI::Internal::Util.chain_fused(source) do |yielder|
            loop do
              event = begin
                source.next
              rescue StopIteration
                context.completed(response)
                break
              rescue StandardError => e
                context.request_failed(e)
                raise
              end

              yielder << event
            end
          end

          self
        end

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
