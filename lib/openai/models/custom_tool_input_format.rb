# frozen_string_literal: true

module OpenAI
  module Models
    # The input format for the custom tool. Default is unconstrained text.
    module CustomToolInputFormat
      extend OpenAI::Internal::Type::Union

      discriminator :type

      variant :text, -> { OpenAI::CustomToolInputFormat::Text }

      variant :grammar, -> { OpenAI::CustomToolInputFormat::Grammar }

      class Text < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Unconstrained text format. Always `text`.
        #
        #   @return [Symbol, :text]
        required :type, const: :text

        # @!method initialize(type: :text)
        #   @param type [Symbol, :text] Unconstrained text format. Always `text`.
      end

      class Grammar < OpenAI::Internal::Type::BaseModel
        # @!attribute definition
        #   The grammar definition.
        #
        #   @return [String]
        required :definition, String

        # @!attribute syntax
        #   The syntax of the grammar definition. One of `lark` or `regex`.
        #
        #   @return [Symbol, OpenAI::Models::CustomToolInputFormat::Grammar::Syntax]
        required :syntax, enum: -> { OpenAI::CustomToolInputFormat::Grammar::Syntax }

        # @!attribute type
        #   Grammar format. Always `grammar`.
        #
        #   @return [Symbol, :grammar]
        required :type, const: :grammar

        # @!method initialize(definition:, syntax:, type: :grammar)
        #   @param definition [String] The grammar definition.
        #
        #   @param syntax [Symbol, OpenAI::Models::CustomToolInputFormat::Grammar::Syntax] The syntax of the grammar definition. One of `lark` or `regex`.
        #
        #   @param type [Symbol, :grammar] Grammar format. Always `grammar`.

        # The syntax of the grammar definition. One of `lark` or `regex`.
        #
        # @see OpenAI::Models::CustomToolInputFormat::Grammar#syntax
        module Syntax
          extend OpenAI::Internal::Type::Enum

          LARK = :lark
          REGEX = :regex

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      # @!method self.variants
      #   @return [Array(OpenAI::Models::CustomToolInputFormat::Text, OpenAI::Models::CustomToolInputFormat::Grammar)]
    end
  end
end
