# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # @generic Elem
      #
      # @example
      #   example = OpenAI::ArrayOf[Integer]
      #
      # @example
      #   example = OpenAI::ArrayOf[Integer, nil?: true, doc: "hi there!"]
      class ArrayOf < OpenAI::Internal::Type::ArrayOf
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        # @api private
        #
        # @param state [Hash{Symbol=>Object}]
        #
        #   @option state [Hash{Object=>String}] :defs
        #
        #   @option state [Array<String>] :path
        #
        # @return [Hash{Symbol=>Object}]
        def to_json_schema_inner(state:)
          OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.cache_def!(state, type: self) do
            state.fetch(:path) << "[]"
            items = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema_inner(
              item_type,
              state: state
            )
            items = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_nilable(items) if nilable?

            schema = {type: "array", items: items}
            description.nil? ? schema : schema.update(description: description)
          end
        end

        # @return [String, nil]
        attr_reader :description

        def initialize(type_info, spec = {})
          super
          @description = [type_info, spec].grep(Hash).filter_map { _1[:doc] }.first
        end
      end
    end
  end
end
