# frozen_string_literal: true

require "digest"

module OpenAI
  module Internal
    # Derives request options for the individual writes in a composite helper.
    #
    # A caller-supplied idempotency key names the composite operation. Each child
    # write receives a deterministic derived key so its retries remain stable
    # without colliding with another write in the same operation. Structured keys
    # are materialized as the standard header; an explicit header remains authoritative.
    #
    # @api private
    class RequestOptionsScope
      IDEMPOTENCY_HEADER = "Idempotency-Key"
      private_constant :IDEMPOTENCY_HEADER

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
        derived_key = derive(key, operation) unless key.nil?
        options[:idempotency_key] = derived_key unless derived_key.nil?

        headers = options[:extra_headers].to_h
        header = headers.keys.reverse.find { _1.to_s.casecmp?(IDEMPOTENCY_HEADER) }
        header_key = headers[header] unless header.nil?
        if header.nil?
          options[:extra_headers] = headers.merge(IDEMPOTENCY_HEADER => derived_key) unless derived_key.nil?
        elsif !header_key.nil?
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
