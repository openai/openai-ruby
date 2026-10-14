# typed: strong

module OpenAI
  module Models

    module Responses

      # An extensible enum describing why accepted steering input is still queued.
      # Clients should handle unknown values because additional reasons may be
      # introduced. Known values include:
      #
      # - `waiting_for_required_input`: The response is waiting for the tool results or
      #   approval decisions identified by `required_input`.
      module ResponseSteerPendingReason
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            Symbol,
            String
          )
        end

        sig { override.returns(T::Array[OpenAI::Responses::ResponseSteerPendingReason::Variants]) }
        def self.variants
        end

      end

    end

  end
end
