# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class StringCheckGrader < OpenAI::Internal::Type::BaseModel
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
        #   @return [Symbol, OpenAI::Models::Graders::StringCheckGrader::Operation]
        required :operation, enum: -> { OpenAI::Graders::StringCheckGrader::Operation }

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

        # @!method initialize(input:, name:, operation:, reference:, type: :string_check)
        #   A StringCheckGrader object that performs a string comparison between input and
        #   reference using a specified operation.
        #
        #   @param input [String] The input text. This may include template strings.
        #
        #   @param name [String] The name of the grader.
        #
        #   @param operation [Symbol, OpenAI::Models::Graders::StringCheckGrader::Operation] The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
        #
        #   @param reference [String] The reference text. This may include template strings.
        #
        #   @param type [Symbol, :string_check] The object type, which is always `string_check`.

        # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
        #
        # @see OpenAI::Models::Graders::StringCheckGrader#operation
        module Operation
          extend OpenAI::Internal::Type::Enum

          EQ = :eq
          NE = :ne
          LIKE = :like
          ILIKE = :ilike

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    StringCheckGrader = Graders::StringCheckGrader
  end
end
