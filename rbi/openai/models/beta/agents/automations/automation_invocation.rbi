# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        AutomationInvocation = Automations::AutomationInvocation

        module Automations

          class AutomationInvocation < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Automations::AutomationInvocation,
                OpenAI::Internal::AnyHash
              )
            end

            # The invocation ID.
            sig { returns(String) }
            attr_accessor :id

            # The automation that owns the invocation.
            sig { returns(String) }
            attr_accessor :automation_id

            # The creation time as a Unix timestamp in seconds.
            sig { returns(Integer) }
            attr_accessor :created_at

            # The permanent delivery failure, or null when no failure occurred.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Automations::AutomationInvocation::Error)) }
            attr_reader :error

            sig {
              params(error: T.nilable(OpenAI::Beta::Agents::Automations::AutomationInvocation::Error::OrHash)).void
            }
            attr_writer :error

            # Always `agent.automation.invocation`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The intended occurrence as a Unix timestamp in seconds, or null for manual runs.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :scheduled_at

            # The target or newly created session ID, or null before one is available.
            sig { returns(T.nilable(String)) }
            attr_accessor :session_id

            # Why an occurrence was skipped, or null when it was not skipped.
            sig { returns(T.nilable(Symbol)) }
            attr_accessor :skip_reason

            # Whether the invocation was manual or scheduled.
            sig { returns(OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Variants) }
            attr_accessor :source

            # Delivery status; completed does not mean the agent's work has finished.
            sig { returns(OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol) }
            attr_accessor :status

            # One attempted delivery by an automation.
            sig do
              params(

                id: String,

                automation_id: String,

                created_at: Integer,

                error: T.nilable(OpenAI::Beta::Agents::Automations::AutomationInvocation::Error::OrHash),

                scheduled_at: T.nilable(Integer),

                session_id: T.nilable(String),

                source: T.any(
                  OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Manual::OrHash,
                  OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Automation::OrHash
                ),

                status: OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::OrSymbol,

                object: Symbol,

                skip_reason: T.nilable(Symbol)
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The invocation ID.
              id:,

              # The automation that owns the invocation.
              automation_id:,

              # The creation time as a Unix timestamp in seconds.
              created_at:,

              # The permanent delivery failure, or null when no failure occurred.
              error:,

              # The intended occurrence as a Unix timestamp in seconds, or null for manual runs.
              scheduled_at:,

              # The target or newly created session ID, or null before one is available.
              session_id:,

              # Whether the invocation was manual or scheduled.
              source:,

              # Delivery status; completed does not mean the agent's work has finished.
              status:,

              # Always `agent.automation.invocation`.
              object: :"agent.automation.invocation",

              # Why an occurrence was skipped, or null when it was not skipped.

              skip_reason: :pending_delivery
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  automation_id: String,
                  created_at: Integer,
                  error: T.nilable(OpenAI::Beta::Agents::Automations::AutomationInvocation::Error),
                  object: Symbol,
                  scheduled_at: T.nilable(Integer),
                  session_id: T.nilable(String),
                  skip_reason: T.nilable(Symbol),
                  source: OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Variants,
                  status: OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            class Error < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Automations::AutomationInvocation::Error,
                  OpenAI::Internal::AnyHash
                )
              end

              # A machine-readable error code.
              sig { returns(String) }
              attr_accessor :code

              # A public explanation of the delivery failure.
              sig { returns(String) }
              attr_accessor :message

              # The permanent delivery failure, or null when no failure occurred.
              sig do
                params(

                  code: String,

                  message: String
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # A machine-readable error code.
                code:,

                # A public explanation of the delivery failure.

                message:
              )
              end

              sig do
                override.returns(
                  {code: String, message: String}
                )
              end
              def to_hash
              end

            end

            # Delivery status; completed does not mean the agent's work has finished.
            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Beta::Agents::Automations::AutomationInvocation::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              QUEUED = T.let(:queued, OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol)
              COMPLETED = T.let(
                :completed,
                OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol
              )
              FAILED = T.let(:failed, OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol)
              SKIPPED = T.let(:skipped, OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol)

              sig {
                override.returns(
                  T::Array[OpenAI::Beta::Agents::Automations::AutomationInvocation::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end

          end

        end

      end

    end

  end
end
