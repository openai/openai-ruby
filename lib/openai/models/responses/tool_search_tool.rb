# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the tool. Always `tool_search`.
        #
        #   @return [Symbol, :tool_search]
        required :type, const: :tool_search

        # @!attribute description
        #   Description shown to the model for a client-executed tool search tool.
        #
        #   @return [String, nil]
        optional :description, String, nil?: true

        # @!attribute execution
        #   Whether tool search is executed by the server or by the client.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolSearchTool::Execution, nil]
        optional :execution, enum: -> { OpenAI::Responses::ToolSearchTool::Execution }

        # @!attribute parameters
        #   Parameter schema for a client-executed tool search tool.
        #
        #   @return [Object, nil]
        optional :parameters, OpenAI::Internal::Type::Unknown, nil?: true

        # @!method initialize(description: nil, execution: nil, parameters: nil, type: :tool_search)
        #   Hosted or BYOT tool search configuration for deferred tools.
        #
        #   @param description [String, nil] Description shown to the model for a client-executed tool search tool.
        #
        #   @param execution [Symbol, OpenAI::Models::Responses::ToolSearchTool::Execution] Whether tool search is executed by the server or by the client.
        #
        #   @param parameters [Object, nil] Parameter schema for a client-executed tool search tool.
        #
        #   @param type [Symbol, :tool_search] The type of the tool. Always `tool_search`.

        # Whether tool search is executed by the server or by the client.
        #
        # @see OpenAI::Models::Responses::ToolSearchTool#execution
        module Execution
          extend OpenAI::Internal::Type::Enum

          SERVER = :server
          CLIENT = :client

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
