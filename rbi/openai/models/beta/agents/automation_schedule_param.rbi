# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # Creates an automation without invoking it immediately.
        module AutomationScheduleParam
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationScheduleParam::Periodic,
              OpenAI::Beta::Agents::AutomationScheduleParam::Once
            )
          end

          class Periodic < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationScheduleParam::Periodic,
                OpenAI::Internal::AnyHash
              )
            end

            # A standard five-field cron expression defining scheduled occurrences.
            sig { returns(String) }
            attr_accessor :expression

            # A human-readable name for the automation.
            sig { returns(String) }
            attr_accessor :name

            # The session an automation invocation targets.
            sig {
              returns(
                T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                  OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
                )
              )
            }
            attr_accessor :target

            # The IANA timezone used to interpret the cron expression.
            sig { returns(String) }
            attr_accessor :timezone

            # The type of the object. Always `periodic`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_reader :metadata

            sig { params(metadata: T::Hash[Symbol, String]).void }
            attr_writer :metadata

            sig do
              params(

                expression: String,

                name: String,

                target: T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::OrHash,
                  OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession::OrHash
                ),

                timezone: String,

                metadata: T::Hash[Symbol, String],

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # A standard five-field cron expression defining scheduled occurrences.
              expression:,

              # A human-readable name for the automation.
              name:,

              # The session an automation invocation targets.
              target:,

              # The IANA timezone used to interpret the cron expression.
              timezone:,

              metadata: nil,

              # The type of the object. Always `periodic`.

              type: :periodic
            )
            end

            sig do
              override.returns(
                {
                  expression: String,
                  name: String,
                  target: T.any(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                    OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
                  ),
                  timezone: String,
                  type: Symbol,
                  metadata: T::Hash[Symbol, String]
                }
              )
            end
            def to_hash
            end

          end

          class Once < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::AutomationScheduleParam::Once,
                OpenAI::Internal::AnyHash
              )
            end

            # A human-readable name for the automation.
            sig { returns(String) }
            attr_accessor :name

            # A future Unix timestamp in seconds.
            sig { returns(Integer) }
            attr_accessor :run_at

            # The session an automation invocation targets.
            sig {
              returns(
                T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                  OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
                )
              )
            }
            attr_accessor :target

            # The type of the object. Always `once`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_reader :metadata

            sig { params(metadata: T::Hash[Symbol, String]).void }
            attr_writer :metadata

            sig do
              params(

                name: String,

                run_at: Integer,

                target: T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession::OrHash,
                  OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession::OrHash
                ),

                metadata: T::Hash[Symbol, String],

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # A human-readable name for the automation.
              name:,

              # A future Unix timestamp in seconds.
              run_at:,

              # The session an automation invocation targets.
              target:,

              metadata: nil,

              # The type of the object. Always `once`.

              type: :once
            )
            end

            sig do
              override.returns(
                {
                  name: String,
                  run_at: Integer,
                  target: T.any(
                    OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                    OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
                  ),
                  type: Symbol,
                  metadata: T::Hash[Symbol, String]
                }
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Beta::Agents::AutomationScheduleParam::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
