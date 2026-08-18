# typed: strong

module OpenAI
  module Models
    module Beta
      class ChatKitWorkflow < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::ChatKitWorkflow, OpenAI::Internal::AnyHash)
          end

        # Identifier of the workflow backing the session.
        sig { returns(String) }
        attr_accessor :id

        # State variable key-value pairs applied when invoking the workflow. Defaults to
        # null when no overrides were provided.
        sig do
          returns(
            T.nilable(
              T::Hash[
                Symbol,
                OpenAI::Beta::ChatKitWorkflow::StateVariable::Variants
              ]
            )
          )
        end
        attr_accessor :state_variables

        # Tracing settings applied to the workflow.
        sig { returns(OpenAI::Beta::ChatKitWorkflow::Tracing) }
        attr_reader :tracing

        sig do
          params(tracing: OpenAI::Beta::ChatKitWorkflow::Tracing::OrHash).void
        end
        attr_writer :tracing

        # Specific workflow version used for the session. Defaults to null when using the
        # latest deployment.
        sig { returns(T.nilable(String)) }
        attr_accessor :version

        # Workflow metadata and state returned for the session.
        sig do
          params(
            id: String,
            state_variables:
              T.nilable(
                T::Hash[
                  Symbol,
                  OpenAI::Beta::ChatKitWorkflow::StateVariable::Variants
                ]
              ),
            tracing: OpenAI::Beta::ChatKitWorkflow::Tracing::OrHash,
            version: T.nilable(String)
          ).returns(T.attached_class)
        end
        def self.new(
          # Identifier of the workflow backing the session.
          id:,
          # State variable key-value pairs applied when invoking the workflow. Defaults to
          # null when no overrides were provided.
          state_variables:,
          # Tracing settings applied to the workflow.
          tracing:,
          # Specific workflow version used for the session. Defaults to null when using the
          # latest deployment.
          version:
        )
        end

        sig do
          override.returns(
            {
              id: String,
              state_variables:
                T.nilable(
                  T::Hash[
                    Symbol,
                    OpenAI::Beta::ChatKitWorkflow::StateVariable::Variants
                  ]
                ),
              tracing: OpenAI::Beta::ChatKitWorkflow::Tracing,
              version: T.nilable(String)
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
              T::Array[OpenAI::Beta::ChatKitWorkflow::StateVariable::Variants]
            )
          end
          def self.variants
          end
        end

        class Tracing < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKitWorkflow::Tracing,
                OpenAI::Internal::AnyHash
              )
            end

          # Indicates whether tracing is enabled.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # Tracing settings applied to the workflow.
          sig { params(enabled: T::Boolean).returns(T.attached_class) }
          def self.new(
            # Indicates whether tracing is enabled.
            enabled:
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
