# frozen_string_literal: true

module OpenAI
  module Models
    class CompoundFilter < OpenAI::BaseModel
      # @!attribute filters
      #   Array of filters to combine. Items can be `ComparisonFilter` or
      #     `CompoundFilter`.
      #
      #   @return [Array<OpenAI::Models::ComparisonFilter, Object>]
      required :filters, -> { OpenAI::ArrayOf[union: OpenAI::Models::CompoundFilter::Filter] }

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

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # @abstract
      #
      # A filter used to compare a specified attribute key to a given value using a
      #   defined comparison operation.
      class Filter < OpenAI::Union
        # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        variant -> { OpenAI::Models::ComparisonFilter }

        variant OpenAI::Unknown

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::ComparisonFilter, Object)]
        #     def variants; end
        #   end
      end

      # @abstract
      #
      # Type of operation: `and` or `or`.
      class Type < OpenAI::Enum
        AND = :and
        OR = :or

        finalize!
      end
    end
  end
end
