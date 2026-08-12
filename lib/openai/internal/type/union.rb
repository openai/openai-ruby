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
          case value
          in OpenAI::Internal::Type::BaseModel
            value.class
          else
            key = discriminator_value(value)
            return nil if key == OpenAI::Internal::OMIT || key.nil?

            keyed_matches = known_variants.select { |known_key,| known_key == key }
            return keyed_matches.fetch(0).fetch(1).call if keyed_matches.one?
            return nil if keyed_matches.any?

            unkeyed_matches = known_variants.select do |known_key, variant_fn|
              known_key.nil? && variant_discriminator_matches?(variant_fn.call, key)
            end
            unkeyed_matches.fetch(0).fetch(1).call if unkeyed_matches.one?
          end
        end

        # @api private
        #
        # @param value [Object]
        #
        # @return [Object]
        private def discriminator_value(value)
          case [@discriminator, value]
          in [Symbol, Hash]
            key = value.fetch(@discriminator) do
              value.fetch(@discriminator.to_s, OpenAI::Internal::OMIT)
            end
            key.is_a?(String) ? key.to_sym : key
          else
            OpenAI::Internal::OMIT
          end
        end

        # @api private
        #
        # Missing and nil discriminators retain structural inference for generated
        # variants whose discriminator field is optional or nullable. Duplicate keyed
        # variants are compared structurally. A present but unknown discriminator tries
        # explicit unkeyed variants before preserving the original value.
        #
        # @param discriminator [Object]
        #
        # @return [Array<Array(Symbol, Proc, Hash{Symbol=>Object})>]
        private def fallback_variants(discriminator)
          return known_variants if discriminator == OpenAI::Internal::OMIT || discriminator.nil?

          keyed_variants = known_variants.select { |known_key,| known_key == discriminator }
          return keyed_variants unless keyed_variants.empty?

          unknown = [nil, -> { OpenAI::Internal::Type::Unknown }, {}]
          known_variants.select { |known_key,| known_key.nil? }.append(unknown)
        end

        # rubocop:disable Style/HashEachMethods
        # rubocop:disable Style/CaseEquality

        # @api private
        #
        # Some generated variants are unkeyed because one model accepts discriminator
        # values through an enum. Resolve recognized values without structurally matching
        # those models against genuinely unknown discriminator values.
        #
        # @param target [Object]
        #
        # @param discriminator [Object]
        #
        # @return [Boolean]
        private def variant_discriminator_matches?(target, discriminator)
          return false unless target.is_a?(Class) && target <= OpenAI::Internal::Type::BaseModel

          field = target.known_fields.values.find { _1.fetch(:api_name) == @discriminator }
          return false unless field

          field.fetch(:type_fn).call === discriminator
        end

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
          strictness = state.fetch(:strictness)
          if (target = resolve_variant(value))
            return OpenAI::Internal::Type::Converter.coerce(target, value, state: state)
          end

          exactness = state.fetch(:exactness)
          discriminator = discriminator_value(value)

          alternatives = []
          fallback_variants(discriminator).each do |_, variant_fn|
            target = variant_fn.call
            exact = state[:exactness] = {yes: 0, no: 0, maybe: 0}
            state[:branched] += 1

            coerced, error =
              OpenAI::Internal::Type::Converter.coerce_with_error(target, value, state: state)
            yes, no, maybe = exact.values
            if (no + maybe).zero? || (!strictness && yes.positive?)
              exact.each { exactness[_1] += _2 }
              state[:exactness] = exactness
              state[:error] = error
              return coerced
            elsif maybe.positive?
              alternatives << [[-yes, -maybe, no], exact, coerced, error]
            end
          end

          case alternatives.sort_by!(&:first)
          in []
            exactness[:no] += 1
            state[:error] = ArgumentError.new("no matching variant for #{value.inspect}")
            value
          in [[_, exact, coerced, error], *]
            exact.each { exactness[_1] += _2 }
            state[:error] = error
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
