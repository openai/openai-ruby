# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # To customize the JSON schema conversion for a type, implement the `JsonSchemaConverter` interface.
      module JsonSchemaConverter
        # @api private
        POINTERS = Object.new.tap do
          _1.define_singleton_method(:inspect) do
            "#<#{OpenAI::Helpers::StructuredOutput::JsonSchemaConverter}::POINTERS>"
          end
        end.freeze
        # @api private
        NO_REF = Object.new.tap do
          _1.define_singleton_method(:inspect) do
            "#<#{OpenAI::Helpers::StructuredOutput::JsonSchemaConverter}::NO_REF>"
          end
        end.freeze

        # rubocop:disable Lint/UnusedMethodArgument

        # The exact JSON schema produced is subject to improvement between minor release versions.
        #
        # @param state [Hash{Symbol=>Object}]
        #
        #   @option state [Hash{Object=>String}] :defs
        #
        #   @option state [Array<String>] :path
        #
        # @return [Hash{Symbol=>Object}]
        def to_json_schema_inner(state:) = (raise NotImplementedError)

        # rubocop:enable Lint/UnusedMethodArgument

        # Internal helpers methods.
        class << self
          # @api private
          #
          # @param schema [Hash{Symbol=>Object}]
          #
          # @return [Hash{Symbol=>Object}]
          def to_nilable(schema)
            null = "null"
            case schema
            in {"$ref": String}
              {
                anyOf: [
                  schema.update(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::NO_REF => true),
                  {type: null}
                ]
              }
            in {anyOf: schemas}
              null = {type: null}
              schemas.any? { _1 == null || _1 == {type: ["null"]} } ? schema : {anyOf: [*schemas, null]}
            in {type: String => type}
              type == null ? schema : schema.update(type: [type, null])
            in {type: Array => types}
              types.include?(null) ? schema : schema.update(type: [*types, null])
            end
          end

          # @api private
          #
          # @param state [Hash{Symbol=>Object}]
          #
          #   @option state [Hash{Object=>String}] :defs
          #
          #   @option state [Array<String>] :path
          #
          # @param type [Object]
          #
          # @param blk [Proc]
          #
          def cache_def!(state, type:, &blk)
            defs, path = state.fetch_values(:defs, :path)
            if (stored = defs[type])
              pointers = stored.fetch(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::POINTERS)
              pointers.first.except(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::NO_REF).tap do
                pointers << _1
              end
            else
              ref_path = String.new
              ref = {"$ref": ref_path}
              stored = {
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::POINTERS => [ref]
              }
              defs.store(type, stored)
              schema = blk.call
              ref_path.replace("#/$defs/#{path.join('/')}")
              stored.update(schema)
              ref
            end
          end

          # @api private
          #
          # @param type [OpenAI::Helpers::StructuredOutput::JsonSchemaConverter, Class]
          #
          # @return [Hash{Symbol=>Object}]
          def to_json_schema(type)
            defs = {}
            state = {defs: defs, path: []}
            schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema_inner(
              type,
              state: state
            )
            reused_defs = {}
            defs.each_value do |acc|
              sch = acc.except(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::POINTERS)
              pointers = acc.fetch(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::POINTERS)

              no_refs, refs = pointers.partition do
                _1.delete(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::NO_REF)
              end

              case refs
              in [ref]
                ref.replace(sch)
              in [_, ref, *]
                reused_defs.store(ref.fetch(:$ref), sch)
              else
              end
              no_refs.each { _1.replace(sch) }
            end

            xformed = reused_defs.transform_keys { _1.delete_prefix("#/$defs/") }
            xformed.empty? ? schema : {"$defs": xformed}.update(schema)
          end

          # @api private
          #
          # @param type [OpenAI::Helpers::StructuredOutput::JsonSchemaConverter, Class]
          #
          # @param state [Hash{Symbol=>Object}]
          #
          #   @option state [Hash{Object=>String}] :defs
          #
          #   @option state [Array<String>] :path
          #
          # @return [Hash{Symbol=>Object}]
          def to_json_schema_inner(type, state:)
            case type
            in {"$ref": String}
              return type
            in OpenAI::Helpers::StructuredOutput::JsonSchemaConverter
              return type.to_json_schema_inner(state: state)
            in Class
              case type
              in -> { _1 <= NilClass }
                return {type: "null"}
              in -> { _1 <= Integer }
                return {type: "integer"}
              in -> { _1 <= Float }
                return {type: "number"}
              in -> { _1 <= Symbol || _1 <= String }
                return {type: "string"}
              else
              end
            in _ if OpenAI::Internal::Util.primitive?(type)
              return {const: type.is_a?(Symbol) ? type.to_s : type}
            else
            end

            models = %w[
              NilClass
              String
              Symbol
              Integer
              Float
              OpenAI::Boolean
              OpenAI::ArrayOf
              OpenAI::EnumOf
              OpenAI::UnionOf
              OpenAI::BaseModel
            ]
            # rubocop:disable Layout/LineLength
            message = "#{type} does not implement the #{OpenAI::Helpers::StructuredOutput::JsonSchemaConverter} interface. Please use one of the supported types: #{models}"
            # rubocop:enable Layout/LineLength
            raise ArgumentError.new(message)
          end
        end
      end
    end
  end
end
