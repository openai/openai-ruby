# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # @abstract
      #
      # Ruby does not have a "boolean" Class, this is something for models to refer to.
      class Boolean < OpenAI::Internal::Type::Boolean
        extend OpenAI::Helpers::StructuredOutput::JsonSchemaConverter
        # rubocop:disable Lint/UnusedMethodArgument

        # @api private
        #
        # @param state [Hash{Symbol=>Object}]
        #
        #   @option state [Hash{Object=>String}] :defs
        #
        #   @option state [Array<String>] :path
        #
        # @return [Hash{Symbol=>Object}]
        def self.to_json_schema_inner(state:) = {type: "boolean"}

        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end
