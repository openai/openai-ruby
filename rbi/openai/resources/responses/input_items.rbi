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
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            limit: Integer,
            order: OpenAI::Responses::InputItemListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(
            OpenAI::Internal::CursorPage[
              OpenAI::Responses::ResponseItem::Variants
            ]
          )
        end
        def list(
          # The ID of the response to retrieve input items for.
          response_id,
          # An item ID to list items after, used in pagination.
          after: nil,
          # Additional fields to include in the response. See the `include` parameter for
          # Response creation above for more information.
          include: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          limit: nil,
          # The order to return the input items in. Default is `desc`.
          #
          # - `asc`: Return the input items in ascending order.
          # - `desc`: Return the input items in descending order.
          order: nil,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
