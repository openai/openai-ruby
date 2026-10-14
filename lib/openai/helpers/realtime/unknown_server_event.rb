# frozen_string_literal: true

module OpenAI
  module Realtime
    # A valid JSON event whose discriminator is newer than this SDK version.
    class UnknownServerEvent
      # @return [Symbol]
      attr_reader :type

      # @return [Hash{Symbol=>Object}]
      attr_reader :data

      # @api private
      def initialize(data:)
        value = data.fetch(:type)
        unless value.is_a?(String) || value.is_a?(Symbol)
          raise ArgumentError, "Realtime server event type must be a string or symbol"
        end

        @type = value.to_sym
        @data = freeze_json(data)
        freeze
      end

      # @return [Hash{Symbol=>Object}]
      def to_h = @data

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
