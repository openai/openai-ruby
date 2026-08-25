# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # The unit of the `quantity` value. If no single supported unit applies to the
        # result, this field is `null`.
        module CostQuantityUnit
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::TOKENS }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::COST_QUANTITY_UNIT_1000_TOKENS }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::DURATION_SECONDS }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::DURATION_MINUTES }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::DURATION_HOURS }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::GIBIBYTE_HOURS }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::IMAGES }

          variant const: -> { OpenAI::Models::Admin::Organization::CostQuantityUnit::CHARACTERS }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Admin::Organization::CostQuantityUnit::TaggedSymbol) }
          end

          # @!group

          TOKENS = :tokens
          COST_QUANTITY_UNIT_1000_TOKENS = :"1000_tokens"
          DURATION_SECONDS = :duration_seconds
          DURATION_MINUTES = :duration_minutes
          DURATION_HOURS = :duration_hours
          GIBIBYTE_HOURS = :gibibyte_hours
          IMAGES = :images
          CHARACTERS = :characters

          # @!endgroup
        end
      end
    end
  end
end
