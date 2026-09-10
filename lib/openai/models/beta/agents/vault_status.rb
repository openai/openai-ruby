# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # Whether a vault or credential is active or archived.
        module VaultStatus
          extend OpenAI::Internal::Type::Enum

          ACTIVE = :active
          ARCHIVED = :archived

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
