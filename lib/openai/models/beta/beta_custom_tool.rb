# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaCustomTool < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the custom tool, used to identify it in tool calls.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The type of the custom tool. Always `custom`.
        #
        #   @return [Symbol, :custom]
        required :type, const: :custom

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::BetaCustomTool::AllowedCaller>, nil]
        optional :allowed_callers,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaCustomTool::AllowedCaller] },
                 nil?: true

        # @!attribute defer_loading
        #   Whether this tool should be deferred and discovered via tool search.
        #
        #   @return [Boolean, nil]
        optional :defer_loading, OpenAI::Internal::Type::Boolean

        # @!attribute description
        #   Optional description of the custom tool, used to provide more context.
        #
        #   @return [String, nil]
        optional :description, String

        # @!attribute format_
        #   The input format for the custom tool. Default is unconstrained text.
        #
        #   @return [OpenAI::Models::Beta::BetaCustomTool::Format::Text, OpenAI::Models::Beta::BetaCustomTool::Format::Grammar, nil]
        optional :format_, union: -> { OpenAI::Beta::BetaCustomTool::Format }, api_name: :format

        # @!method initialize(name:, allowed_callers: nil, defer_loading: nil, description: nil, format_: nil, type: :custom)
        #   A custom tool that processes input using a specified format. Learn more about
        #   [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
        #
        #   @param name [String] The name of the custom tool, used to identify it in tool calls.
        #
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Beta::BetaCustomTool::AllowedCaller>, nil] The tool invocation context(s).
        #
        #   @param defer_loading [Boolean] Whether this tool should be deferred and discovered via tool search.
        #
        #   @param description [String] Optional description of the custom tool, used to provide more context.
        #
        #   @param format_ [OpenAI::Models::Beta::BetaCustomTool::Format::Text, OpenAI::Models::Beta::BetaCustomTool::Format::Grammar] The input format for the custom tool. Default is unconstrained text.
        #
        #   @param type [Symbol, :custom] The type of the custom tool. Always `custom`.

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The input format for the custom tool. Default is unconstrained text.
        #
        # @see OpenAI::Models::Beta::BetaCustomTool#format_
        module Format
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Unconstrained free-form text.
          variant :text, -> { OpenAI::Beta::BetaCustomTool::Format::Text }

          # A grammar defined by the user.
          variant :grammar, -> { OpenAI::Beta::BetaCustomTool::Format::Grammar }

          class Text < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Unconstrained text format. Always `text`.
            #
            #   @return [Symbol, :text]
            required :type, const: :text

            # @!method initialize(type: :text)
            #   Unconstrained free-form text.
            #
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
            #   @return [Symbol, OpenAI::Models::Beta::BetaCustomTool::Format::Grammar::Syntax]
            required :syntax, enum: -> { OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax }

            # @!attribute type
            #   Grammar format. Always `grammar`.
            #
            #   @return [Symbol, :grammar]
            required :type, const: :grammar

            # @!method initialize(definition:, syntax:, type: :grammar)
            #   A grammar defined by the user.
            #
            #   @param definition [String] The grammar definition.
            #
            #   @param syntax [Symbol, OpenAI::Models::Beta::BetaCustomTool::Format::Grammar::Syntax] The syntax of the grammar definition. One of `lark` or `regex`.
            #
            #   @param type [Symbol, :grammar] Grammar format. Always `grammar`.

            # The syntax of the grammar definition. One of `lark` or `regex`.
            #
            # @see OpenAI::Models::Beta::BetaCustomTool::Format::Grammar#syntax
            module Syntax
              extend OpenAI::Internal::Type::Enum

              LARK = :lark
              REGEX = :regex

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaCustomTool::Format::Text, OpenAI::Models::Beta::BetaCustomTool::Format::Grammar)]
        end
      end
    end

    BetaCustomTool = Beta::BetaCustomTool
  end
end
