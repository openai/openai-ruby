# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        module ChatSessionStatus
          extend OpenAI::Internal::Type::Enum

          ACTIVE = :active
          EXPIRED = :expired
          CANCELLED = :cancelled

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
