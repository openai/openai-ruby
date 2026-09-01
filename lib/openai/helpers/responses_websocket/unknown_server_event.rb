# frozen_string_literal: true

module OpenAI
  module Responses
    # A valid JSON event whose discriminator is newer than this SDK version.
    class UnknownServerEvent
      # @return [Symbol]
      attr_reader :type

      # @return [Hash{Symbol=>Object}]
      attr_reader :data

      # @return [Object]
      attr_reader :stream_id

      # @api private
      def initialize(data:)
        value = data.fetch(:type)
        unless value.is_a?(String) || value.is_a?(Symbol)
          raise ArgumentError, "Responses server event type must be a string or symbol"
        end

        @type = value.to_sym
        @stream_id = data[:stream_id]
        @data = freeze_json(data)
        freeze
      end

      # @return [Hash{Symbol=>Object}]
      def to_h = @data

      # Keep routine diagnostics payload-free. Callers that explicitly need the
      # unknown JSON can use {#data} or {#to_h}.
      def inspect = "#<#{self.class} type=#{@type.inspect}>"

      alias to_s inspect

      private def freeze_json(value)
        case value
        when Hash
          value.each do |key, item|
            freeze_json(key)
            freeze_json(item)
          end

        when Array
          value.each { |item| freeze_json(item) }
        end

        value.freeze
      end
    end
  end
end
