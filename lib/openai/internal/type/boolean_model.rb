# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @abstract
      #
      # Ruby has no Boolean class; this is something for models to refer to.
      class Boolean
        extend OpenAI::Internal::Type::Converter

        # @param other [Object]
        #
        # @return [Boolean]
        def self.===(other) = other == true || other == false

        # @param other [Object]
        #
        # @return [Boolean]
        def self.==(other) = other.is_a?(Class) && other <= OpenAI::Internal::Type::Boolean

        class << self
          # @api private
          #
          # @param value [Boolean, Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean, :strong] :strictness
          #
          #   @option state [Hash{Symbol=>Object}] :exactness
          #
          #   @option state [Integer] :branched
          #
          # @return [Boolean, Object]
          def coerce(value, state:)
            state.fetch(:exactness)[value == true || value == false ? :yes : :no] += 1
            value
          end

          # @!parse
          #   # @api private
          #   #
          #   # @param value [Boolean, Object]
          #   #
          #   # @return [Boolean, Object]
          #   def dump(value) = super
        end
      end
    end
  end
end
