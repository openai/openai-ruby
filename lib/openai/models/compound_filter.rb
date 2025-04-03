# frozen_string_literal: true

module OpenAI
  module Models
    class CompoundFilter < OpenAI::Internal::Type::BaseModel
      # @!attribute filters
      #   Array of filters to combine. Items can be `ComparisonFilter` or
      #     `CompoundFilter`.
      #
      #   @return [Array<OpenAI::Models::ComparisonFilter, Object>]
      required :filters, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::CompoundFilter::Filter] }

      # @!attribute type
      #   Type of operation: `and` or `or`.
      #
      #   @return [Symbol, OpenAI::Models::CompoundFilter::Type]
      required :type, enum: -> { OpenAI::Models::CompoundFilter::Type }

      # @!parse
      #   # Combine multiple filters using `and` or `or`.
      #   #
      #   # @param filters [Array<OpenAI::Models::ComparisonFilter, Object>]
      #   # @param type [Symbol, OpenAI::Models::CompoundFilter::Type]
      #   #
      #   def initialize(filters:, type:, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      module Filter
        extend OpenAI::Internal::Type::Union

        # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        variant -> { OpenAI::Models::ComparisonFilter }

        variant OpenAI::Internal::Type::Unknown

        # @!parse
        #   # @return [Array(OpenAI::Models::ComparisonFilter, Object)]
        #   def self.variants; end
      end

      # Type of operation: `and` or `or`.
      #
      # @see OpenAI::Models::CompoundFilter#type
      module Type
        extend OpenAI::Internal::Type::Enum

        AND = :and
        OR = :or

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
