# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class CustomTool < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the custom tool, used to identify it in tool calls.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The type of the custom tool. Always `custom`.
        #
        #   @return [Symbol, :custom]
        required :type, const: :custom

        # @!attribute description
        #   Optional description of the custom tool, used to provide more context.
        #
        #   @return [String, nil]
        optional :description, String

        # @!attribute format_
        #   The input format for the custom tool. Default is unconstrained text.
        #
        #   @return [OpenAI::Models::CustomToolInputFormat::Text, OpenAI::Models::CustomToolInputFormat::Grammar, nil]
        optional :format_, union: -> { OpenAI::CustomToolInputFormat }, api_name: :format

        # @!method initialize(name:, description: nil, format_: nil, type: :custom)
        #   @param name [String] The name of the custom tool, used to identify it in tool calls.
        #
        #   @param description [String] Optional description of the custom tool, used to provide more context.
        #
        #   @param format_ [OpenAI::Models::CustomToolInputFormat::Text, OpenAI::Models::CustomToolInputFormat::Grammar] The input format for the custom tool. Default is unconstrained text.
        #
        #   @param type [Symbol, :custom] The type of the custom tool. Always `custom`.
      end
    end
  end
end
