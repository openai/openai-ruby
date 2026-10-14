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
        extend OpenAI::Internal::Util::SorbetRuntimeSupport

        # rubocop:disable Lint/UnusedMethodArgument

        private_class_method :new

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def self.===(other) = true

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def self.==(other) = other.is_a?(Class) && other <= OpenAI::Internal::Type::Unknown

        class << self
          # @api private
          #
          # No coercion needed for Unknown type.
          #
          # @param value [Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean] :translate_names
          #
          #   @option state [Boolean] :strictness
          #
          #   @option state [Hash{Symbol=>Object}] :exactness
          #
          #   @option state [Class<StandardError>] :error
          #
          #   @option state [Integer] :branched
          #
          # @return [Object]
          def coerce(value, state:)
            state.fetch(:exactness)[:yes] += 1
            value
          end

          # @api private
          #
          # Traverse arbitrary JSON containers without consuming the Ruby stack.
          # Delegate model, file, and scalar conversion to the existing converter.
          #
          # @param value [Object]
          #
          # @param state [Hash{Symbol=>Object}] .
          #
          #   @option state [Boolean] :can_retry
          #
          # @return [Object]
          def dump(value, state:)
            return super unless value.is_a?(Hash) || value.is_a?(Array)

            result = value.is_a?(Hash) ? {} : []
            copies = {}.compare_by_identity
            copies[value] = result
            pending = [[value, result]]
            until pending.empty?
              source, destination = pending.pop
              entries = source.is_a?(Hash) ? source.each_pair : source.each_with_index.lazy.map { |item, i| [i, item] }
              entries.each do |key, item|
                if item.is_a?(Hash) || item.is_a?(Array)
                  unless copies.key?(item)
                    copies[item] = item.is_a?(Hash) ? {} : []
                    pending << [item, copies.fetch(item)]
                  end

                  destination[key] = copies.fetch(item)
                else
                  destination[key] = super(item, state: state)
                end
              end
            end

            result
          end

          # @api private
          #
          # @return [Object]
          def to_sorbet_type
            T.anything
          end
        end

        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end
