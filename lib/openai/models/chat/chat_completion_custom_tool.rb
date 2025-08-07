# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionCustomTool < OpenAI::Internal::Type::BaseModel
        # @!attribute custom
        #   Properties of the custom tool.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionCustomTool::Custom]
        required :custom, -> { OpenAI::Chat::ChatCompletionCustomTool::Custom }

        # @!attribute type
        #   The type of the custom tool. Always `custom`.
        #
        #   @return [Symbol, :custom]
        required :type, const: :custom

        # @!method initialize(custom:, type: :custom)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionCustomTool} for more details.
        #
        #   A custom tool that processes input using a specified format.
        #
        #   @param custom [OpenAI::Models::Chat::ChatCompletionCustomTool::Custom] Properties of the custom tool.
        #
        #   @param type [Symbol, :custom] The type of the custom tool. Always `custom`.

        # @see OpenAI::Models::Chat::ChatCompletionCustomTool#custom
        class Custom < OpenAI::Internal::Type::BaseModel
          # @!attribute name
          #   The name of the custom tool, used to identify it in tool calls.
          #
          #   @return [String]
          required :name, String

          # @!attribute description
          #   Optional description of the custom tool, used to provide more context.
          #
          #   @return [String, nil]
          optional :description, String

          # @!attribute format_
          #   The input format for the custom tool. Default is unconstrained text.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Text, OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar, nil]
          optional :format_,
                   union: -> {
                     OpenAI::Chat::ChatCompletionCustomTool::Custom::Format
                   },
                   api_name: :format

          # @!method initialize(name:, description: nil, format_: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Chat::ChatCompletionCustomTool::Custom} for more details.
          #
          #   Properties of the custom tool.
          #
          #   @param name [String] The name of the custom tool, used to identify it in tool calls.
          #
          #   @param description [String] Optional description of the custom tool, used to provide more context.
          #
          #   @param format_ [OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Text, OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar] The input format for the custom tool. Default is unconstrained text.

          # The input format for the custom tool. Default is unconstrained text.
          #
          # @see OpenAI::Models::Chat::ChatCompletionCustomTool::Custom#format_
          module Format
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Unconstrained free-form text.
            variant :text, -> { OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text }

            # A grammar defined by the user.
            variant :grammar, -> { OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar }

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
              # @!attribute grammar
              #   Your chosen grammar.
              #
              #   @return [OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar]
              required :grammar,
                       -> {
                         OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar
                       }

              # @!attribute type
              #   Grammar format. Always `grammar`.
              #
              #   @return [Symbol, :grammar]
              required :type, const: :grammar

              # @!method initialize(grammar:, type: :grammar)
              #   A grammar defined by the user.
              #
              #   @param grammar [OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar] Your chosen grammar.
              #
              #   @param type [Symbol, :grammar] Grammar format. Always `grammar`.

              # @see OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar#grammar
              class Grammar < OpenAI::Internal::Type::BaseModel
                # @!attribute definition
                #   The grammar definition.
                #
                #   @return [String]
                required :definition, String

                # @!attribute syntax
                #   The syntax of the grammar definition. One of `lark` or `regex`.
                #
                #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax]
                required :syntax,
                         enum: -> {
                           OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax
                         }

                # @!method initialize(definition:, syntax:)
                #   Your chosen grammar.
                #
                #   @param definition [String] The grammar definition.
                #
                #   @param syntax [Symbol, OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax] The syntax of the grammar definition. One of `lark` or `regex`.

                # The syntax of the grammar definition. One of `lark` or `regex`.
                #
                # @see OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar#syntax
                module Syntax
                  extend OpenAI::Internal::Type::Enum

                  LARK = :lark
                  REGEX = :regex

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Text, OpenAI::Models::Chat::ChatCompletionCustomTool::Custom::Format::Grammar)]
          end
        end
      end
    end

    ChatCompletionCustomTool = Chat::ChatCompletionCustomTool
  end
end
