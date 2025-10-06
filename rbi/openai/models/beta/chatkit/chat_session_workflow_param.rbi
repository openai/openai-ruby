# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionWorkflowParam < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionWorkflowParam,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier for the workflow invoked by the session.
          sig { returns(String) }
          attr_accessor :id

          # State variables forwarded to the workflow. Keys may be up to 64 characters,
          # values must be primitive types, and the map defaults to an empty object.
          sig do
            returns(
              T.nilable(
                T::Hash[
                  Symbol,
                  OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::StateVariable::Variants
                ]
              )
            )
          end
          attr_reader :state_variables

          sig do
            params(
              state_variables:
                T::Hash[
                  Symbol,
                  OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::StateVariable::Variants
                ]
            ).void
          end
          attr_writer :state_variables

          # Optional tracing overrides for the workflow invocation. When omitted, tracing is
          # enabled by default.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::Tracing
              )
            )
          end
          attr_reader :tracing

          sig do
            params(
              tracing:
                OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::Tracing::OrHash
            ).void
          end
          attr_writer :tracing

          # Specific workflow version to run. Defaults to the latest deployed version.
          sig { returns(T.nilable(String)) }
          attr_reader :version

          sig { params(version: String).void }
          attr_writer :version

          # Workflow reference and overrides applied to the chat session.
          sig do
            params(
              id: String,
              state_variables:
                T::Hash[
                  Symbol,
                  OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::StateVariable::Variants
                ],
              tracing:
                OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::Tracing::OrHash,
              version: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the workflow invoked by the session.
            id:,
            # State variables forwarded to the workflow. Keys may be up to 64 characters,
            # values must be primitive types, and the map defaults to an empty object.
            state_variables: nil,
            # Optional tracing overrides for the workflow invocation. When omitted, tracing is
            # enabled by default.
            tracing: nil,
            # Specific workflow version to run. Defaults to the latest deployed version.
            version: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                state_variables:
                  T::Hash[
                    Symbol,
                    OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::StateVariable::Variants
                  ],
                tracing:
                  OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::Tracing,
                version: String
              }
            )
          end
          def to_hash
          end

          module StateVariable
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, T::Boolean, Float) }

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::StateVariable::Variants
                ]
              )
            end
            def self.variants
            end
          end

          class Tracing < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::Tracing,
                  OpenAI::Internal::AnyHash
                )
              end

            # Whether tracing is enabled during the session. Defaults to true.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :enabled

            sig { params(enabled: T::Boolean).void }
            attr_writer :enabled

            # Optional tracing overrides for the workflow invocation. When omitted, tracing is
            # enabled by default.
            sig { params(enabled: T::Boolean).returns(T.attached_class) }
            def self.new(
              # Whether tracing is enabled during the session. Defaults to true.
              enabled: nil
            )
            end

            sig { override.returns({ enabled: T::Boolean }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
