# frozen_string_literal: true

require "digest"

module OpenAI
  module Internal
    # Derives request options for the individual writes in a composite helper.
    #
    # A caller-supplied idempotency key names the composite operation. Each child
    # write receives a deterministic derived key so its retries remain stable
    # without colliding with another write in the same operation.
    #
    # @api private
    class RequestOptionsScope
      # @api private
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      def initialize(request_options)
        options = request_options.to_h.dup
        OpenAI::RequestOptions.validate!(options)
        if options.key?(:extra_headers)
          options[:extra_headers] = options[:extra_headers].to_h.dup.freeze
        end
        @options = options.freeze
      end

      # @api private
      #
      # @param operation [String]
      # @return [Hash{Symbol=>Object}]
      def child(operation)
        options = @options.dup
        key = options[:idempotency_key]
        options[:idempotency_key] = derive(key, operation) unless key.nil?

        headers = options[:extra_headers].to_h
        header = headers.keys.reverse.find { _1.to_s.casecmp?("idempotency-key") }
        header_key = header&.then { headers[_1] }
        unless header_key.nil?
          options[:extra_headers] = headers.merge(header => derive(header_key, operation))
        end

        options
      end

      private def derive(key, operation)
        digest = Digest::SHA256.hexdigest("#{key}\0#{operation}")
        "stainless-ruby-#{digest}"
      end
    end
  end
end
