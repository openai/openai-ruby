# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class PeriodicAutomation < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::PeriodicAutomation,
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

          # The cron expression determining scheduled occurrences.
          sig { returns(String) }
          attr_accessor :expression

          # Custom string key-value pairs attached to the automation.
          sig { returns(T::Hash[Symbol, String]) }
          attr_accessor :metadata

          # The automation's display name.
          sig { returns(String) }
          attr_accessor :name

          # Always `agent.automation`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Whether scheduled delivery is active or paused.
          sig { returns(OpenAI::Beta::Agents::PeriodicAutomation::Status::TaggedSymbol) }
          attr_accessor :status

          # The session configuration or existing session receiving invocations.
          sig { returns(OpenAI::Beta::Agents::AutomationTarget::Variants) }
          attr_accessor :target

          # The timezone used to interpret the expression.
          sig { returns(String) }
          attr_accessor :timezone

          # The type of the object. Always `periodic`.
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

              expression: String,

              metadata: T::Hash[Symbol, String],

              name: String,

              status: OpenAI::Beta::Agents::PeriodicAutomation::Status::OrSymbol,

              target: T.any(
                OpenAI::Beta::Agents::AutomationTarget::NewSession::OrHash,
                OpenAI::Beta::Agents::AutomationTarget::ExistingSession::OrHash
              ),

              timezone: String,

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

            # The cron expression determining scheduled occurrences.
            expression:,

            # Custom string key-value pairs attached to the automation.
            metadata:,

            # The automation's display name.
            name:,

            # Whether scheduled delivery is active or paused.
            status:,

            # The session configuration or existing session receiving invocations.
            target:,

            # The timezone used to interpret the expression.
            timezone:,

            # Always `agent.automation`.
            object: :"agent.automation",

            # The type of the object. Always `periodic`.

            type: :periodic
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                created_by: OpenAI::Beta::Agents::AutomationCreatedBy::Variants,
                expression: String,
                metadata: T::Hash[Symbol, String],
                name: String,
                object: Symbol,
                status: OpenAI::Beta::Agents::PeriodicAutomation::Status::TaggedSymbol,
                target: OpenAI::Beta::Agents::AutomationTarget::Variants,
                timezone: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # Whether scheduled delivery is active or paused.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::PeriodicAutomation::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ACTIVE = T.let(:active, OpenAI::Beta::Agents::PeriodicAutomation::Status::TaggedSymbol)
            PAUSED = T.let(:paused, OpenAI::Beta::Agents::PeriodicAutomation::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Agents::PeriodicAutomation::Status::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
