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
      #   Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`,
      #   `nin`.
      #
      #   - `eq`: equals
      #   - `ne`: not equal
      #   - `gt`: greater than
      #   - `gte`: greater than or equal
      #   - `lt`: less than
      #   - `lte`: less than or equal
      #   - `in`: in
      #   - `nin`: not in
      #
      #   @return [Symbol, OpenAI::Models::ComparisonFilter::Type]
      required :type, enum: -> { OpenAI::ComparisonFilter::Type }

      # @!attribute value
      #   The value to compare against the attribute key; supports string, number, or
      #   boolean types.
      #
      #   @return [String, Float, Boolean, Array<String, Float>]
      required :value, union: -> { OpenAI::ComparisonFilter::Value }

      # @!method initialize(key:, type:, value:)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ComparisonFilter} for more details.
      #
      #   A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      #
      #   @param key [String] The key to compare against the value.
      #
      #   @param type [Symbol, OpenAI::Models::ComparisonFilter::Type] Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `
      #
      #   @param value [String, Float, Boolean, Array<String, Float>] The value to compare against the attribute key; supports string, number, or bool

      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`,
      # `nin`.
      #
      # - `eq`: equals
      # - `ne`: not equal
      # - `gt`: greater than
      # - `gte`: greater than or equal
      # - `lt`: less than
      # - `lte`: less than or equal
      # - `in`: in
      # - `nin`: not in
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

        variant -> { OpenAI::Models::ComparisonFilter::Value::UnionMember3Array }

        module UnionMember3
          extend OpenAI::Internal::Type::Union

          variant String

          variant Float

          # @!method self.variants
          #   @return [Array(String, Float)]
        end

        # @!method self.variants
        #   @return [Array(String, Float, Boolean, Array<String, Float>)]

        # @type [OpenAI::Internal::Type::Converter]
        UnionMember3Array =
          OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::ComparisonFilter::Value::UnionMember3 }]
      end
    end
  end
end
