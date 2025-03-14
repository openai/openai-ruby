# typed: strong

module OpenAI
  module Resources
    class Responses
      class InputItems
        # Returns a list of input items for a given response.
        sig do
          params(
            response_id: String,
            after: String,
            before: String,
            limit: Integer,
            order: Symbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(
              OpenAI::CursorPage[
              T.any(
                OpenAI::Models::Responses::ResponseItemList::Data::Message,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCall,
                OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
              )
              ]
            )
        end
        def list(response_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
