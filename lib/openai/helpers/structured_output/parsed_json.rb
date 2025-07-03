# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # @abstract
      #
      # Like OpenAI::Internal::Type::Unknown, but for parsed JSON values, which can be incomplete or malformed.
      class ParsedJson < OpenAI::Internal::Type::Unknown
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
            (state[:error] = value) if value.is_a?(StandardError)

            super
          end
        end
      end
    end
  end
end
