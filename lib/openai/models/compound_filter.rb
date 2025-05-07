# frozen_string_literal: true

module OpenAI
  module Models
    class CompoundFilter < OpenAI::Internal::Type::BaseModel
      # @!attribute filters
      #   Array of filters to combine. Items can be `ComparisonFilter` or
      #   `CompoundFilter`.
      #
      #   @return [Array<OpenAI::ComparisonFilter, Object>]
      required :filters, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::CompoundFilter::Filter] }

      # @!attribute type
      #   Type of operation: `and` or `or`.
      #
      #   @return [Symbol, OpenAI::CompoundFilter::Type]
      required :type, enum: -> { OpenAI::CompoundFilter::Type }

      # @!method initialize(filters:, type:)
      #   Some parameter documentations has been truncated, see {OpenAI::CompoundFilter}
      #   for more details.
      #
      #   Combine multiple filters using `and` or `or`.
      #
      #   @param filters [Array<OpenAI::ComparisonFilter, Object>] Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`
      #
      #   @param type [Symbol, OpenAI::CompoundFilter::Type] Type of operation: `and` or `or`.

      # A filter used to compare a specified attribute key to a given value using a
      # defined comparison operation.
      module Filter
        extend OpenAI::Internal::Type::Union

        # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        variant -> { OpenAI::ComparisonFilter }

        variant OpenAI::Internal::Type::Unknown

        # @!method self.variants
        #   @return [Array(OpenAI::ComparisonFilter, Object)]
      end

      # Type of operation: `and` or `or`.
      #
      # @see OpenAI::CompoundFilter#type
      module Type
        extend OpenAI::Internal::Type::Enum

        AND = :and
        OR = :or

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
