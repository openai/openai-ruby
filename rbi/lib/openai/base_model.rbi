# typed: strong

module OpenAI
  module Converter
    abstract!

    Input = T.type_alias { T.any(OpenAI::Converter, T::Class[T.anything]) }

    sig { overridable.params(value: T.anything).returns(T.anything) }
    def coerce(value)
    end

    sig { overridable.params(value: T.anything).returns(T.anything) }
    def dump(value)
    end

    sig do
      overridable
        .params(value: T.anything)
        .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
    end
    def try_strict_coerce(value)
    end

    class << self
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

      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.coerce(target, value)
      end

      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.dump(target, value)
      end

      sig { params(target: OpenAI::Converter::Input, value: T.anything).returns(T.anything) }
      def self.try_strict_coerce(target, value)
      end
    end
  end

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
      sig { override.params(value: T.anything).returns(T.anything) }
      def coerce(value)
      end

      sig { override.params(value: T.anything).returns(T.anything) }
      def dump(value)
      end

      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

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
      sig { override.params(value: T.any(T::Boolean, T.anything)).returns(T.any(T::Boolean, T.anything)) }
      def coerce(value)
      end

      sig { override.params(value: T.any(T::Boolean, T.anything)).returns(T.any(T::Boolean, T.anything)) }
      def dump(value)
      end

      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

  class Enum
    abstract!

    extend OpenAI::Converter

    class << self
      sig { overridable.returns(T::Array[T.any(NilClass, T::Boolean, Integer, Float, Symbol)]) }
      def values
      end

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
      sig { override.params(value: T.any(String, Symbol, T.anything)).returns(T.any(Symbol, T.anything)) }
      def coerce(value)
      end

      sig { override.params(value: T.any(Symbol, T.anything)).returns(T.any(Symbol, T.anything)) }
      def dump(value)
      end

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
      sig { returns(T::Array[[T.nilable(Symbol), Proc]]) }
      private def known_variants
      end

      sig { overridable.returns(T::Array[[T.nilable(Symbol), T.anything]]) }
      protected def variants
      end

      sig { params(property: Symbol).void }
      private def discriminator(property)
      end

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
      sig { override.params(value: T.anything).returns(T.anything) }
      def coerce(value)
      end

      sig { override.params(value: T.anything).returns(T.anything) }
      def dump(value)
      end

      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end
  end

  class ArrayOf
    abstract!

    include OpenAI::Converter

    sig { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    sig do
      override
        .params(value: T.any(T::Enumerable[T.anything], T.anything))
        .returns(T.any(T::Array[T.anything], T.anything))
    end
    def coerce(value)
    end

    sig do
      override
        .params(value: T.any(T::Enumerable[T.anything], T.anything))
        .returns(T.any(T::Array[T.anything], T.anything))
    end
    def dump(value)
    end

    sig do
      override
        .params(value: T.anything)
        .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
    end
    def try_strict_coerce(value)
    end

    sig { returns(OpenAI::Converter::Input) }
    protected def item_type
    end

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

  class HashOf
    abstract!

    include OpenAI::Converter

    sig { params(other: T.anything).returns(T::Boolean) }
    def ===(other)
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    sig do
      override
        .params(value: T.any(T::Hash[T.anything, T.anything], T.anything))
        .returns(T.any(T::Hash[Symbol, T.anything], T.anything))
    end
    def coerce(value)
    end

    sig do
      override
        .params(value: T.any(T::Hash[T.anything, T.anything], T.anything))
        .returns(T.any(T::Hash[Symbol, T.anything], T.anything))
    end
    def dump(value)
    end

    sig do
      override
        .params(value: T.anything)
        .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
    end
    def try_strict_coerce(value)
    end

    sig { returns(OpenAI::Converter::Input) }
    protected def item_type
    end

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

      sig do
        returns(T::Hash[Symbol, T.all(OpenAI::BaseModel::KnownFieldShape, {type: OpenAI::Converter::Input})])
      end
      def fields
      end

      sig { returns(T::Hash[Symbol, T.proc.returns(T::Class[T.anything])]) }
      def defaults
      end

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

      sig { params(blk: T.proc.void).void }
      private def request_only(&blk)
      end

      sig { params(blk: T.proc.void).void }
      private def response_only(&blk)
      end
    end

    sig { params(other: T.anything).returns(T::Boolean) }
    def ==(other)
    end

    class << self
      sig do
        override
          .params(value: T.any(OpenAI::BaseModel, T::Hash[T.anything, T.anything], T.anything))
          .returns(T.any(T.attached_class, T.anything))
      end
      def coerce(value)
      end

      sig do
        override
          .params(value: T.any(T.attached_class, T.anything))
          .returns(T.any(T::Hash[T.anything, T.anything], T.anything))
      end
      def dump(value)
      end

      sig do
        override
          .params(value: T.anything)
          .returns(T.any([T::Boolean, T.anything, NilClass], [T::Boolean, T::Boolean, Integer]))
      end
      def try_strict_coerce(value)
      end
    end

    sig { params(key: Symbol).returns(T.nilable(T.anything)) }
    def [](key)
    end

    sig { overridable.returns(T::Hash[Symbol, T.anything]) }
    def to_h
    end

    alias_method :to_hash, :to_h

    sig { params(keys: T.nilable(T::Array[Symbol])).returns(T::Hash[Symbol, T.anything]) }
    def deconstruct_keys(keys)
    end

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
