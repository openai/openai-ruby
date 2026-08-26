# frozen_string_literal: true

begin
  require "sorbet-runtime"

rescue LoadError => e
  raise unless e.path == "sorbet-runtime"

  raise LoadError, "Sorbet structured outputs require the optional sorbet-runtime gem"
end

require "openai"

module OpenAI
  module Helpers
    module StructuredOutput
      # Adapts application-owned Sorbet models to structured output requests.
      #
      # Load explicitly with `require "openai/helpers/sorbet"`.
      class SorbetAdapter
        include OpenAI::Internal::Type::Converter
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        class HydrationError < TypeError
        end

        Field = Data.define(:name, :wire_name, :node)
        Node = Data.define(:kind, :value, :nullable)
        private_constant :Field, :Node

        # @return [String]
        attr_reader :name

        # @param model [Class<T::Struct>]
        def initialize(model)
          unless model.is_a?(Class) && model < T::Struct && !model.name.to_s.empty?
            raise ArgumentError, "#{model} must be a named T::Struct subclass"
          end

          @name = model.name
          @node = compile_struct(model, path: @name, ancestors: [])
        end

        # @return [Hash{Symbol=>Object}]
        def to_json_schema = schema_for(@node)

        # @api private
        def to_json_schema_inner(**) = to_json_schema

        # @api private
        def coerce(value, state:)
          return value if value.nil? || value.is_a?(JSON::ParserError)

          hydrated = hydrate(@node, value, path: @name.split("::").last)
          state.fetch(:exactness)[:yes] += 1
          hydrated
        end

        private def compile_struct(model, path:, ancestors:)
          if ancestors.include?(model)
            raise ArgumentError, "#{path}: recursive Sorbet models are not supported"
          end

          fields = model.props.map do |field_name, rules|
            wire_name = rules.fetch(:serialized_form)
            type = rules.fetch(:type_object)
            child = compile_type(type, path: "#{path}.#{field_name}", ancestors: [*ancestors, model])

            Field.new(name: field_name, wire_name: wire_name, node: child)
          end

          if (duplicate = fields.map(&:wire_name).tally.find { _2 > 1 })
            raise ArgumentError, "#{path}: duplicate serialized field name #{duplicate.first.inspect}"
          end

          Node.new(kind: :object, value: [model, fields], nullable: false)
        end

        private def compile_type(type, path:, ancestors:)
          case type
          in T::Types::TypedArray
            item = compile_type(type.type, path: "#{path}[]", ancestors: ancestors)
            Node.new(kind: :array, value: item, nullable: false)
          in T::Types::Union
            compile_union(type, path: path, ancestors: ancestors)
          in T::Types::Simple
            compile_class(type.raw_type, path: path, ancestors: ancestors)
          else
            raise ArgumentError, "#{path}: unsupported Sorbet type #{type}"
          end
        end

        private def compile_union(type, path:, ancestors:)
          members = type.types
          nullable, remaining = members.partition do |member|
            member.is_a?(T::Types::Simple) && member.raw_type == NilClass
          end

          node = if boolean_members?(remaining)
            Node.new(kind: :boolean, value: nil, nullable: false)
          elsif remaining.length == 1 && nullable.length == 1
            compile_type(remaining.first, path: path, ancestors: ancestors)
          else
            raise ArgumentError, "#{path}: unsupported Sorbet union #{type}"
          end

          node.with(nullable: !nullable.empty?)
        end

        private def boolean_members?(members)
          members.length == 2 &&
            members.all? { _1.is_a?(T::Types::Simple) } &&
            members.map(&:raw_type).to_set == [TrueClass, FalseClass].to_set
        end

        private def compile_class(type, path:, ancestors:)
          if [String, Integer, Float].include?(type)
            Node.new(kind: :scalar, value: type, nullable: false)
          elsif type < T::Enum
            unless type.values.all? { _1.serialize.is_a?(String) }
              raise ArgumentError, "#{path}: Sorbet enum values must serialize to strings"
            end

            Node.new(kind: :enum, value: type, nullable: false)
          elsif type < T::Struct
            compile_struct(type, path: path, ancestors: ancestors)
          else
            raise ArgumentError, "#{path}: unsupported Sorbet class #{type}"
          end
        end

        private def schema_for(node)
          schema = case node.kind
          in :object
            _model, fields = node.value
            {
              type: "object",
              properties: fields.to_h { [_1.wire_name.to_sym, schema_for(_1.node)] },
              required: fields.map(&:wire_name),
              additionalProperties: false
            }
          in :array
            {type: "array", items: schema_for(node.value)}
          in :boolean
            {type: "boolean"}
          in :enum
            {type: "string", enum: node.value.values.map(&:serialize)}
          in :scalar
            {type: {String => "string", Integer => "integer", Float => "number"}.fetch(node.value)}
          end

          if node.nullable
            if [:object, :enum].include?(node.kind)
              {anyOf: [schema, {type: "null"}]}
            else
              OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_nilable(schema)
            end
          else
            schema
          end
        end

        private def hydrate(node, value, path:)
          return nil if value.nil? && node.nullable

          case node.kind
          in :object
            hydrate_struct(node.value, value, path: path)
          in :array
            unless value.is_a?(Array)
              fail_hydration(path, expected: "Array", actual: value)
            end

            value.map.with_index { |item, index| hydrate(node.value, item, path: "#{path}[#{index}]") }
          in :enum
            unless value.is_a?(String)
              fail_hydration(path, expected: node.value.name, actual: value)
            end

            begin
              node.value.deserialize(value)
            rescue KeyError
              fail_hydration(path, expected: node.value.name, actual: value)
            end

          in :boolean
            unless value.equal?(true) || value.equal?(false)
              fail_hydration(path, expected: "Boolean", actual: value)
            end

            value
          in :scalar
            value = value.to_f if node.value == Float && value.is_a?(Integer)

            unless value.is_a?(node.value)
              fail_hydration(path, expected: node.value.name, actual: value)
            end

            value
          end
        end

        private def hydrate_struct(shape, value, path:)
          model, fields = shape
          unless value.is_a?(Hash)
            fail_hydration(path, expected: model.name, actual: value)
          end

          expected_names = fields.map(&:wire_name).to_set
          unless value.keys.all? { (_1.is_a?(Symbol) || _1.is_a?(String)) && expected_names.include?(_1.to_s) }
            raise HydrationError, "#{path}: unexpected structured-output field"
          end

          attributes = fields.to_h do |field|
            keys = [field.wire_name.to_sym, field.wire_name].select { value.key?(_1) }
            field_path = "#{path}.#{field.name}"
            unless keys.one?
              reason = keys.empty? ? "missing required field" : "duplicate field"
              raise HydrationError, "#{field_path}: #{reason}"
            end

            [field.name, hydrate(field.node, value.fetch(keys.first), path: field_path)]
          end

          begin
            model.new(**attributes)
          rescue HydrationError
            raise
          rescue TypeError, ArgumentError
            raise HydrationError, "#{path}: invalid #{model.name} structured output", cause: nil
          end
        end

        private def fail_hydration(path, expected:, actual:)
          raise HydrationError, "#{path}: expected #{expected}, got #{actual.class}", cause: nil
        end
      end

      # @param model [Class<T::Struct>]
      # @return [OpenAI::Helpers::StructuredOutput::SorbetAdapter]
      def self.from_sorbet(model) = OpenAI::Helpers::StructuredOutput::SorbetAdapter.new(model)
    end
  end
end
