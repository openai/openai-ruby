# typed: strong

module OpenAI
  # @api private
  module Converter
    Input = T.type_alias { T.any(OpenAI::Converter, T::Class[T.anything]) }

    State =
      T.type_alias do
        {
          strictness: T.any(T::Boolean, Symbol),
          exactness: {yes: Integer, no: Integer, maybe: Integer},
          branched: Integer
        }
      end

    # @api private
    sig { overridable.params(value: T.anything, state: OpenAI::Converter::State).returns(T.anything) }
    def coerce(value, state:)
    end

    # @api private
    sig { overridable.params(value: T.anything).returns(T.anything) }
    def dump(value)
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
      #
      #   The coercion process is subject to improvement between minor release versions.
      #   See https://docs.pydantic.dev/latest/concepts/unions/#smart-mode
      sig do
        params(target: OpenAI::Converter::Input, value: T.anything, state: OpenAI::Converter::State)
          .returns(T.anything)
      end
      def self.coerce(
        target,
        value,
        # The `strictness` is one of `true`, `false`, or `:strong`. This informs the
        #   coercion strategy when we have to decide between multiple possible conversion
        #   targets:
        #
        #   - `true`: the conversion must be exact, with minimum coercion.
        #   - `false`: the conversion can be approximate, with some coercion.
        #   - `:strong`: the conversion must be exact, with no coercion, and raise an error
        #     if not possible.
        #
        #   The `exactness` is `Hash` with keys being one of `yes`, `no`, or `maybe`. For
        #   any given conversion attempt, the exactness will be updated based on how closely
        #   the value recursively matches the target type:
        #
        #   - `yes`: the value can be converted to the target type with minimum coercion.
        #   - `maybe`: the value can be converted to the target type with some reasonable
        #     coercion.
        #   - `no`: the value cannot be converted to the target type.
        #
        #   See implementation below for more details.
        state: {strictness: true, exactness: {yes: 0, no: 0, maybe: 0}, branched: 0}
      )
      end

      # @api private
      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.dump(target, value)
      end
    end
  end

  # @api private
  #
  # When we don't know what to expect for the value.
  class Unknown
    extend OpenAI::Converter

    abstract!
    final!

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def self.===(other)
    end

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def self.==(other)
    end

    class << self
      # @api private
      sig(:final) { override.params(value: T.anything, state: OpenAI::Converter::State).returns(T.anything) }
      def coerce(value, state:)
      end

      # @api private
      sig(:final) { override.params(value: T.anything).returns(T.anything) }
      def dump(value)
      end
    end
  end

  # @api private
  #
  # Ruby has no Boolean class; this is something for models to refer to.
  class BooleanModel
    extend OpenAI::Converter

    abstract!
    final!

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def self.===(other)
    end

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def self.==(other)
    end

    class << self
      # @api private
      sig(:final) do
        override
          .params(value: T.any(T::Boolean, T.anything), state: OpenAI::Converter::State)
          .returns(T.any(T::Boolean, T.anything))
      end
      def coerce(value, state:)
      end

      # @api private
      sig(:final) do
        override.params(value: T.any(T::Boolean, T.anything)).returns(T.any(T::Boolean, T.anything))
      end
      def dump(value)
      end
    end
  end

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
  module Enum
    include OpenAI::Converter

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

    sig { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    # @api private
    #
    # Unlike with primitives, `Enum` additionally validates that the value is a member
    #   of the enum.
    sig do
      override
        .params(value: T.any(String, Symbol, T.anything), state: OpenAI::Converter::State)
        .returns(T.any(Symbol, T.anything))
    end
    def coerce(value, state:)
    end

    # @api private
    sig { override.params(value: T.any(Symbol, T.anything)).returns(T.any(Symbol, T.anything)) }
    def dump(value)
    end
  end

  # @api private
  module Union
    include OpenAI::Converter

    # @api private
    #
    # All of the specified variant info for this union.
    sig { returns(T::Array[[T.nilable(Symbol), T.proc.returns(OpenAI::Converter::Input)]]) }
    private def known_variants
    end

    # @api private
    sig { returns(T::Array[[T.nilable(Symbol), T.anything]]) }
    protected def derefed_variants
    end

    # All of the specified variants for this union.
    sig { overridable.returns(T::Array[T.anything]) }
    def variants
    end

    # @api private
    sig { params(property: Symbol).void }
    private def discriminator(property)
    end

    # @api private
    sig do
      params(
        key: T.any(Symbol, OpenAI::Util::AnyHash, T.proc.returns(T.anything), T.anything),
        spec: T.any(OpenAI::Util::AnyHash, T.proc.returns(T.anything), T.anything)
      )
        .void
    end
    private def variant(key, spec = nil)
    end

    # @api private
    sig { params(value: T.anything).returns(T.nilable(T.anything)) }
    private def resolve_variant(value)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    # @api private
    sig { override.params(value: T.anything, state: OpenAI::Converter::State).returns(T.anything) }
    def coerce(value, state:)
    end

    # @api private
    sig { override.params(value: T.anything).returns(T.anything) }
    def dump(value)
    end
  end

  # @api private
  #
  # Array of items of a given type.
  class ArrayOf
    include OpenAI::Converter

    abstract!
    final!

    sig(:final) do
      params(
        type_info: T.any(
          OpenAI::Util::AnyHash,
          T.proc.returns(OpenAI::Converter::Input),
          OpenAI::Converter::Input
        ),
        spec: OpenAI::Util::AnyHash
      )
        .returns(T.attached_class)
    end
    def self.[](type_info, spec = {})
    end

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    # @api private
    sig(:final) do
      override
        .params(value: T.any(T::Enumerable[T.anything], T.anything), state: OpenAI::Converter::State)
        .returns(T.any(T::Array[T.anything], T.anything))
    end
    def coerce(value, state:)
    end

    # @api private
    sig(:final) do
      override
        .params(value: T.any(T::Enumerable[T.anything], T.anything))
        .returns(T.any(T::Array[T.anything], T.anything))
    end
    def dump(value)
    end

    # @api private
    sig(:final) { returns(T.anything) }
    protected def item_type
    end

    # @api private
    sig(:final) { returns(T::Boolean) }
    protected def nilable?
    end

    # @api private
    sig(:final) do
      params(
        type_info: T.any(
          OpenAI::Util::AnyHash,
          T.proc.returns(OpenAI::Converter::Input),
          OpenAI::Converter::Input
        ),
        spec: OpenAI::Util::AnyHash
      )
        .void
    end
    def initialize(type_info, spec = {})
    end
  end

  # @api private
  #
  # Hash of items of a given type.
  class HashOf
    include OpenAI::Converter

    abstract!
    final!

    sig(:final) do
      params(
        type_info: T.any(
          OpenAI::Util::AnyHash,
          T.proc.returns(OpenAI::Converter::Input),
          OpenAI::Converter::Input
        ),
        spec: OpenAI::Util::AnyHash
      )
        .returns(T.attached_class)
    end
    def self.[](type_info, spec = {})
    end

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig(:final) { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    # @api private
    sig(:final) do
      override
        .params(value: T.any(T::Hash[T.anything, T.anything], T.anything), state: OpenAI::Converter::State)
        .returns(T.any(OpenAI::Util::AnyHash, T.anything))
    end
    def coerce(value, state:)
    end

    # @api private
    sig(:final) do
      override
        .params(value: T.any(T::Hash[T.anything, T.anything], T.anything))
        .returns(T.any(OpenAI::Util::AnyHash, T.anything))
    end
    def dump(value)
    end

    # @api private
    sig(:final) { returns(T.anything) }
    protected def item_type
    end

    # @api private
    sig(:final) { returns(T::Boolean) }
    protected def nilable?
    end

    # @api private
    sig(:final) do
      params(
        type_info: T.any(
          OpenAI::Util::AnyHash,
          T.proc.returns(OpenAI::Converter::Input),
          OpenAI::Converter::Input
        ),
        spec: OpenAI::Util::AnyHash
      )
        .void
    end
    def initialize(type_info, spec = {})
    end
  end

  class BaseModel
    extend OpenAI::Converter

    abstract!

    KnownFieldShape = T.type_alias { {mode: T.nilable(Symbol), required: T::Boolean, nilable: T::Boolean} }

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
          spec: OpenAI::Util::AnyHash
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
            OpenAI::Util::AnyHash,
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          ),
          spec: OpenAI::Util::AnyHash
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
            OpenAI::Util::AnyHash,
            T.proc.returns(OpenAI::Converter::Input),
            OpenAI::Converter::Input
          ),
          spec: OpenAI::Util::AnyHash
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

      sig { params(other: T.anything).returns(T::Boolean) }
      def ==(other)
      end
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    class << self
      # @api private
      sig do
        override
          .params(
            value: T.any(OpenAI::BaseModel, T::Hash[T.anything, T.anything], T.anything),
            state: OpenAI::Converter::State
          )
          .returns(T.any(T.attached_class, T.anything))
      end
      def coerce(value, state:)
      end

      # @api private
      sig do
        override
          .params(value: T.any(T.attached_class, T.anything))
          .returns(T.any(T::Hash[T.anything, T.anything], T.anything))
      end
      def dump(value)
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
    sig { overridable.returns(OpenAI::Util::AnyHash) }
    def to_h
    end

    # Returns a Hash of the data underlying this object. O(1)
    #
    #   Keys are Symbols and values are the raw values from the response. The return
    #   value indicates which values were ever set on the object. i.e. there will be a
    #   key in this hash if they ever were, even if the set value was nil.
    #
    #   This method is not recursive. The returned value is shared by the object, so it
    #   should not be mutated.
    sig { overridable.returns(OpenAI::Util::AnyHash) }
    def to_hash
    end

    sig { params(keys: T.nilable(T::Array[Symbol])).returns(OpenAI::Util::AnyHash) }
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
