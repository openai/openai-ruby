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

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::CustomTool::AllowedCaller>, nil]
        optional :allowed_callers,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::CustomTool::AllowedCaller] },
                 nil?: true

        # @!attribute defer_loading
        #   Whether this tool should be deferred and discovered via tool search.
        #
        #   @return [Boolean, nil]
        optional :defer_loading, OpenAI::Internal::Type::Boolean

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

        # @!method initialize(name:, allowed_callers: nil, defer_loading: nil, description: nil, format_: nil, type: :custom)
        #   A custom tool that processes input using a specified format. Learn more about
        #   [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
        #
        #   @param name [String] The name of the custom tool, used to identify it in tool calls.
        #
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Responses::CustomTool::AllowedCaller>, nil] The tool invocation context(s).
        #
        #   @param defer_loading [Boolean] Whether this tool should be deferred and discovered via tool search.
        #
        #   @param description [String] Optional description of the custom tool, used to provide more context.
        #
        #   @param format_ [OpenAI::Models::CustomToolInputFormat::Text, OpenAI::Models::CustomToolInputFormat::Grammar] The input format for the custom tool. Default is unconstrained text.
        #
        #   @param type [Symbol, :custom] The type of the custom tool. Always `custom`.

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
