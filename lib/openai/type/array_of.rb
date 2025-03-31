# frozen_string_literal: true

module OpenAI
  module Type
    # @api private
    #
    # @abstract
    #
    # Array of items of a given type.
    class ArrayOf
      include OpenAI::Type::Converter

      # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Type::Converter, Class]
      #
      # @param spec [Hash{Symbol=>Object}] .
      #
      #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
      #
      #   @option spec [Proc] :enum
      #
      #   @option spec [Proc] :union
      #
      #   @option spec [Boolean] :"nil?"
      def self.[](type_info, spec = {}) = new(type_info, spec)

      # @param other [Object]
      #
      # @return [Boolean]
      def ===(other) = other.is_a?(Array) && other.all?(item_type)

      # @param other [Object]
      #
      # @return [Boolean]
      def ==(other) = other.is_a?(OpenAI::ArrayOf) && other.nilable? == nilable? && other.item_type == item_type

      # @api private
      #
      # @param value [Enumerable, Object]
      #
      # @param state [Hash{Symbol=>Object}] .
      #
      #   @option state [Boolean, :strong] :strictness
      #
      #   @option state [Hash{Symbol=>Object}] :exactness
      #
      #   @option state [Integer] :branched
      #
      # @return [Array<Object>, Object]
      def coerce(value, state:)
        exactness = state.fetch(:exactness)

        unless value.is_a?(Array)
          exactness[:no] += 1
          return value
        end

        target = item_type
        exactness[:yes] += 1
        value
          .map do |item|
            case [nilable?, item]
            in [true, nil]
              exactness[:yes] += 1
              nil
            else
              OpenAI::Type::Converter.coerce(target, item, state: state)
            end
          end
      end

      # @api private
      #
      # @param value [Enumerable, Object]
      #
      # @return [Array<Object>, Object]
      def dump(value)
        target = item_type
        value.is_a?(Array) ? value.map { OpenAI::Type::Converter.dump(target, _1) } : super
      end

      # @api private
      #
      # @return [OpenAI::Type::Converter, Class]
      protected def item_type = @item_type_fn.call

      # @api private
      #
      # @return [Boolean]
      protected def nilable? = @nilable

      # @api private
      #
      # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Type::Converter, Class]
      #
      # @param spec [Hash{Symbol=>Object}] .
      #
      #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
      #
      #   @option spec [Proc] :enum
      #
      #   @option spec [Proc] :union
      #
      #   @option spec [Boolean] :"nil?"
      def initialize(type_info, spec = {})
        @item_type_fn = OpenAI::Type::Converter.type_info(type_info || spec)
        @nilable = spec[:nil?]
      end
    end
  end
end
