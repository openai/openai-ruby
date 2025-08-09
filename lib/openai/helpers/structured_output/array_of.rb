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
            OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.assoc_meta!(items, meta: @meta)

            {type: "array", items: items}
          end
        end
      end
    end
  end
end
