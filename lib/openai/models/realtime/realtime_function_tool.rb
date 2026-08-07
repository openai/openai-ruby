# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeFunctionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute description
        #   The description of the function, including guidance on when and how to call it,
        #   and guidance about what to tell the user when calling (if anything).
        #
        #   @return [String, nil]
        optional :description, String

        # @!attribute name
        #   The name of the function.
        #
        #   @return [String, nil]
        optional :name, String

        # @!attribute parameters
        #   Parameters of the function in JSON Schema.
        #
        #   @return [Object, nil]
        optional :parameters, OpenAI::Internal::Type::Unknown

        # @!attribute type
        #   The type of the tool, i.e. `function`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeFunctionTool::Type, nil]
        optional :type, enum: -> { OpenAI::Realtime::RealtimeFunctionTool::Type }

        # @!method initialize(description: nil, name: nil, parameters: nil, type: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeFunctionTool} for more details.
        #
        #   @param description [String] The description of the function, including guidance on when and how
        #
        #   @param name [String] The name of the function.
        #
        #   @param parameters [Object] Parameters of the function in JSON Schema.
        #
        #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeFunctionTool::Type] The type of the tool, i.e. `function`.

        # The type of the tool, i.e. `function`.
        #
        # @see OpenAI::Models::Realtime::RealtimeFunctionTool#type
        module Type
          extend OpenAI::Internal::Type::Enum

          FUNCTION = :function

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
