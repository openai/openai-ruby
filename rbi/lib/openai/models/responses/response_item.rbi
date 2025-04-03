# typed: strong

module OpenAI
  module Models
    module Responses
      # Content item used to generate a response.
      module ResponseItem
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [OpenAI::Models::Responses::ResponseInputMessageItem, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem]
            )
        end
        def self.variants
        end
      end
    end
  end
end
