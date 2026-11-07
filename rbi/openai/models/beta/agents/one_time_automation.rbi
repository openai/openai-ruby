# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class OneTimeAutomation < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::OneTimeAutomation,
              OpenAI::Internal::AnyHash
            )
          end

          # The automation ID.
          sig { returns(String) }
          attr_accessor :id

          # The creation time as a Unix timestamp in seconds.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Service-recorded provenance; callers cannot supply this field.
          sig { returns(OpenAI::Beta::Agents::AutomationCreatedBy::Variants) }
          attr_accessor :created_by

          # Custom string key-value pairs attached to the automation.
          sig { returns(T::Hash[Symbol, String]) }
          attr_accessor :metadata

          # The automation's display name.
          sig { returns(String) }
          attr_accessor :name

          # Always `agent.automation`.
          sig { returns(Symbol) }
          attr_accessor :object

          # The Unix timestamp, in seconds, of the scheduled occurrence.
          sig { returns(Integer) }
          attr_accessor :run_at

          # Completion means the schedule has finished, not the agent's work.
          sig { returns(OpenAI::Beta::Agents::OneTimeAutomation::Status::TaggedSymbol) }
          attr_accessor :status

          # The session configuration or existing session receiving invocations.
          sig { returns(OpenAI::Beta::Agents::AutomationTarget::Variants) }
          attr_accessor :target

          # The type of the object. Always `once`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Fields shared by periodic and one-time automations.
          sig do
            params(

              id: String,

              created_at: Integer,

              created_by: T.any(
                OpenAI::Beta::Agents::AutomationCreatedBy::Developer::OrHash,
                OpenAI::Beta::Agents::AutomationCreatedBy::Agent::OrHash
              ),

              metadata: T::Hash[Symbol, String],

              name: String,

              run_at: Integer,

              status: OpenAI::Beta::Agents::OneTimeAutomation::Status::OrSymbol,

              target: T.any(
                OpenAI::Beta::Agents::AutomationTarget::NewSession::OrHash,
                OpenAI::Beta::Agents::AutomationTarget::ExistingSession::OrHash
              ),

              object: Symbol,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The automation ID.
            id:,

            # The creation time as a Unix timestamp in seconds.
            created_at:,

            # Service-recorded provenance; callers cannot supply this field.
            created_by:,

            # Custom string key-value pairs attached to the automation.
            metadata:,

            # The automation's display name.
            name:,

            # The Unix timestamp, in seconds, of the scheduled occurrence.
            run_at:,

            # Completion means the schedule has finished, not the agent's work.
            status:,

            # The session configuration or existing session receiving invocations.
            target:,

            # Always `agent.automation`.
            object: :"agent.automation",

            # The type of the object. Always `once`.

            type: :once
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                created_by: OpenAI::Beta::Agents::AutomationCreatedBy::Variants,
                metadata: T::Hash[Symbol, String],
                name: String,
                object: Symbol,
                run_at: Integer,
                status: OpenAI::Beta::Agents::OneTimeAutomation::Status::TaggedSymbol,
                target: OpenAI::Beta::Agents::AutomationTarget::Variants,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # Completion means the schedule has finished, not the agent's work.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::OneTimeAutomation::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ACTIVE = T.let(:active, OpenAI::Beta::Agents::OneTimeAutomation::Status::TaggedSymbol)
            PAUSED = T.let(:paused, OpenAI::Beta::Agents::OneTimeAutomation::Status::TaggedSymbol)
            COMPLETED = T.let(:completed, OpenAI::Beta::Agents::OneTimeAutomation::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Agents::OneTimeAutomation::Status::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
