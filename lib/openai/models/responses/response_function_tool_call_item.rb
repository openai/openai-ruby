# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCallItem < OpenAI::Models::Responses::ResponseFunctionToolCall
        # @!attribute id
        #   The unique ID of the function tool call.
        #
        #   @return [String]
        required :id, String

        # @!method initialize(id:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseFunctionToolCallItem} for more details.
        #
        #   A tool call to run a function. See the
        #   [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        #   for more information.
        #
        #   @param id [String] The unique ID of the function tool call.
      end
    end
  end
end
