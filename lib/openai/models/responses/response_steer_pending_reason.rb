# frozen_string_literal: true

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

        variant const: :waiting_for_required_input

        variant String

        # @!method self.variants
        #   @return [Array(Symbol, :waiting_for_required_input, String)]
      end
    end
  end
end
