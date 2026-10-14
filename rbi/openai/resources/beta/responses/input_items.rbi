# typed: strong

module OpenAI
  module Resources
    class Beta
      class Responses
        class InputItems
          # Returns a list of input items for a given response.
          sig do
            params(
              response_id: String,
              after: String,
              include: T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol],
              limit: Integer,
              order:
                OpenAI::Beta::Responses::InputItemListParams::Order::OrSymbol,
              betas:
                T::Array[
                  OpenAI::Beta::Responses::InputItemListParams::Beta::OrSymbol
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::CursorPage[
                OpenAI::Beta::BetaResponseItem::Variants
              ]
            )
          end
          def list(
            # Path param: The ID of the response to retrieve input items for.
            response_id,
            # Query param: An item ID to list items after, used in pagination.
            after: nil,
            # Query param: Additional fields to include in the response. See the `include`
            # parameter for Response creation above for more information.
            include: nil,
            # Query param: A limit on the number of objects to be returned. Limit can range
            # between 1 and 100, and the default is 20.
            limit: nil,
            # Query param: The order to return the input items in. Default is `desc`.
            #
            # - `asc`: Return the input items in ascending order.
            # - `desc`: Return the input items in descending order.
            order: nil,
            # Header param: Optional beta features to enable for this request.
            betas: nil,
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
end
