# frozen_string_literal: true

module OpenAI
  # @api private
  #
  # @abstract
  module Converter
    # rubocop:disable Lint/UnusedMethodArgument

    # @api private
    #
    # @param value [Object]
    #
    # @return [Object]
    def coerce(value) = value

    # @api private
    #
    # @param value [Object]
    #
    # @return [Object]
    def dump(value) = value

    # @api private
    #
    # @param value [Object]
    #
    # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
    def try_strict_coerce(value) = (raise NotImplementedError)

    # rubocop:enable Lint/UnusedMethodArgument

    class << self
      # @api private
      #
      # @param spec [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class] .
      #
      #   @option spec [NilClass, TrueClass, FalseClass, Integer, Float, Symbol] :const
      #
      #   @option spec [Proc] :enum
      #
      #   @option spec [Proc] :union
      #
      #   @option spec [Boolean] :"nil?"
      #
      # @return [Proc]
      def type_info(spec)
        case spec
        in Hash
          type_info(spec.slice(:const, :enum, :union).first&.last)
        in Proc
          spec
        in OpenAI::Converter | Class | Symbol
          -> { spec }
        in true | false
          -> { OpenAI::BooleanModel }
        in NilClass | Integer | Float
          -> { spec.class }
        end
      end

      # @api private
      #
      # Based on `target`, transform `value` into `target`, to the extent possible:
      #
      #   1. if the given `value` conforms to `target` already, return the given `value`
      #   2. if it's possible and safe to convert the given `value` to `target`, then the
      #      converted value
      #   3. otherwise, the given `value` unaltered
      #
      # @param target [OpenAI::Converter, Class]
      # @param value [Object]
      #
      # @return [Object]
      def coerce(target, value)
        case target
        in OpenAI::Converter
          target.coerce(value)
        in Symbol
          case value
          in Symbol | String if (val = value.to_sym) == target
            val
          else
            value
          end
        in Class
          case target
          in -> { _1 <= NilClass }
            nil
          in -> { _1 <= Integer }
            value.is_a?(Numeric) ? Integer(value) : value
          in -> { _1 <= Float }
            value.is_a?(Numeric) ? Float(value) : value
          in -> { _1 <= Symbol }
            value.is_a?(String) ? value.to_sym : value
          in -> { _1 <= String }
            value.is_a?(Symbol) ? value.to_s : value
          in -> { _1 <= Date || _1 <= Time }
            value.is_a?(String) ? target.parse(value) : value
          in -> { _1 <= IO }
            value.is_a?(String) ? StringIO.new(value) : value
          else
            value
          end
        end
      end

      # @api private
      #
      # @param target [OpenAI::Converter, Class]
      # @param value [Object]
      #
      # @return [Object]
      def dump(target, value)
        case target
        in OpenAI::Converter
          target.dump(value)
        else
          value
        end
      end

      # @api private
      #
      # The underlying algorithm for computing maximal compatibility is subject to
      #   future improvements.
      #
      #   Similar to `#.coerce`, used to determine the best union variant to decode into.
      #
      #   1. determine if strict-ish coercion is possible
      #   2. return either result of successful coercion or if loose coercion is possible
      #   3. return a score for recursively tallied count for fields that can be coerced
      #
      # @param target [OpenAI::Converter, Class]
      # @param value [Object]
      #
      # @return [Object]
      def try_strict_coerce(target, value)
        case target
        in OpenAI::Converter
          target.try_strict_coerce(value)
        in Symbol
          case value
          in Symbol | String if (val = value.to_sym) == target
            [true, val, 1]
          else
            [false, false, 0]
          end
        in Class
          case [target, value]
          in [-> { _1 <= NilClass }, _]
            [true, nil, value.nil? ? 1 : 0]
          in [-> { _1 <= Integer }, Numeric]
            [true, Integer(value), 1]
          in [-> { _1 <= Float }, Numeric]
            [true, Float(value), 1]
          in [-> { _1 <= Symbol }, String]
            [true, value.to_sym, 1]
          in [-> { _1 <= String }, Symbol]
            [true, value.to_s, 1]
          in [-> { _1 <= Date || _1 <= Time }, String]
            Kernel.then do
              [true, target.parse(value), 1]
            rescue ArgumentError
              [false, false, 0]
            end
          in [_, ^target]
            [true, value, 1]
          else
            [false, false, 0]
          end
        end
      end
    end
  end

  # @api private
  #
  # @abstract
  #
  # When we don't know what to expect for the value.
  class Unknown
    extend OpenAI::Converter

    # rubocop:disable Lint/UnusedMethodArgument

    private_class_method :new

    # @param other [Object]
    #
    # @return [Boolean]
    def self.===(other) = true

    # @param other [Object]
    #
    # @return [Boolean]
    def self.==(other) = other.is_a?(Class) && other <= OpenAI::Unknown

    class << self
      # @!parse
      #   # @api private
      #   #
      #   # @param value [Object]
      #   #
      #   # @return [Object]
      #   def coerce(value) = super

      # @!parse
      #   # @api private
      #   #
      #   # @param value [Object]
      #   #
      #   # @return [Object]
      #   def dump(value) = super

      # @api private
      #
      # @param value [Object]
      #
      # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
      def try_strict_coerce(value)
        # prevent unknown variant from being chosen during the first coercion pass
        [false, true, 0]
      end
    end

    # rubocop:enable Lint/UnusedMethodArgument
  end

  # @api private
  #
  # @abstract
  #
  # Ruby has no Boolean class; this is something for models to refer to.
  class BooleanModel
    extend OpenAI::Converter

    private_class_method :new

    # @param other [Object]
    #
    # @return [Boolean]
    def self.===(other) = other == true || other == false

    # @param other [Object]
    #
    # @return [Boolean]
    def self.==(other) = other.is_a?(Class) && other <= OpenAI::BooleanModel

    class << self
      # @!parse
      #   # @api private
      #   #
      #   # @param value [Boolean, Object]
      #   #
      #   # @return [Boolean, Object]
      #   def coerce(value) = super

      # @!parse
      #   # @api private
      #   #
      #   # @param value [Boolean, Object]
      #   #
      #   # @return [Boolean, Object]
      #   def dump(value) = super

      # @api private
      #
      # @param value [Object]
      #
      # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
      def try_strict_coerce(value)
        case value
        in true | false
          [true, value, 1]
        else
          [false, false, 0]
        end
      end
    end
  end

  # @api private
  #
  # @abstract
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
  # ```ruby
  # # `chat_model` is a `OpenAI::Models::ChatModel`
  # case chat_model
  # when OpenAI::Models::ChatModel::O3_MINI
  #   # ...
  # when OpenAI::Models::ChatModel::O3_MINI_2025_01_31
  #   # ...
  # when OpenAI::Models::ChatModel::O1
  #   # ...
  # else
  #   # ...
  # end
  # ```
  #
  # @example
  # ```ruby
  # case chat_model
  # in :"o3-mini"
  #   # ...
  # in :"o3-mini-2025-01-31"
  #   # ...
  # in :o1
  #   # ...
  # else
  #   # ...
  # end
  # ```
  class Enum
    extend OpenAI::Converter

    class << self
      # All of the valid Symbol values for this enum.
      #
      # @return [Array<NilClass, Boolean, Integer, Float, Symbol>]
      def values = (@values ||= constants.map { const_get(_1) })

      # @api private
      #
      # Guard against thread safety issues by instantiating `@values`.
      private def finalize! = values
    end

    private_class_method :new

    # @param other [Object]
    #
    # @return [Boolean]
    def self.===(other) = values.include?(other)

    # @param other [Object]
    #
    # @return [Boolean]
    def self.==(other)
      other.is_a?(Class) && other <= OpenAI::Enum && other.values.to_set == values.to_set
    end

    class << self
      # @api private
      #
      # @param value [String, Symbol, Object]
      #
      # @return [Symbol, Object]
      def coerce(value)
        case value
        in Symbol | String if values.include?(val = value.to_sym)
          val
        else
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

      # @api private
      #
      # @param value [Object]
      #
      # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
      def try_strict_coerce(value)
        return [true, value, 1] if values.include?(value)

        case value
        in Symbol | String if values.include?(val = value.to_sym)
          [true, val, 1]
        else
          case [value, values.first]
          in [true | false, true | false] | [Integer, Integer] | [Symbol | String, Symbol]
            [false, true, 0]
          else
            [false, false, 0]
          end
        end
      end
    end
  end

  # @api private
  #
  # @abstract
  #
  # @example
  # ```ruby
  # # `chat_completion_content_part` is a `OpenAI::Models::Chat::ChatCompletionContentPart`
  # case chat_completion_content_part
  # when OpenAI::Models::Chat::ChatCompletionContentPartText
  #   # ...
  # when OpenAI::Models::Chat::ChatCompletionContentPartImage
  #   # ...
  # when OpenAI::Models::Chat::ChatCompletionContentPartInputAudio
  #   # ...
  # else
  #   # ...
  # end
  # ```
  #
  # @example
  # ```ruby
  # case chat_completion_content_part
  # in {type: :text, text: text}
  #   # ...
  # in {type: :image_url, image_url: image_url}
  #   # ...
  # in {type: :input_audio, input_audio: input_audio}
  #   # ...
  # in {type: :file, file: file}
  #   # ...
  # else
  #   # ...
  # end
  # ```
  class Union
    extend OpenAI::Converter

    class << self
      # @api private
      #
      # All of the specified variant info for this union.
      #
      # @return [Array<Array(Symbol, Proc)>]
      private def known_variants = (@known_variants ||= [])

      # @api private
      #
      # All of the specified variants for this union.
      #
      # @return [Array<Array(Symbol, Object)>]
      protected def variants
        @known_variants.map { |key, variant_fn| [key, variant_fn.call] }
      end

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
      # @param key [Symbol, Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class]
      #
      # @param spec [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class] .
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
            [key, OpenAI::Converter.type_info(spec)]
          in Proc | OpenAI::Converter | Class | Hash
            [nil, OpenAI::Converter.type_info(key)]
          end

        known_variants << variant_info
      end

      # @api private
      #
      # @param value [Object]
      #
      # @return [OpenAI::Converter, Class, nil]
      private def resolve_variant(value)
        case [@discriminator, value]
        in [_, OpenAI::BaseModel]
          value.class
        in [Symbol, Hash]
          key =
            if value.key?(@discriminator)
              value.fetch(@discriminator)
            elsif value.key?((discriminator = @discriminator.to_s))
              value.fetch(discriminator)
            end

          key = key.to_sym if key.is_a?(String)
          _, resolved = known_variants.find { |k,| k == key }
          resolved.nil? ? OpenAI::Unknown : resolved.call
        else
          nil
        end
      end
    end

    # rubocop:disable Style/HashEachMethods
    # rubocop:disable Style/CaseEquality

    private_class_method :new

    # @param other [Object]
    #
    # @return [Boolean]
    def self.===(other)
      known_variants.any? do |_, variant_fn|
        variant_fn.call === other
      end
    end

    # @param other [Object]
    #
    # @return [Boolean]
    def self.==(other)
      other.is_a?(Class) && other <= OpenAI::Union && other.variants == variants
    end

    class << self
      # @api private
      #
      # @param value [Object]
      #
      # @return [Object]
      def coerce(value)
        if (variant = resolve_variant(value))
          return OpenAI::Converter.coerce(variant, value)
        end

        matches = []

        known_variants.each do |_, variant_fn|
          variant = variant_fn.call

          case OpenAI::Converter.try_strict_coerce(variant, value)
          in [true, coerced, _]
            return coerced
          in [false, true, score]
            matches << [score, variant]
          in [false, false, _]
            nil
          end
        end

        _, variant = matches.sort! { _2.first <=> _1.first }.find { |score,| !score.zero? }
        variant.nil? ? value : OpenAI::Converter.coerce(variant, value)
      end

      # @api private
      #
      # @param value [Object]
      #
      # @return [Object]
      def dump(value)
        if (variant = resolve_variant(value))
          return OpenAI::Converter.dump(variant, value)
        end

        known_variants.each do |_, variant_fn|
          variant = variant_fn.call
          if variant === value
            return OpenAI::Converter.dump(variant, value)
          end
        end
        value
      end

      # @api private
      #
      # @param value [Object]
      #
      # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
      def try_strict_coerce(value)
        # TODO(ruby) this will result in super linear decoding behaviour for nested unions
        # follow up with a decoding context that captures current strictness levels
        if (variant = resolve_variant(value))
          return Converter.try_strict_coerce(variant, value)
        end

        coercible = false
        max_score = 0

        known_variants.each do |_, variant_fn|
          variant = variant_fn.call

          case OpenAI::Converter.try_strict_coerce(variant, value)
          in [true, coerced, score]
            return [true, coerced, score]
          in [false, true, score]
            coercible = true
            max_score = [max_score, score].max
          in [false, false, _]
            nil
          end
        end

        [false, coercible, max_score]
      end
    end

    # rubocop:enable Style/CaseEquality
    # rubocop:enable Style/HashEachMethods
  end

  # @api private
  #
  # @abstract
  #
  # Array of items of a given type.
  class ArrayOf
    include OpenAI::Converter

    private_class_method :new

    def self.[](...) = new(...)

    # @param other [Object]
    #
    # @return [Boolean]
    def ===(other)
      type = item_type
      case other
      in Array
        # rubocop:disable Style/CaseEquality
        other.all? { type === _1 }
        # rubocop:enable Style/CaseEquality
      else
        false
      end
    end

    # @param other [Object]
    #
    # @return [Boolean]
    def ==(other) = other.is_a?(OpenAI::ArrayOf) && other.item_type == item_type

    # @api private
    #
    # @param value [Enumerable, Object]
    #
    # @return [Array<Object>, Object]
    def coerce(value)
      type = item_type
      case value
      in Enumerable unless value.is_a?(Hash)
        value.map { OpenAI::Converter.coerce(type, _1) }
      else
        value
      end
    end

    # @api private
    #
    # @param value [Enumerable, Object]
    #
    # @return [Array<Object>, Object]
    def dump(value)
      type = item_type
      case value
      in Enumerable unless value.is_a?(Hash)
        value.map { OpenAI::Converter.dump(type, _1) }.to_a
      else
        value
      end
    end

    # @api private
    #
    # @param value [Object]
    #
    # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
    def try_strict_coerce(value)
      case value
      in Array
        type = item_type
        great_success = true
        tally = 0

        mapped =
          value.map do |item|
            case OpenAI::Converter.try_strict_coerce(type, item)
            in [true, coerced, score]
              tally += score
              coerced
            in [false, true, score]
              great_success = false
              tally += score
              item
            in [false, false, _]
              great_success &&= item.nil?
              item
            end
          end

        if great_success
          [true, mapped, tally]
        else
          [false, true, tally]
        end
      else
        [false, false, 0]
      end
    end

    # @api private
    #
    # @return [OpenAI::Converter, Class]
    protected def item_type = @item_type_fn.call

    # @api private
    #
    # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class]
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
      @item_type_fn = OpenAI::Converter.type_info(type_info || spec)
    end
  end

  # @api private
  #
  # @abstract
  #
  # Hash of items of a given type.
  class HashOf
    include OpenAI::Converter

    private_class_method :new

    def self.[](...) = new(...)

    # @param other [Object]
    #
    # @return [Boolean]
    def ===(other)
      type = item_type
      case other
      in Hash
        other.all? do |key, val|
          case [key, val]
          in [Symbol | String, ^type]
            true
          else
            false
          end
        end
      else
        false
      end
    end

    # @param other [Object]
    #
    # @return [Boolean]
    def ==(other) = other.is_a?(OpenAI::HashOf) && other.item_type == item_type

    # @api private
    #
    # @param value [Hash{Object=>Object}, Object]
    #
    # @return [Hash{Symbol=>Object}, Object]
    def coerce(value)
      type = item_type
      case value
      in Hash
        value.to_h do |key, val|
          coerced = OpenAI::Converter.coerce(type, val)
          [key.is_a?(String) ? key.to_sym : key, coerced]
        end
      else
        value
      end
    end

    # @api private
    #
    # @param value [Hash{Object=>Object}, Object]
    #
    # @return [Hash{Symbol=>Object}, Object]
    def dump(value)
      type = item_type
      case value
      in Hash
        value.transform_values do |val|
          OpenAI::Converter.dump(type, val)
        end
      else
        value
      end
    end

    # @api private
    #
    # @param value [Object]
    #
    # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
    def try_strict_coerce(value)
      case value
      in Hash
        type = item_type
        great_success = true
        tally = 0

        mapped =
          value.transform_values do |val|
            case OpenAI::Converter.try_strict_coerce(type, val)
            in [true, coerced, score]
              tally += score
              coerced
            in [false, true, score]
              great_success = false
              tally += score
              val
            in [false, false, _]
              great_success &&= val.nil?
              val
            end
          end

        if great_success
          [true, mapped, tally]
        else
          [false, true, tally]
        end
      else
        [false, false, 0]
      end
    end

    # @api private
    #
    # @return [OpenAI::Converter, Class]
    protected def item_type = @item_type_fn.call

    # @api private
    #
    # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class]
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
      @item_type_fn = OpenAI::Converter.type_info(type_info || spec)
    end
  end

  # @api private
  #
  # @abstract
  #
  # @example
  # ```ruby
  # # `comparison_filter` is a `OpenAI::Models::ComparisonFilter`
  # comparison_filter => {
  #   key: key,
  #   type: type,
  #   value: value
  # }
  # ```
  class BaseModel
    extend OpenAI::Converter

    class << self
      # @api private
      #
      # Assumes superclass fields are totally defined before fields are accessed /
      #   defined on subclasses.
      #
      # @return [Hash{Symbol=>Hash{Symbol=>Object}}]
      def known_fields
        @known_fields ||= (self < OpenAI::BaseModel ? superclass.known_fields.dup : {})
      end

      # @return [Hash{Symbol=>Hash{Symbol=>Object}}]
      def fields
        known_fields.transform_values do |field|
          {**field.except(:type_fn), type: field.fetch(:type_fn).call}
        end
      end

      # @api private
      #
      # @return [Hash{Symbol=>Proc}]
      def defaults = (@defaults ||= {})

      # @api private
      #
      # @param name_sym [Symbol]
      #
      # @param required [Boolean]
      #
      # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class]
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
      private def add_field(name_sym, required:, type_info:, spec:)
        type_fn, info =
          case type_info
          in Proc | Class | OpenAI::Converter
            [OpenAI::Converter.type_info({**spec, union: type_info}), spec]
          in Hash
            [OpenAI::Converter.type_info(type_info), type_info]
          end

        fallback = info[:const]
        defaults[name_sym] = fallback if required && !info[:nil?] && info.key?(:const)

        key = info.fetch(:api_name, name_sym)
        setter = "#{name_sym}="

        if known_fields.key?(name_sym)
          [name_sym, setter].each { undef_method(_1) }
        end

        known_fields[name_sym] = {mode: @mode, key: key, required: required, type_fn: type_fn}

        define_method(setter) do |val|
          @data[key] = val
        end

        define_method(name_sym) do
          field_type = type_fn.call
          value = @data.fetch(key) { self.class.defaults[key] }
          OpenAI::Converter.coerce(field_type, value)
        rescue StandardError
          name = self.class.name.split("::").last
          raise OpenAI::ConversionError.new(
            "Failed to parse #{name}.#{name_sym} as #{field_type.inspect}. " \
            "To get the unparsed API response, use #{name}[:#{key}]."
          )
        end
      end

      # @api private
      #
      # @param name_sym [Symbol]
      #
      # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class]
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
      def required(name_sym, type_info, spec = {})
        add_field(name_sym, required: true, type_info: type_info, spec: spec)
      end

      # @api private
      #
      # @param name_sym [Symbol]
      #
      # @param type_info [Hash{Symbol=>Object}, Proc, OpenAI::Converter, Class]
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
      def optional(name_sym, type_info, spec = {})
        add_field(name_sym, required: false, type_info: type_info, spec: spec)
      end

      # @api private
      #
      # `request_only` attributes not excluded from `.#coerce` when receiving responses
      #   even if well behaved servers should not send them
      #
      # @param blk [Proc]
      private def request_only(&blk)
        @mode = :dump
        blk.call
      ensure
        @mode = nil
      end

      # @api private
      #
      # `response_only` attributes are omitted from `.#dump` when making requests
      #
      # @param blk [Proc]
      private def response_only(&blk)
        @mode = :coerce
        blk.call
      ensure
        @mode = nil
      end
    end

    # @param other [Object]
    #
    # @return [Boolean]
    def ==(other)
      case other
      in OpenAI::BaseModel
        self.class.fields == other.class.fields && @data == other.to_h
      else
        false
      end
    end

    class << self
      # @api private
      #
      # @param value [OpenAI::BaseModel, Hash{Object=>Object}, Object]
      #
      # @return [OpenAI::BaseModel, Object]
      def coerce(value)
        case OpenAI::Util.coerce_hash(value)
        in Hash => coerced
          new(coerced)
        else
          value
        end
      end

      # @api private
      #
      # @param value [OpenAI::BaseModel, Object]
      #
      # @return [Hash{Object=>Object}, Object]
      def dump(value)
        unless (coerced = OpenAI::Util.coerce_hash(value)).is_a?(Hash)
          return value
        end

        values = coerced.filter_map do |key, val|
          name = key.to_sym
          case (field = known_fields[name])
          in nil
            [name, val]
          else
            mode, type_fn, api_name = field.fetch_values(:mode, :type_fn, :key)
            case mode
            in :coerce
              next
            else
              target = type_fn.call
              [api_name, OpenAI::Converter.dump(target, val)]
            end
          end
        end.to_h

        defaults.each do |key, val|
          next if values.key?(key)

          values[key] = val
        end

        values
      end

      # @api private
      #
      # @param value [Object]
      #
      # @return [Array(true, Object, nil), Array(false, Boolean, Integer)]
      def try_strict_coerce(value)
        case value
        in Hash | OpenAI::BaseModel
          value = value.to_h
        else
          return [false, false, 0]
        end

        keys = value.keys.to_set
        great_success = true
        tally = 0
        acc = {}

        known_fields.each_value do |field|
          mode, required, type_fn, api_name = field.fetch_values(:mode, :required, :type_fn, :key)
          keys.delete(api_name)

          case [required && mode != :dump, value.key?(api_name)]
          in [_, true]
            target = type_fn.call
            item = value.fetch(api_name)
            case OpenAI::Converter.try_strict_coerce(target, item)
            in [true, coerced, score]
              tally += score
              acc[api_name] = coerced
            in [false, true, score]
              great_success = false
              tally += score
              acc[api_name] = item
            in [false, false, _]
              great_success &&= item.nil?
            end
          in [true, false]
            great_success = false
          in [false, false]
            nil
          end
        end

        keys.each do |key|
          acc[key] = value.fetch(key)
        end

        great_success ? [true, new(acc), tally] : [false, true, tally]
      end
    end

    # Returns the raw value associated with the given key, if found. Otherwise, nil is
    #   returned.
    #
    #   It is valid to lookup keys that are not in the API spec, for example to access
    #   undocumented features. This method does not parse response data into
    #   higher-level types. Lookup by anything other than a Symbol is an ArgumentError.
    #
    # @param key [Symbol]
    #
    # @return [Object, nil]
    def [](key)
      unless key.instance_of?(Symbol)
        raise ArgumentError.new("Expected symbol key for lookup, got #{key.inspect}")
      end

      @data[key]
    end

    # Returns a Hash of the data underlying this object. O(1)
    #
    #   Keys are Symbols and values are the raw values from the response. The return
    #   value indicates which values were ever set on the object. i.e. there will be a
    #   key in this hash if they ever were, even if the set value was nil.
    #
    #   This method is not recursive. The returned value is shared by the object, so it
    #   should not be mutated.
    #
    # @return [Hash{Symbol=>Object}]
    def to_h = @data

    alias_method :to_hash, :to_h

    # @param keys [Array<Symbol>, nil]
    #
    # @return [Hash{Symbol=>Object}]
    def deconstruct_keys(keys)
      (keys || self.class.known_fields.keys).filter_map do |k|
        unless self.class.known_fields.key?(k)
          next
        end

        [k, method(k).call]
      end
      .to_h
    end

    # Create a new instance of a model.
    #
    # @param data [Hash{Symbol=>Object}, OpenAI::BaseModel]
    def initialize(data = {})
      case OpenAI::Util.coerce_hash(data)
      in Hash => coerced
        @data = coerced.transform_keys(&:to_sym)
      else
        raise ArgumentError.new("Expected a #{Hash} or #{OpenAI::BaseModel}, got #{data.inspect}")
      end
    end

    # @return [String]
    def to_s = @data.to_s

    # @return [String]
    def inspect
      "#<#{self.class.name}:0x#{object_id.to_s(16)} #{deconstruct_keys(nil).map do |k, v|
        "#{k}=#{v.inspect}"
      end.join(' ')}>"
    end
  end
end
