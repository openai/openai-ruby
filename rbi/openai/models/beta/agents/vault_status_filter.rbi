# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # One or more lifecycle statuses to include when listing vaults or credentials.
        module VaultStatusFilter
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::VaultStatus::TaggedSymbol,
              T::Array[OpenAI::Beta::Agents::VaultStatus::TaggedSymbol]
            )
          end

          sig { override.returns(T::Array[OpenAI::Beta::Agents::VaultStatusFilter::Variants]) }
          def self.variants
          end

          VaultStatusArray = T.let(
            OpenAI::Internal::Type::ArrayOf[
              enum: OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::Agents::VaultStatus]
            ],
            OpenAI::Internal::Type::Converter
          )

        end

      end

    end

  end
end
