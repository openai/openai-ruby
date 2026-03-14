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

            # Whether this function should be deferred and discovered via tool search.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :defer_loading

            sig { params(defer_loading: T::Boolean).void }
            attr_writer :defer_loading

            sig { returns(T.nilable(String)) }
            attr_accessor :description

            sig { returns(T.nilable(T.anything)) }
            attr_accessor :parameters

            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :strict

            sig do
              params(
                name: String,
                defer_loading: T::Boolean,
                description: T.nilable(String),
                parameters: T.nilable(T.anything),
                strict: T.nilable(T::Boolean),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              name:,
              # Whether this function should be deferred and discovered via tool search.
              defer_loading: nil,
              description: nil,
              parameters: nil,
              strict: nil,
              type: :function
            )
            end

            sig do
              override.returns(
                {
                  name: String,
                  type: Symbol,
                  defer_loading: T::Boolean,
                  description: T.nilable(String),
                  parameters: T.nilable(T.anything),
                  strict: T.nilable(T::Boolean)
                }
              )
            end
            def to_hash
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
