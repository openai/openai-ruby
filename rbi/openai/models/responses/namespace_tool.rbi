# typed: strong

module OpenAI
  module Models
    module Responses
      class NamespaceTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::NamespaceTool, OpenAI::Internal::AnyHash)
          end

        # A description of the namespace shown to the model.
        sig { returns(String) }
        attr_accessor :description

        # The namespace name used in tool calls (for example, `crm`).
        sig { returns(String) }
        attr_accessor :name

        # The function/custom tools available inside this namespace.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::NamespaceTool::Tool::Function,
                OpenAI::Responses::CustomTool
              )
            ]
          )
        end
        attr_accessor :tools

        # The type of the tool. Always `namespace`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Groups function/custom tools under a shared namespace.
        sig do
          params(
            description: String,
            name: String,
            tools:
              T::Array[
                T.any(
                  OpenAI::Responses::NamespaceTool::Tool::Function::OrHash,
                  OpenAI::Responses::CustomTool::OrHash
                )
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A description of the namespace shown to the model.
          description:,
          # The namespace name used in tool calls (for example, `crm`).
          name:,
          # The function/custom tools available inside this namespace.
          tools:,
          # The type of the tool. Always `namespace`.
          type: :namespace
        )
        end

        sig do
          override.returns(
            {
              description: String,
              name: String,
              tools:
                T::Array[
                  T.any(
                    OpenAI::Responses::NamespaceTool::Tool::Function,
                    OpenAI::Responses::CustomTool
                  )
                ],
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # A function or custom tool that belongs to a namespace.
        module Tool
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::NamespaceTool::Tool::Function,
                OpenAI::Responses::CustomTool
              )
            end

          class Function < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::NamespaceTool::Tool::Function,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :name

            sig { returns(Symbol) }
            attr_accessor :type

            # The tool invocation context(s).
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller::OrSymbol
                  ]
                )
              )
            end
            attr_accessor :allowed_callers

            # Whether this function should be deferred and discovered via tool search.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :defer_loading

            sig { params(defer_loading: T::Boolean).void }
            attr_writer :defer_loading

            sig { returns(T.nilable(String)) }
            attr_accessor :description

            # A JSON Schema describing the JSON value encoded in string outputs for this
            # function tool. This does not describe content-array outputs.
            sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
            attr_accessor :output_schema

            sig { returns(T.nilable(T.anything)) }
            attr_accessor :parameters

            # Whether to enforce strict parameter validation. If omitted, Responses attempts
            # to use strict validation when the schema is compatible, and falls back to
            # non-strict validation otherwise.
            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :strict

            sig do
              params(
                name: String,
                allowed_callers:
                  T.nilable(
                    T::Array[
                      OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller::OrSymbol
                    ]
                  ),
                defer_loading: T::Boolean,
                description: T.nilable(String),
                output_schema: T.nilable(T::Hash[Symbol, T.anything]),
                parameters: T.nilable(T.anything),
                strict: T.nilable(T::Boolean),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              name:,
              # The tool invocation context(s).
              allowed_callers: nil,
              # Whether this function should be deferred and discovered via tool search.
              defer_loading: nil,
              description: nil,
              # A JSON Schema describing the JSON value encoded in string outputs for this
              # function tool. This does not describe content-array outputs.
              output_schema: nil,
              parameters: nil,
              # Whether to enforce strict parameter validation. If omitted, Responses attempts
              # to use strict validation when the schema is compatible, and falls back to
              # non-strict validation otherwise.
              strict: nil,
              type: :function
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
                        OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller::OrSymbol
                      ]
                    ),
                  defer_loading: T::Boolean,
                  description: T.nilable(String),
                  output_schema: T.nilable(T::Hash[Symbol, T.anything]),
                  parameters: T.nilable(T.anything),
                  strict: T.nilable(T::Boolean)
                }
              )
            end
            def to_hash
            end

            module AllowedCaller
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              DIRECT =
                T.let(
                  :direct,
                  OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller::TaggedSymbol
                )
              PROGRAMMATIC =
                T.let(
                  :programmatic,
                  OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Responses::NamespaceTool::Tool::Function::AllowedCaller::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Responses::NamespaceTool::Tool::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
