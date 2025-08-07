# typed: strong

module OpenAI
  module Models
    ChatCompletionCustomTool = Chat::ChatCompletionCustomTool

    module Chat
      class ChatCompletionCustomTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionCustomTool,
              OpenAI::Internal::AnyHash
            )
          end

        # Properties of the custom tool.
        sig { returns(OpenAI::Chat::ChatCompletionCustomTool::Custom) }
        attr_reader :custom

        sig do
          params(
            custom: OpenAI::Chat::ChatCompletionCustomTool::Custom::OrHash
          ).void
        end
        attr_writer :custom

        # The type of the custom tool. Always `custom`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A custom tool that processes input using a specified format.
        sig do
          params(
            custom: OpenAI::Chat::ChatCompletionCustomTool::Custom::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Properties of the custom tool.
          custom:,
          # The type of the custom tool. Always `custom`.
          type: :custom
        )
        end

        sig do
          override.returns(
            {
              custom: OpenAI::Chat::ChatCompletionCustomTool::Custom,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Custom < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionCustomTool::Custom,
                OpenAI::Internal::AnyHash
              )
            end

          # The name of the custom tool, used to identify it in tool calls.
          sig { returns(String) }
          attr_accessor :name

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
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text,
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar
                )
              )
            )
          end
          attr_reader :format_

          sig do
            params(
              format_:
                T.any(
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text::OrHash,
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::OrHash
                )
            ).void
          end
          attr_writer :format_

          # Properties of the custom tool.
          sig do
            params(
              name: String,
              description: String,
              format_:
                T.any(
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text::OrHash,
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::OrHash
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # The name of the custom tool, used to identify it in tool calls.
            name:,
            # Optional description of the custom tool, used to provide more context.
            description: nil,
            # The input format for the custom tool. Default is unconstrained text.
            format_: nil
          )
          end

          sig do
            override.returns(
              {
                name: String,
                description: String,
                format_:
                  T.any(
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text,
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar
                  )
              }
            )
          end
          def to_hash
          end

          # The input format for the custom tool. Default is unconstrained text.
          module Format
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text,
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar
                )
              end

            class Text < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Text,
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
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Your chosen grammar.
              sig do
                returns(
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar
                )
              end
              attr_reader :grammar

              sig do
                params(
                  grammar:
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::OrHash
                ).void
              end
              attr_writer :grammar

              # Grammar format. Always `grammar`.
              sig { returns(Symbol) }
              attr_accessor :type

              # A grammar defined by the user.
              sig do
                params(
                  grammar:
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::OrHash,
                  type: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Your chosen grammar.
                grammar:,
                # Grammar format. Always `grammar`.
                type: :grammar
              )
              end

              sig do
                override.returns(
                  {
                    grammar:
                      OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar,
                    type: Symbol
                  }
                )
              end
              def to_hash
              end

              class Grammar < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The grammar definition.
                sig { returns(String) }
                attr_accessor :definition

                # The syntax of the grammar definition. One of `lark` or `regex`.
                sig do
                  returns(
                    OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax::OrSymbol
                  )
                end
                attr_accessor :syntax

                # Your chosen grammar.
                sig do
                  params(
                    definition: String,
                    syntax:
                      OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax::OrSymbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The grammar definition.
                  definition:,
                  # The syntax of the grammar definition. One of `lark` or `regex`.
                  syntax:
                )
                end

                sig do
                  override.returns(
                    {
                      definition: String,
                      syntax:
                        OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax::OrSymbol
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
                        OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  LARK =
                    T.let(
                      :lark,
                      OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax::TaggedSymbol
                    )
                  REGEX =
                    T.let(
                      :regex,
                      OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Grammar::Grammar::Syntax::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Chat::ChatCompletionCustomTool::Custom::Format::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
