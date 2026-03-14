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

            # @!attribute defer_loading
            #   Whether this function should be deferred and discovered via tool search.
            #
            #   @return [Boolean, nil]
            optional :defer_loading, OpenAI::Internal::Type::Boolean

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String, nil?: true

            # @!attribute parameters
            #
            #   @return [Object, nil]
            optional :parameters, OpenAI::Internal::Type::Unknown, nil?: true

            # @!attribute strict
            #
            #   @return [Boolean, nil]
            optional :strict, OpenAI::Internal::Type::Boolean, nil?: true

            # @!method initialize(name:, defer_loading: nil, description: nil, parameters: nil, strict: nil, type: :function)
            #   @param name [String]
            #
            #   @param defer_loading [Boolean] Whether this function should be deferred and discovered via tool search.
            #
            #   @param description [String, nil]
            #
            #   @param parameters [Object, nil]
            #
            #   @param strict [Boolean, nil]
            #
            #   @param type [Symbol, :function]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::NamespaceTool::Tool::Function, OpenAI::Models::Responses::CustomTool)]
        end
      end
    end
  end
end
