# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # A value from among a specified list of options. OpenAPI enum values map to Ruby
      #   values in the SDK as follows:
      #
      #   1. boolean => true | false
      #   2. integer => Integer
      #   3. float => Float
      #   4. string => Symbol
      #
      #   We can therefore convert string values to Symbols, but can't convert other
      #   values safely.
      #
      # @example
      #   # `chat_model` is a `OpenAI::Models::ChatModel`
      #   case chat_model
      #   when OpenAI::Models::ChatModel::O3_MINI
      #     # ...
      #   when OpenAI::Models::ChatModel::O3_MINI_2025_01_31
      #     # ...
      #   when OpenAI::Models::ChatModel::O1
      #     # ...
      #   else
      #     puts(chat_model)
      #   end
      #
      # @example
      #   case chat_model
      #   in :"o3-mini"
      #     # ...
      #   in :"o3-mini-2025-01-31"
      #     # ...
      #   in :o1
      #     # ...
      #   else
      #     puts(chat_model)
      #   end
      module Enum
        include OpenAI::Internal::Type::Converter

        # All of the valid Symbol values for this enum.
        #
        # @return [Array<NilClass, Boolean, Integer, Float, Symbol>]
        def values = (@values ||= constants.map { const_get(_1) })

        # @api private
        #
        # Guard against thread safety issues by instantiating `@values`.
        private def finalize! = values

        # @param other [Object]
        #
        # @return [Boolean]
        def ===(other) = values.include?(other)

        # @param other [Object]
        #
        # @return [Boolean]
        def ==(other)
          other.is_a?(Module) && other.singleton_class <= OpenAI::Enum && other.values.to_set == values.to_set
        end

        # @api private
        #
        # Unlike with primitives, `Enum` additionally validates that the value is a member
        #   of the enum.
        #
        # @param value [String, Symbol, Object]
        #
        # @param state [Hash{Symbol=>Object}] .
        #
        #   @option state [Boolean, :strong] :strictness
        #
        #   @option state [Hash{Symbol=>Object}] :exactness
        #
        #   @option state [Integer] :branched
        #
        # @return [Symbol, Object]
        def coerce(value, state:)
          exactness = state.fetch(:exactness)
          val = value.is_a?(String) ? value.to_sym : value

          if values.include?(val)
            exactness[:yes] += 1
            val
          else
            exactness[values.first&.class == val.class ? :maybe : :no] += 1
            value
          end
        end

        # @!parse
        #   # @api private
        #   #
        #   # @param value [Symbol, Object]
        #   #
        #   # @return [Symbol, Object]
        #   def dump(value) = super
      end
    end
  end
end
