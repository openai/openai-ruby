# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # @api private
      #
      # @example
      #   # `chat_completion_content_part` is a `OpenAI::Models::Chat::ChatCompletionContentPart`
      #   case chat_completion_content_part
      #   when OpenAI::Models::Chat::ChatCompletionContentPartText
      #     puts(chat_completion_content_part.text)
      #   when OpenAI::Models::Chat::ChatCompletionContentPartImage
      #     puts(chat_completion_content_part.image_url)
      #   when OpenAI::Models::Chat::ChatCompletionContentPartInputAudio
      #     puts(chat_completion_content_part.input_audio)
      #   else
      #     puts(chat_completion_content_part)
      #   end
      #
      # @example
      #   case chat_completion_content_part
      #   in {type: :text, text: text}
      #     puts(text)
      #   in {type: :image_url, image_url: image_url}
      #     puts(image_url)
      #   in {type: :input_audio, input_audio: input_audio}
      #     puts(input_audio)
      #   else
      #     puts(chat_completion_content_part)
      #   end
      module Union
        include OpenAI::Internal::Type::Converter

        # @api private
        #
        # All of the specified variant info for this union.
        #
        # @return [Array<Array(Symbol, Proc)>]
        private def known_variants = (@known_variants ||= [])

        # @api private
        #
        # @return [Array<Array(Symbol, Object)>]
        protected def derefed_variants
          @known_variants.map { |key, variant_fn| [key, variant_fn.call] }
        end

        # All of the specified variants for this union.
        #
        # @return [Array<Object>]
        def variants = derefed_variants.map(&:last)

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
          variant_info =
            case key
            in Symbol
              [key, OpenAI::Internal::Type::Converter.type_info(spec)]
            in Proc | OpenAI::Internal::Type::Converter | Class | Hash
              [nil, OpenAI::Internal::Type::Converter.type_info(key)]
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
            known_variants.find { |k,| k == key }&.last&.call
          else
            nil
          end
        end

        # rubocop:disable Style/HashEachMethods
        # rubocop:disable Style/CaseEquality

        # @param other [Object]
        #
        # @return [Boolean]
        def ===(other)
          known_variants.any? do |_, variant_fn|
            variant_fn.call === other
          end
        end

        # @param other [Object]
        #
        # @return [Boolean]
        def ==(other)
          OpenAI::Internal::Type::Union === other && other.derefed_variants == derefed_variants
        end

        # @api private
        #
        # @param value [Object]
        #
        # @param state [Hash{Symbol=>Object}] .
        #
        #   @option state [Boolean, :strong] :strictness
        #
        #   @option state [Hash{Symbol=>Object}] :exactness
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
          state[:strictness] = strictness == :strong ? true : strictness

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

          case alternatives.sort_by(&:first)
          in []
            exactness[:no] += 1
            if strictness == :strong
              message = "no possible conversion of #{value.class} into a variant of #{target.inspect}"
              raise ArgumentError.new(message)
            end
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

        # rubocop:enable Style/CaseEquality
        # rubocop:enable Style/HashEachMethods

        # @api private
        #
        # @param depth [Integer]
        #
        # @return [String]
        def inspect(depth: 0)
          return super() if depth.positive?

          members = variants.map { OpenAI::Internal::Type::Converter.inspect(_1, depth: depth.succ) }
          prefix = is_a?(Module) ? name : self.class.name

          "#{prefix}[#{members.join(' | ')}]"
        end
      end
    end
  end
end
