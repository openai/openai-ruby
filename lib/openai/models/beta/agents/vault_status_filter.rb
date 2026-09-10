# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # One or more lifecycle statuses to include when listing vaults or credentials.
        module VaultStatusFilter
          extend OpenAI::Internal::Type::Union

          # Whether a vault or credential is active or archived.
          variant enum: -> { OpenAI::Beta::Agents::VaultStatus }

          variant -> { OpenAI::Models::Beta::Agents::VaultStatusFilter::VaultStatusArray }

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Beta::Agents::VaultStatus, Array<Symbol, OpenAI::Models::Beta::Agents::VaultStatus>)]

          # @type [OpenAI::Internal::Type::Converter]
          VaultStatusArray = OpenAI::Internal::Type::ArrayOf[
            enum: -> { OpenAI::Models::Beta::Agents::VaultStatus }
          ]
        end
      end
    end
  end
end
