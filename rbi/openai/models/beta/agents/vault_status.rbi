# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # Whether a vault or credential is active or archived.
        module VaultStatus
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::VaultStatus) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ACTIVE = T.let(:active, OpenAI::Beta::Agents::VaultStatus::TaggedSymbol)
          ARCHIVED = T.let(:archived, OpenAI::Beta::Agents::VaultStatus::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::Agents::VaultStatus::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
