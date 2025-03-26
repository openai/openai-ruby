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
            include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
            limit: Integer,
            order: OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
          )
            .returns(
              OpenAI::CursorPage[
              T.any(
                OpenAI::Models::Responses::ResponseInputMessageItem,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCallOutputItem,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCallItem,
                OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem
              )
              ]
            )
        end
        def list(
          # The ID of the response to retrieve input items for.
          response_id,
          # An item ID to list items after, used in pagination.
          after: nil,
          # An item ID to list items before, used in pagination.
          before: nil,
          # Additional fields to include in the response. See the `include` parameter for
          #   Response creation above for more information.
          include: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          limit: nil,
          # The order to return the input items in. Default is `asc`.
          #
          #   - `asc`: Return the input items in ascending order.
          #   - `desc`: Return the input items in descending order.
          order: nil,
          request_options: {}
        )
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
