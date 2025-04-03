# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @abstract
      #
      # When we don't know what to expect for the value.
      class Unknown
        extend OpenAI::Internal::Type::Converter

        # rubocop:disable Lint/UnusedMethodArgument

        # @param other [Object]
        #
        # @return [Boolean]
        def self.===(other) = true

        # @param other [Object]
        #
        # @return [Boolean]
        def self.==(other) = other.is_a?(Class) && other <= OpenAI::Unknown

        class << self
          # @api private
          #
          # @param value [Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean, :strong] :strictness
          #
          #   @option state [Hash{Symbol=>Object}] :exactness
          #
          #   @option state [Integer] :branched
          #
          # @return [Object]
          def coerce(value, state:)
            state.fetch(:exactness)[:yes] += 1
            value
          end

          # @!parse
          #   # @api private
          #   #
          #   # @param value [Object]
          #   #
          #   # @return [Object]
          #   def dump(value) = super
        end

        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end
