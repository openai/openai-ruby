# frozen_string_literal: true

module OpenAI
  module Models
    class ComparisonFilter < OpenAI::Internal::Type::BaseModel
      # @!attribute key
      #   The key to compare against the value.
      #
      #   @return [String]
      required :key, String

      # @!attribute type
      #   Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      #   - `eq`: equals
      #   - `ne`: not equal
      #   - `gt`: greater than
      #   - `gte`: greater than or equal
      #   - `lt`: less than
      #   - `lte`: less than or equal
      #
      #   @return [Symbol, OpenAI::Models::ComparisonFilter::Type]
      required :type, enum: -> { OpenAI::Models::ComparisonFilter::Type }

      # @!attribute value
      #   The value to compare against the attribute key; supports string, number, or
      #   boolean types.
      #
      #   @return [String, Float, Boolean]
      required :value, union: -> { OpenAI::Models::ComparisonFilter::Value }

      # @!method initialize(key:, type:, value:)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ComparisonFilter} for more details.
      #
      #   A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      #
      #   @param key [String] The key to compare against the value.
      #
      #   @param type [Symbol, OpenAI::Models::ComparisonFilter::Type] Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`. ...
      #
      #   @param value [String, Float, Boolean] The value to compare against the attribute key; supports string, number, or bool
      #   ...

      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      # - `eq`: equals
      # - `ne`: not equal
      # - `gt`: greater than
      # - `gte`: greater than or equal
      # - `lt`: less than
      # - `lte`: less than or equal
      #
      # @see OpenAI::Models::ComparisonFilter#type
      module Type
        extend OpenAI::Internal::Type::Enum

        EQ = :eq
        NE = :ne
        GT = :gt
        GTE = :gte
        LT = :lt
        LTE = :lte

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The value to compare against the attribute key; supports string, number, or
      # boolean types.
      #
      # @see OpenAI::Models::ComparisonFilter#value
      module Value
        extend OpenAI::Internal::Type::Union

        variant String

        variant Float

        variant OpenAI::Internal::Type::Boolean

        # @!method self.variants
        #   @return [Array(String, Float, Boolean)]
      end
    end
  end
end
