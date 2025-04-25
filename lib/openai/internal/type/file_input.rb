# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @abstract
      #
      # Either `Pathname` or `StringIO`, or `IO`, or
      # `OpenAI::Internal::Type::FileInput`.
      #
      # Note: when `IO` is used, all retries are disabled, since many IO` streams are
      # not rewindable.
      class FileInput
        extend OpenAI::Internal::Type::Converter

        private_class_method :new

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def self.===(other)
          case other
          in Pathname | StringIO | IO | String | OpenAI::FilePart
            true
          else
            false
          end
        end

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def self.==(other) = other.is_a?(Class) && other <= OpenAI::Internal::Type::FileInput

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

          # @api private
          #
          # @param value [Pathname, StringIO, IO, String, Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean] :can_retry
          #
          # @return [Pathname, StringIO, IO, String, Object]
          def dump(value, state:)
            # rubocop:disable Lint/DuplicateBranch
            case value
            in IO
              state[:can_retry] = false
            in OpenAI::FilePart if value.content.is_a?(IO)
              state[:can_retry] = false
            else
            end
            # rubocop:enable Lint/DuplicateBranch

            value
          end
        end
      end
    end
  end
end
