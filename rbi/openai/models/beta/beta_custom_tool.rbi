# typed: strong

module OpenAI
  module Models
    BetaCustomTool = Beta::BetaCustomTool

    module Beta
      class BetaCustomTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::BetaCustomTool, OpenAI::Internal::AnyHash)
          end

        # The name of the custom tool, used to identify it in tool calls.
        sig { returns(String) }
        attr_accessor :name

        # The type of the custom tool. Always `custom`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The tool invocation context(s).
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Beta::BetaCustomTool::AllowedCaller::OrSymbol]
            )
          )
        end
        attr_accessor :allowed_callers

        # Whether this tool should be deferred and discovered via tool search.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :defer_loading

        sig { params(defer_loading: T::Boolean).void }
        attr_writer :defer_loading

        # Optional description of the custom tool, used to provide more context.
        sig { returns(T.nilable(String)) }
        attr_reader :description

        sig { params(description: String).void }
        attr_writer :description

        # The input format for the custom tool. Default is unconstrained text.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::BetaCustomTool::Format::Text,
                OpenAI::Beta::BetaCustomTool::Format::Grammar
              )
            )
          )
        end
        attr_reader :format_

        sig do
          params(
            format_:
              T.any(
                OpenAI::Beta::BetaCustomTool::Format::Text::OrHash,
                OpenAI::Beta::BetaCustomTool::Format::Grammar::OrHash
              )
          ).void
        end
        attr_writer :format_

        # A custom tool that processes input using a specified format. Learn more about
        # [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools)
        sig do
          params(
            name: String,
            allowed_callers:
              T.nilable(
                T::Array[OpenAI::Beta::BetaCustomTool::AllowedCaller::OrSymbol]
              ),
            defer_loading: T::Boolean,
            description: String,
            format_:
              T.any(
                OpenAI::Beta::BetaCustomTool::Format::Text::OrHash,
                OpenAI::Beta::BetaCustomTool::Format::Grammar::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the custom tool, used to identify it in tool calls.
          name:,
          # The tool invocation context(s).
          allowed_callers: nil,
          # Whether this tool should be deferred and discovered via tool search.
          defer_loading: nil,
          # Optional description of the custom tool, used to provide more context.
          description: nil,
          # The input format for the custom tool. Default is unconstrained text.
          format_: nil,
          # The type of the custom tool. Always `custom`.
          type: :custom
        )
        end

        sig do
          override.returns(
            {
              name: String,
              type: Symbol,
              allowed_callers:
                T.nilable(
                  T::Array[
                    OpenAI::Beta::BetaCustomTool::AllowedCaller::OrSymbol
                  ]
                ),
              defer_loading: T::Boolean,
              description: String,
              format_:
                T.any(
                  OpenAI::Beta::BetaCustomTool::Format::Text,
                  OpenAI::Beta::BetaCustomTool::Format::Grammar
                )
            }
          )
        end
        def to_hash
        end

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaCustomTool::AllowedCaller)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DIRECT =
            T.let(
              :direct,
              OpenAI::Beta::BetaCustomTool::AllowedCaller::TaggedSymbol
            )
          PROGRAMMATIC =
            T.let(
              :programmatic,
              OpenAI::Beta::BetaCustomTool::AllowedCaller::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaCustomTool::AllowedCaller::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The input format for the custom tool. Default is unconstrained text.
        module Format
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaCustomTool::Format::Text,
                OpenAI::Beta::BetaCustomTool::Format::Grammar
              )
            end

          class Text < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaCustomTool::Format::Text,
                  OpenAI::Internal::AnyHash
                )
              end

            # Unconstrained text format. Always `text`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Unconstrained free-form text.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(
              # Unconstrained text format. Always `text`.
              type: :text
            )
            end

            sig { override.returns({ type: Symbol }) }
            def to_hash
            end
          end

          class Grammar < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaCustomTool::Format::Grammar,
                  OpenAI::Internal::AnyHash
                )
              end

            # The grammar definition.
            sig { returns(String) }
            attr_accessor :definition

            # The syntax of the grammar definition. One of `lark` or `regex`.
            sig do
              returns(
                OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax::OrSymbol
              )
            end
            attr_accessor :syntax

            # Grammar format. Always `grammar`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A grammar defined by the user.
            sig do
              params(
                definition: String,
                syntax:
                  OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax::OrSymbol,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The grammar definition.
              definition:,
              # The syntax of the grammar definition. One of `lark` or `regex`.
              syntax:,
              # Grammar format. Always `grammar`.
              type: :grammar
            )
            end

            sig do
              override.returns(
                {
                  definition: String,
                  syntax:
                    OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax::OrSymbol,
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            # The syntax of the grammar definition. One of `lark` or `regex`.
            module Syntax
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              LARK =
                T.let(
                  :lark,
                  OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax::TaggedSymbol
                )
              REGEX =
                T.let(
                  :regex,
                  OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::BetaCustomTool::Format::Grammar::Syntax::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::BetaCustomTool::Format::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
