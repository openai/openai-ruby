# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaFunctionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!attribute parameters
        #   A JSON schema object describing the parameters of the function.
        #
        #   @return [Hash{Symbol=>Object}, nil]
        required :parameters, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown], nil?: true

        # @!attribute strict
        #   Whether strict parameter validation is enforced for this function tool.
        #
        #   @return [Boolean, nil]
        required :strict, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute type
        #   The type of the function tool. Always `function`.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::BetaFunctionTool::AllowedCaller>, nil]
        optional :allowed_callers,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaFunctionTool::AllowedCaller] },
                 nil?: true

        # @!attribute defer_loading
        #   Whether this function is deferred and loaded via tool search.
        #
        #   @return [Boolean, nil]
        optional :defer_loading, OpenAI::Internal::Type::Boolean

        # @!attribute description
        #   A description of the function. Used by the model to determine whether or not to
        #   call the function.
        #
        #   @return [String, nil]
        optional :description, String, nil?: true

        # @!attribute output_schema
        #   A JSON schema object describing the JSON value encoded in string outputs for
        #   this function.
        #
        #   @return [Hash{Symbol=>Object}, nil]
        optional :output_schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown], nil?: true

        # @!method initialize(name:, parameters:, strict:, allowed_callers: nil, defer_loading: nil, description: nil, output_schema: nil, type: :function)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaFunctionTool} for more details.
        #
        #   Defines a function in your own code the model can choose to call. Learn more
        #   about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
        #
        #   @param name [String] The name of the function to call.
        #
        #   @param parameters [Hash{Symbol=>Object}, nil] A JSON schema object describing the parameters of the function.
        #
        #   @param strict [Boolean, nil] Whether strict parameter validation is enforced for this function tool.
        #
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Beta::BetaFunctionTool::AllowedCaller>, nil] The tool invocation context(s).
        #
        #   @param defer_loading [Boolean] Whether this function is deferred and loaded via tool search.
        #
        #   @param description [String, nil] A description of the function. Used by the model to determine whether or not to
        #
        #   @param output_schema [Hash{Symbol=>Object}, nil] A JSON schema object describing the JSON value encoded in string outputs for thi
        #
        #   @param type [Symbol, :function] The type of the function tool. Always `function`.

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    BetaFunctionTool = Beta::BetaFunctionTool
  end
end
