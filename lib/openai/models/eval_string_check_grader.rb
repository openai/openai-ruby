# frozen_string_literal: true

module OpenAI
  module Models
    class EvalStringCheckGrader < OpenAI::Internal::Type::BaseModel
      # @!attribute input
      #   The input text. This may include template strings.
      #
      #   @return [String]
      required :input, String

      # @!attribute name
      #   The name of the grader.
      #
      #   @return [String]
      required :name, String

      # @!attribute operation
      #   The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
      #
      #   @return [Symbol, OpenAI::Models::EvalStringCheckGrader::Operation]
      required :operation, enum: -> { OpenAI::Models::EvalStringCheckGrader::Operation }

      # @!attribute reference
      #   The reference text. This may include template strings.
      #
      #   @return [String]
      required :reference, String

      # @!attribute type
      #   The object type, which is always `string_check`.
      #
      #   @return [Symbol, :string_check]
      required :type, const: :string_check

      # @!parse
      #   # A StringCheckGrader object that performs a string comparison between input and
      #   # reference using a specified operation.
      #   #
      #   # @param input [String]
      #   # @param name [String]
      #   # @param operation [Symbol, OpenAI::Models::EvalStringCheckGrader::Operation]
      #   # @param reference [String]
      #   # @param type [Symbol, :string_check]
      #   #
      #   def initialize(input:, name:, operation:, reference:, type: :string_check, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
      #
      # @see OpenAI::Models::EvalStringCheckGrader#operation
      module Operation
        extend OpenAI::Internal::Type::Enum

        EQ = :eq
        NE = :ne
        LIKE = :like
        ILIKE = :ilike

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
