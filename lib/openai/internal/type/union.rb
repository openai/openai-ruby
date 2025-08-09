# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @example
      #   # `custom_tool_input_format` is a `OpenAI::CustomToolInputFormat`
      #   case custom_tool_input_format
      #   when OpenAI::CustomToolInputFormat::Text
      #     puts(custom_tool_input_format.type)
      #   when OpenAI::CustomToolInputFormat::Grammar
      #     puts(custom_tool_input_format.definition)
      #   else
      #     puts(custom_tool_input_format)
      #   end
      #
      # @example
      #   case custom_tool_input_format
      #   in {type: :text}
      #     # ...
      #   in {type: :grammar, definition: definition, syntax: syntax}
      #     puts(definition)
      #   else
      #     puts(custom_tool_input_format)
      #   end
      module Union
        include OpenAI::Internal::Type::Converter
        include OpenAI::Internal::Util::SorbetRuntimeSupport

        # @api private
        #
        # All of the specified variant info for this union.
        #
        # @return [Array<Array(Symbol, Proc, Hash{Symbol=>Object})>]
        private def known_variants = (@known_variants ||= [])

        # @api private
        #
        # @return [Array<Array(Symbol, Object, Hash{Symbol=>Object})>]
        protected def derefed_variants
          known_variants.map { |key, variant_fn, meta| [key, variant_fn.call, meta] }
        end

        # All of the specified variants for this union.
        #
        # @return [Array<Object>]
        def variants = derefed_variants.map { _2 }

        # @api private
        #
        # @param property [Symbol]
        private def discriminator(property)
          case property
          in Symbol
            @discriminator = property
          end
        end

        # @api private
        #
        # @param key [Symbol, Hash{Symbol=>Object}, Proc, OpenAI::Internal::Type::Converter, Class]
        #
        # @param spec [Hash{Symbol=>Object}, Proc, OpenAI::Internal::Type::Converter, Class] .
        #
        #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
        #
        #   @option spec [Proc] :enum
        #
        #   @option spec [Proc] :union
        #
        #   @option spec [Boolean] :"nil?"
        private def variant(key, spec = nil)
          meta = OpenAI::Internal::Type::Converter.meta_info(nil, spec)
          variant_info =
            case key
            in Symbol
              [key, OpenAI::Internal::Type::Converter.type_info(spec), meta]
            in Proc | OpenAI::Internal::Type::Converter | Class | Hash
              [nil, OpenAI::Internal::Type::Converter.type_info(key), meta]
            end

          known_variants << variant_info
        end

        # @api private
        #
        # @param value [Object]
        #
        # @return [OpenAI::Internal::Type::Converter, Class, nil]
        private def resolve_variant(value)
          case [@discriminator, value]
          in [_, OpenAI::Internal::Type::BaseModel]
            value.class
          in [Symbol, Hash]
            key = value.fetch(@discriminator) do
              value.fetch(@discriminator.to_s, OpenAI::Internal::OMIT)
            end

            return nil if key == OpenAI::Internal::OMIT

            key = key.to_sym if key.is_a?(String)
            _, found = known_variants.find { |k,| k == key }
            found&.call
          else
            nil
          end
        end

        # rubocop:disable Style/HashEachMethods
        # rubocop:disable Style/CaseEquality

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def ===(other)
          known_variants.any? do |_, variant_fn|
            variant_fn.call === other
          end
        end

        # @api public
        #
        # @param other [Object]
        #
        # @return [Boolean]
        def ==(other)
          OpenAI::Internal::Type::Union === other && other.derefed_variants == derefed_variants
        end

        # @api public
        #
        # @return [Integer]
        def hash = variants.hash

        # @api private
        #
        # Tries to efficiently coerce the given value to one of the known variants.
        #
        # If the value cannot match any of the known variants, the coercion is considered
        # non-viable and returns the original value.
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
          if (target = resolve_variant(value))
            return OpenAI::Internal::Type::Converter.coerce(target, value, state: state)
          end

          strictness = state.fetch(:strictness)
          exactness = state.fetch(:exactness)

          alternatives = []
          known_variants.each do |_, variant_fn|
            target = variant_fn.call
            exact = state[:exactness] = {yes: 0, no: 0, maybe: 0}
            state[:branched] += 1

            coerced = OpenAI::Internal::Type::Converter.coerce(target, value, state: state)
            yes, no, maybe = exact.values
            if (no + maybe).zero? || (!strictness && yes.positive?)
              exact.each { exactness[_1] += _2 }
              state[:exactness] = exactness
              return coerced
            elsif maybe.positive?
              alternatives << [[-yes, -maybe, no], exact, coerced]
            end
          end

          case alternatives.sort_by!(&:first)
          in []
            exactness[:no] += 1
            state[:error] = ArgumentError.new("no matching variant for #{value.inspect}")
            value
          in [[_, exact, coerced], *]
            exact.each { exactness[_1] += _2 }
            coerced
          end
            .tap { state[:exactness] = exactness }
        ensure
          state[:strictness] = strictness
        end

        # @api private
        #
        # @param value [Object]
        #
        # @param state [Hash{Symbol=>Object}] .
        #
        #   @option state [Boolean] :can_retry
        #
        # @return [Object]
        def dump(value, state:)
          if (target = resolve_variant(value))
            return OpenAI::Internal::Type::Converter.dump(target, value, state: state)
          end

          known_variants.each do
            target = _2.call
            return OpenAI::Internal::Type::Converter.dump(target, value, state: state) if target === value
          end

          super
        end

        # @api private
        #
        # @return [Object]
        def to_sorbet_type
          types = variants.map { OpenAI::Internal::Util::SorbetRuntimeSupport.to_sorbet_type(_1) }.uniq
          case types
          in []
            T.noreturn
          in [type]
            type
          else
            T.any(*types)
          end
        end

        # rubocop:enable Style/CaseEquality
        # rubocop:enable Style/HashEachMethods

        # @api private
        #
        # @param depth [Integer]
        #
        # @return [String]
        def inspect(depth: 0)
          if depth.positive?
            return is_a?(Module) ? super() : self.class.name
          end

          members = variants.map { OpenAI::Internal::Type::Converter.inspect(_1, depth: depth.succ) }
          prefix = is_a?(Module) ? name : self.class.name

          "#{prefix}[#{members.join(' | ')}]"
        end
      end
    end
  end
end
