# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        # The unit of the `quantity` value. If no single supported unit applies to the
        # result, this field is `null`.
        module CostQuantityUnit
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              String,
              OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol
            )
          end

          sig { override.returns(T::Array[OpenAI::Admin::Organization::CostQuantityUnit::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::Admin::Organization::CostQuantityUnit)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TOKENS = T.let(:tokens, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)
          COST_QUANTITY_UNIT_1000_TOKENS = T.let(
            :"1000_tokens",
            OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol
          )
          DURATION_SECONDS = T.let(:duration_seconds, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)
          DURATION_MINUTES = T.let(:duration_minutes, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)
          DURATION_HOURS = T.let(:duration_hours, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)
          GIBIBYTE_HOURS = T.let(:gibibyte_hours, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)
          IMAGES = T.let(:images, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)
          CHARACTERS = T.let(:characters, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol)

        end

      end

    end

  end
end
