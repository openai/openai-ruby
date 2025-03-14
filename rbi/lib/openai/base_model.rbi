# typed: strong

module OpenAI
  # @api private
  module Converter
    abstract!

    Input = T.type_alias { T.any(OpenAI::Converter, T::Class[T.anything]) }

    # @api private
    sig { overridable.params(value: T.anything).returns(T.anything) }
    def coerce(value)
    end

    # @api private
    sig { overridable.params(value: T.anything).returns(T.anything) }
    def dump(value)
    end

    # @api private
    sig do
      overridable
        .params(value: T.anything)
        .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
    end
    def try_strict_coerce(value)
    end

    class << self
      # @api private
      sig do
        params(
          spec: T.any(
            {
              const: T.nilable(T.any(NilClass, T::Boolean, Integer, Float, Symbol)),
              enum: T.nilable(T.proc.returns(OpenAI::Converter::Input)),
              union: T.nilable(T.proc.returns(OpenAI::Converter::Input))
            },
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          )
        )
          .returns(T.proc.returns(T.anything).void)
      end
      def self.type_info(spec)
      end

      # @api private
      #
      # Based on `target`, transform `value` into `target`, to the extent possible:
      #
      #   1. if the given `value` conforms to `target` already, return the given `value`
      #   2. if it's possible and safe to convert the given `value` to `target`, then the
      #      converted value
      #   3. otherwise, the given `value` unaltered
      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.coerce(target, value)
      end

      # @api private
      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.dump(target, value)
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
      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.try_strict_coerce(target, value)
      end
    end
  end

  # When we don't know what to expect for the value.
  class Unknown
    abstract!

    extend OpenAI::Converter

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.==(other)
    end

    class << self
      # @api private
      sig { override.params(value: T.anything).returns(T.anything) }
      def coerce(value)
      end

      # @api private
      sig { override.params(value: T.anything).returns(T.anything) }
      def dump(value)
      end

      # @api private
      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

  # Ruby has no Boolean class; this is something for models to refer to.
  class BooleanModel
    abstract!

    extend OpenAI::Converter

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.==(other)
    end

    class << self
      # @api private
      sig { override.params(value: T.any(T::Boolean, T.anything)).returns(T.any(T::Boolean, T.anything)) }
      def coerce(value)
      end

      # @api private
      sig { override.params(value: T.any(T::Boolean, T.anything)).returns(T.any(T::Boolean, T.anything)) }
      def dump(value)
      end

      # @api private
      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

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
  class Enum
    abstract!

    extend OpenAI::Converter

    class << self
      # All of the valid Symbol values for this enum.
      sig { overridable.returns(T::Array[T.any(NilClass, T::Boolean, Integer, Float, Symbol)]) }
      def values
      end

      # @api private
      #
      # Guard against thread safety issues by instantiating `@values`.
      sig { void }
      private def finalize!
      end
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.==(other)
    end

    class << self
      # @api private
      sig { override.params(value: T.any(String, Symbol, T.anything)).returns(T.any(Symbol, T.anything)) }
      def coerce(value)
      end

      # @api private
      sig { override.params(value: T.any(Symbol, T.anything)).returns(T.any(Symbol, T.anything)) }
      def dump(value)
      end

      # @api private
      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

  class Union
    abstract!

    extend OpenAI::Converter

    class << self
      # @api private
      #
      # All of the specified variant info for this union.
      sig { returns(T::Array[[T.nilable(Symbol), Proc]]) }
      private def known_variants
      end

      # @api private
      #
      # All of the specified variants for this union.
      sig { overridable.returns(T::Array[[T.nilable(Symbol), T.anything]]) }
      protected def variants
      end

      # @api private
      sig { params(property: Symbol).void }
      private def discriminator(property)
      end

      # @api private
      sig do
        params(
          key: T.any(
            Symbol,
            T::Hash[Symbol, T.anything],
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          ),
          spec: T.any(
            T::Hash[Symbol, T.anything],
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          )
        )
          .void
      end
      private def variant(key, spec = nil)
      end

      # @api private
      sig { params(value: T.anything).returns(T.nilable(OpenAI::Converter::Input)) }
      private def resolve_variant(value)
      end
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def self.==(other)
    end

    class << self
      # @api private
      sig { override.params(value: T.anything).returns(T.anything) }
      def coerce(value)
      end

      # @api private
      sig { override.params(value: T.anything).returns(T.anything) }
      def dump(value)
      end

      # @api private
      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

  # Array of items of a given type.
  class ArrayOf
    abstract!

    include OpenAI::Converter

    sig { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    # @api private
    sig do
      override
        .params(value: T.any(T::Enumerable[T.anything], T.anything))
        .returns(T.any(T::Array[T.anything], T.anything))
    end
    def coerce(value)
    end

    # @api private
    sig do
      override
        .params(value: T.any(T::Enumerable[T.anything], T.anything))
        .returns(T.any(T::Array[T.anything], T.anything))
    end
    def dump(value)
    end

    # @api private
    sig do
      override
        .params(value: T.anything)
        .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
    end
    def try_strict_coerce(value)
    end

    # @api private
    sig { returns(OpenAI::Converter::Input) }
    protected def item_type
    end

    # @api private
    sig do
      params(
        type_info: T.any(
          T::Hash[Symbol, T.anything],
          T.proc.returns(OpenAI::Converter::Input),
          OpenAI::Converter::Input
        ),
        spec: T::Hash[Symbol, T.anything]
      )
        .returns(T.attached_class)
    end
    def self.new(type_info, spec = {})
    end
  end

  # Hash of items of a given type.
  class HashOf
    abstract!

    include OpenAI::Converter

    sig { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    # @api private
    sig do
      override
        .params(value: T.any(T::Hash[T.anything, T.anything], T.anything))
        .returns(T.any(T::Hash[Symbol, T.anything], T.anything))
    end
    def coerce(value)
    end

    # @api private
    sig do
      override
        .params(value: T.any(T::Hash[T.anything, T.anything], T.anything))
        .returns(T.any(T::Hash[Symbol, T.anything], T.anything))
    end
    def dump(value)
    end

    # @api private
    sig do
      override
        .params(value: T.anything)
        .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
    end
    def try_strict_coerce(value)
    end

    # @api private
    sig { returns(OpenAI::Converter::Input) }
    protected def item_type
    end

    # @api private
    sig do
      params(
        type_info: T.any(
          T::Hash[Symbol, T.anything],
          T.proc.returns(OpenAI::Converter::Input),
          OpenAI::Converter::Input
        ),
        spec: T::Hash[Symbol, T.anything]
      )
        .returns(T.attached_class)
    end
    def self.new(type_info, spec = {})
    end
  end

  class BaseModel
    abstract!

    extend OpenAI::Converter

    KnownFieldShape = T.type_alias { {mode: T.nilable(Symbol), required: T::Boolean} }

    class << self
      # @api private
      #
      # Assumes superclass fields are totally defined before fields are accessed /
      #   defined on subclasses.
      sig do
        returns(
          T::Hash[Symbol,
                  T.all(
                    OpenAI::BaseModel::KnownFieldShape,
                    {type_fn: T.proc.returns(OpenAI::Converter::Input)}
                  )]
        )
      end
      def known_fields
      end

      # @api private
      sig do
        returns(T::Hash[Symbol, T.all(OpenAI::BaseModel::KnownFieldShape, {type: OpenAI::Converter::Input})])
      end
      def fields
      end

      # @api private
      sig { returns(T::Hash[Symbol, T.proc.returns(T::Class[T.anything])]) }
      def defaults
      end

      # @api private
      sig do
        params(
          name_sym: Symbol,
          required: T::Boolean,
          type_info: T.any(
            {
              const: T.nilable(T.any(NilClass, T::Boolean, Integer, Float, Symbol)),
              enum: T.nilable(T.proc.returns(OpenAI::Converter::Input)),
              union: T.nilable(T.proc.returns(OpenAI::Converter::Input)),
              api_name: Symbol,
              nil?: T::Boolean
            },
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          ),
          spec: T::Hash[Symbol, T.anything]
        )
          .void
      end
      private def add_field(name_sym, required:, type_info:, spec:)
      end

      # @api private
      sig do
        params(
          name_sym: Symbol,
          type_info: T.any(
            T::Hash[Symbol, T.anything],
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          ),
          spec: T::Hash[Symbol, T.anything]
        )
          .void
      end
      def required(name_sym, type_info, spec = {})
      end

      # @api private
      sig do
        params(
          name_sym: Symbol,
          type_info: T.any(
            T::Hash[Symbol, T.anything],
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          ),
          spec: T::Hash[Symbol, T.anything]
        )
          .void
      end
      def optional(name_sym, type_info, spec = {})
      end

      # @api private
      #
      # `request_only` attributes not excluded from `.#coerce` when receiving responses
      #   even if well behaved servers should not send them
      sig { params(blk: T.proc.void).void }
      private def request_only(&blk)
      end

      # @api private
      #
      # `response_only` attributes are omitted from `.#dump` when making requests
      sig { params(blk: T.proc.void).void }
      private def response_only(&blk)
      end
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    class << self
      # @api private
      sig do
        override
          .params(value: T.any(OpenAI::BaseModel, T::Hash[T.anything, T.anything], T.anything))
          .returns(T.any(T.attached_class, T.anything))
      end
      def coerce(value)
      end

      # @api private
      sig do
        override
          .params(value: T.any(T.attached_class, T.anything))
          .returns(T.any(T::Hash[T.anything, T.anything], T.anything))
      end
      def dump(value)
      end

      # @api private
      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end

    # Returns the raw value associated with the given key, if found. Otherwise, nil is
    #   returned.
    #
    #   It is valid to lookup keys that are not in the API spec, for example to access
    #   undocumented features. This method does not parse response data into
    #   higher-level types. Lookup by anything other than a Symbol is an ArgumentError.
    sig { params(key: Symbol).returns(T.nilable(T.anything)) }
    def [](key)
    end

    # Returns a Hash of the data underlying this object. O(1)
    #
    #   Keys are Symbols and values are the raw values from the response. The return
    #   value indicates which values were ever set on the object. i.e. there will be a
    #   key in this hash if they ever were, even if the set value was nil.
    #
    #   This method is not recursive. The returned value is shared by the object, so it
    #   should not be mutated.
    sig { overridable.returns(T::Hash[Symbol, T.anything]) }
    def to_h
    end

    alias_method :to_hash, :to_h

    sig { params(keys: T.nilable(T::Array[Symbol])).returns(T::Hash[Symbol, T.anything]) }
    def deconstruct_keys(keys)
    end

    # Create a new instance of a model.
    sig { params(data: T.any(T::Hash[Symbol, T.anything], T.self_type)).returns(T.attached_class) }
    def self.new(data = {})
    end

    sig { returns(String) }
    def to_s
    end

    sig { returns(String) }
    def inspect
    end
  end
end
