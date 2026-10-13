# frozen_string_literal: true

require_relative "../../../models/responses/response_output_text"
require_relative "../../../models/responses/response_function_tool_call"

module OpenAI
  module Models
    module Responses
      class ResponseOutputText
        response_only do
          # @!attribute parsed
          #   The parsed contents of the output, if JSON schema is specified.
          #
          #   @return [Object, nil]
          optional :parsed, OpenAI::StructuredOutput::ParsedJson
        end
      end

      class ResponseFunctionToolCall
        response_only do
          # @!attribute parsed
          #   The parsed contents of the arguments.
          #
          #   @return [Object, nil]
          required :parsed, OpenAI::StructuredOutput::ParsedJson
        end
      end
    end
  end
end
