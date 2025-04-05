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

      # @!parse
      #   # A filter used to compare a specified attribute key to a given value using a
      #   # defined comparison operation.
      #   #
      #   # @param key [String]
      #   # @param type [Symbol, OpenAI::Models::ComparisonFilter::Type]
      #   # @param value [String, Float, Boolean]
      #   #
      #   def initialize(key:, type:, value:, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

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

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
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

        # @!parse
        #   # @return [Array(String, Float, Boolean)]
        #   def self.variants; end
      end
    end
  end
end
