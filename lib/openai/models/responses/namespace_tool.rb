# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class NamespaceTool < OpenAI::Internal::Type::BaseModel
        # @!attribute description
        #   A description of the namespace shown to the model.
        #
        #   @return [String]
        required :description, String

        # @!attribute name
        #   The namespace name used in tool calls (for example, `crm`).
        #
        #   @return [String]
        required :name, String

        # @!attribute tools
        #   The function/custom tools available inside this namespace.
        #
        #   @return [Array<OpenAI::Models::Responses::NamespaceTool::Tool::Function, OpenAI::Models::Responses::CustomTool>]
        required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::NamespaceTool::Tool] }

        # @!attribute type
        #   The type of the tool. Always `namespace`.
        #
        #   @return [Symbol, :namespace]
        required :type, const: :namespace

        # @!method initialize(description:, name:, tools:, type: :namespace)
        #   Groups function/custom tools under a shared namespace.
        #
        #   @param description [String] A description of the namespace shown to the model.
        #
        #   @param name [String] The namespace name used in tool calls (for example, `crm`).
        #
        #   @param tools [Array<OpenAI::Models::Responses::NamespaceTool::Tool::Function, OpenAI::Models::Responses::CustomTool>] The function/custom tools available inside this namespace.
        #
        #   @param type [Symbol, :namespace] The type of the tool. Always `namespace`.

        # A function or custom tool that belongs to a namespace.
        module Tool
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :function, -> { OpenAI::Responses::NamespaceTool::Tool::Function }

          # A custom tool that processes input using a specified format. Learn more about   [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
          variant :custom, -> { OpenAI::Responses::CustomTool }

          class Function < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute type
            #
            #   @return [Symbol, :function]
            required :type, const: :function

            # @!attribute allowed_callers
            #   The tool invocation context(s).
            #
            #   @return [Array<Symbol, OpenAI::Models::Responses::NamespaceTool::Tool::Function::AllowedCaller>, nil]
            optional :allowed_callers,
                     -> {
                       OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller]
                     },
                     nil?: true

            # @!attribute defer_loading
            #   Whether this function should be deferred and discovered via tool search.
            #
            #   @return [Boolean, nil]
            optional :defer_loading, OpenAI::Internal::Type::Boolean

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String, nil?: true

            # @!attribute output_schema
            #   A JSON Schema describing the JSON value encoded in string outputs for this
            #   function tool. This does not describe content-array outputs.
            #
            #   @return [Hash{Symbol=>Object}, nil]
            optional :output_schema,
                     OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
                     nil?: true

            # @!attribute parameters
            #
            #   @return [Object, nil]
            optional :parameters, OpenAI::Internal::Type::Unknown, nil?: true

            # @!attribute strict
            #   Whether to enforce strict parameter validation. If omitted, Responses attempts
            #   to use strict validation when the schema is compatible, and falls back to
            #   non-strict validation otherwise.
            #
            #   @return [Boolean, nil]
            optional :strict, OpenAI::Internal::Type::Boolean, nil?: true

            # @!method initialize(name:, allowed_callers: nil, defer_loading: nil, description: nil, output_schema: nil, parameters: nil, strict: nil, type: :function)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::NamespaceTool::Tool::Function} for more details.
            #
            #   @param name [String]
            #
            #   @param allowed_callers [Array<Symbol, OpenAI::Models::Responses::NamespaceTool::Tool::Function::AllowedCaller>, nil] The tool invocation context(s).
            #
            #   @param defer_loading [Boolean] Whether this function should be deferred and discovered via tool search.
            #
            #   @param description [String, nil]
            #
            #   @param output_schema [Hash{Symbol=>Object}, nil] A JSON Schema describing the JSON value encoded in string outputs for this funct
            #
            #   @param parameters [Object, nil]
            #
            #   @param strict [Boolean, nil] Whether to enforce strict parameter validation. If omitted, Responses attempts t
            #
            #   @param type [Symbol, :function]

            module AllowedCaller
              extend OpenAI::Internal::Type::Enum

              DIRECT = :direct
              PROGRAMMATIC = :programmatic

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::NamespaceTool::Tool::Function, OpenAI::Models::Responses::CustomTool)]
        end
      end
    end
  end
end
