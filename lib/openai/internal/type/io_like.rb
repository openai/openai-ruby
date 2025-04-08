# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @abstract
      #
      # Either `Pathname` or `StringIO`.
      class IOLike
        extend OpenAI::Internal::Type::Converter

        # @param other [Object]
        #
        # @return [Boolean]
        def self.===(other)
          case other
          in StringIO | Pathname | IO
            true
          else
            false
          end
        end

        # @param other [Object]
        #
        # @return [Boolean]
        def self.==(other) = other.is_a?(Class) && other <= OpenAI::Internal::Type::IOLike

        class << self
          # @api private
          #
          # @param value [StringIO, String, Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean, :strong] :strictness
          #
          #   @option state [Hash{Symbol=>Object}] :exactness
          #
          #   @option state [Integer] :branched
          #
          # @return [StringIO, Object]
          def coerce(value, state:)
            exactness = state.fetch(:exactness)
            case value
            in String
              exactness[:yes] += 1
              StringIO.new(value)
            in StringIO
              exactness[:yes] += 1
              value
            else
              exactness[:no] += 1
              value
            end
          end

          # @!parse
          #   # @api private
          #   #
          #   # @param value [Pathname, StringIO, IO, String, Object]
          #   #
          #   # @param state [Hash{Symbol=>Object}] .
          #   #
          #   #   @option state [Boolean] :can_retry
          #   #
          #   # @return [Pathname, StringIO, IO, String, Object]
          #   def dump(value, state:) = super
        end
      end
    end
  end
end
