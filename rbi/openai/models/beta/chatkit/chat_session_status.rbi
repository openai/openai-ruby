# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        module ChatSessionStatus
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ChatKit::ChatSessionStatus)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ACTIVE =
            T.let(
              :active,
              OpenAI::Beta::ChatKit::ChatSessionStatus::TaggedSymbol
            )
          EXPIRED =
            T.let(
              :expired,
              OpenAI::Beta::ChatKit::ChatSessionStatus::TaggedSymbol
            )
          CANCELLED =
            T.let(
              :cancelled,
              OpenAI::Beta::ChatKit::ChatSessionStatus::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ChatKit::ChatSessionStatus::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
