# frozen_string_literal: true

module OpenAI
  module Models
    class ComparisonFilter < OpenAI::BaseModel
      # @!attribute key
      #   The key to compare against the value.
      #
      #   @return [String]
      required :key, String

      # @!attribute type
      #   Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      #     - `eq`: equals
      #     - `ne`: not equal
      #     - `gt`: greater than
      #     - `gte`: greater than or equal
      #     - `lt`: less than
      #     - `lte`: less than or equal
      #
      #   @return [Symbol, OpenAI::Models::ComparisonFilter::Type]
      required :type, enum: -> { OpenAI::Models::ComparisonFilter::Type }

      # @!attribute value
      #   The value to compare against the attribute key; supports string, number, or
      #     boolean types.
      #
      #   @return [String, Float, Boolean]
      required :value, union: -> { OpenAI::Models::ComparisonFilter::Value }

      # @!parse
      #   # A filter used to compare a specified attribute key to a given value using a
      #   #   defined comparison operation.
      #   #
      #   # @param key [String]
      #   # @param type [Symbol, OpenAI::Models::ComparisonFilter::Type]
      #   # @param value [String, Float, Boolean]
      #   #
      #   def initialize(key:, type:, value:, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # @abstract
      #
      # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
      #
      #   - `eq`: equals
      #   - `ne`: not equal
      #   - `gt`: greater than
      #   - `gte`: greater than or equal
      #   - `lt`: less than
      #   - `lte`: less than or equal
      class Type < OpenAI::Enum
        EQ = :eq
        NE = :ne
        GT = :gt
        GTE = :gte
        LT = :lt
        LTE = :lte

        finalize!
      end

      # @abstract
      #
      # The value to compare against the attribute key; supports string, number, or
      #   boolean types.
      class Value < OpenAI::Union
        variant String

        variant Float

        variant OpenAI::BooleanModel
      end
    end
  end
end
