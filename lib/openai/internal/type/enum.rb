# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # A value from among a specified list of options. OpenAPI enum values map to Ruby
      # values in the SDK as follows:
      #
      # 1. boolean => true | false
      # 2. integer => Integer
      # 3. float => Float
      # 4. string => Symbol
      #
      # We can therefore convert string values to Symbols, but can't convert other
      # values safely.
      #
      # @example
      #   # `chat_model` is a `OpenAI::Models::ChatModel`
      #   case chat_model
      #   when OpenAI::Models::ChatModel::GPT_4_1
      #     # ...
      #   when OpenAI::Models::ChatModel::GPT_4_1_MINI
      #     # ...
      #   when OpenAI::Models::ChatModel::GPT_4_1_NANO
      #     # ...
      #   else
      #     puts(chat_model)
      #   end
      #
      # @example
      #   case chat_model
      #   in :"gpt-4.1"
      #     # ...
      #   in :"gpt-4.1-mini"
      #     # ...
      #   in :"gpt-4.1-nano"
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
          # rubocop:disable Style/CaseEquality
          OpenAI::Internal::Type::Enum === other && other.values.to_set == values.to_set
          # rubocop:enable Style/CaseEquality
        end

        # @api private
        #
        # Unlike with primitives, `Enum` additionally validates that the value is a member
        # of the enum.
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
        #   # @param state [Hash{Symbol=>Object}] .
        #   #
        #   #   @option state [Boolean] :can_retry
        #   #
        #   # @return [Symbol, Object]
        #   def dump(value, state:) = super

        # @api private
        #
        # @param depth [Integer]
        #
        # @return [String]
        def inspect(depth: 0)
          return super() if depth.positive?

          members = values.map { OpenAI::Internal::Type::Converter.inspect(_1, depth: depth.succ) }
          prefix = is_a?(Module) ? name : self.class.name

          "#{prefix}[#{members.join(' | ')}]"
        end
      end
    end
  end
end
