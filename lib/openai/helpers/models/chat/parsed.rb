# frozen_string_literal: true

require_relative "../../../models/chat/chat_completion_message"
require_relative "../../../models/chat/chat_completion_message_function_tool_call"

module OpenAI
  module Models
    module Chat
      class ChatCompletionMessage
        response_only do
          # @!attribute parsed
          #   The parsed contents of the message, if JSON schema is specified.
          #
          #   @return [Object, nil]
          optional :parsed, OpenAI::StructuredOutput::ParsedJson
        end
      end

      class ChatCompletionMessageFunctionToolCall
        class Function
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
end
