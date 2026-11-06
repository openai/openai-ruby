# typed: strong

module OpenAI
  module Models

    module Live

      class SessionUpdateConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionUpdateConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Delegation settings to update. The delegation type must match the current
        # session; omitted settings retain their values.
        sig {
          returns(
            T.nilable(
              T.any(
                OpenAI::Live::ClientDelegation,
                OpenAI::Live::SessionUpdateConfig::Delegation::Responses,
                OpenAI::Live::SessionUpdateConfig::Delegation::Decisions
              )
            )
          )
        }
        attr_accessor :delegation

        # At most one Decisions trigger per transcript event type. Triggers run
        # independently of delegation. On update, omit triggers to keep the current
        # configuration, send a list to replace it, or send an empty list to disable
        # triggers.
        sig { returns(T.nilable(T::Array[OpenAI::Live::DecisionTrigger])) }
        attr_reader :triggers

        sig { params(triggers: T::Array[OpenAI::Live::DecisionTrigger::OrHash]).void }
        attr_writer :triggers

        # Changes to an active Live session's delegation settings and transcript triggers.
        sig do
          params(

            delegation: T.nilable(
              T.any(
                OpenAI::Live::ClientDelegation::OrHash,
                OpenAI::Live::SessionUpdateConfig::Delegation::Responses::OrHash,
                OpenAI::Live::SessionUpdateConfig::Delegation::Decisions::OrHash
              )
            ),

            triggers: T::Array[OpenAI::Live::DecisionTrigger::OrHash]
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Delegation settings to update. The delegation type must match the current
          # session; omitted settings retain their values.
          delegation: nil,

          # At most one Decisions trigger per transcript event type. Triggers run
          # independently of delegation. On update, omit triggers to keep the current
          # configuration, send a list to replace it, or send an empty list to disable
          # triggers.

          triggers: nil
        )
        end

        sig do
          override.returns(
            {
              delegation: T.nilable(
                T.any(
                  OpenAI::Live::ClientDelegation,
                  OpenAI::Live::SessionUpdateConfig::Delegation::Responses,
                  OpenAI::Live::SessionUpdateConfig::Delegation::Decisions
                )
              ),
              triggers: T::Array[OpenAI::Live::DecisionTrigger]
            }
          )
        end
        def to_hash
        end

        # Delegation settings to update. The delegation type must match the current
        # session; omitted settings retain their values.
        module Delegation
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::ClientDelegation,
              OpenAI::Live::SessionUpdateConfig::Delegation::Responses,
              OpenAI::Live::SessionUpdateConfig::Delegation::Decisions
            )
          }

          class Responses < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::SessionUpdateConfig::Delegation::Responses,
                OpenAI::Internal::AnyHash
              )
            end

            # The delegation owner. Always `responses` for tasks handled by the Responses API.
            sig { returns(Symbol) }
            attr_accessor :type

            # Milliseconds to wait before requesting an automatic spoken acknowledgement for a
            # delegation. The model may still speak before this delay. Any commentary or
            # thinking appended to the session cancels all pending acknowledgements, including
            # those for other delegations. Defaults to 400 for Decisions sessions and 0
            # (request immediately) for other sessions. Omission in a session update preserves
            # the current value. Updates apply to subsequent delegations.
            sig { returns(T.nilable(Integer)) }
            attr_reader :acknowledgement_delay_ms

            sig { params(acknowledgement_delay_ms: Integer).void }
            attr_writer :acknowledgement_delay_ms

            # Responses backend settings to update. Omitted settings keep their existing
            # values.
            sig { returns(T.nilable(OpenAI::Live::ResponsesDelegationUpdateConfig)) }
            attr_reader :responses

            sig { params(responses: OpenAI::Live::ResponsesDelegationUpdateConfig::OrHash).void }
            attr_writer :responses

            # Update the Responses backend for an existing Live session without changing
            # delegation ownership.
            sig do
              params(

                acknowledgement_delay_ms: Integer,

                responses: OpenAI::Live::ResponsesDelegationUpdateConfig::OrHash,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Milliseconds to wait before requesting an automatic spoken acknowledgement for a
              # delegation. The model may still speak before this delay. Any commentary or
              # thinking appended to the session cancels all pending acknowledgements, including
              # those for other delegations. Defaults to 400 for Decisions sessions and 0
              # (request immediately) for other sessions. Omission in a session update preserves
              # the current value. Updates apply to subsequent delegations.
              acknowledgement_delay_ms: nil,

              # Responses backend settings to update. Omitted settings keep their existing
              # values.
              responses: nil,

              # The delegation owner. Always `responses` for tasks handled by the Responses API.

              type: :responses
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  acknowledgement_delay_ms: Integer,
                  responses: OpenAI::Live::ResponsesDelegationUpdateConfig
                }
              )
            end
            def to_hash
            end

          end

          class Decisions < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::SessionUpdateConfig::Delegation::Decisions,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Symbol) }
            attr_accessor :type

            # Milliseconds to wait before requesting an automatic spoken acknowledgement for a
            # delegation. The model may still speak before this delay. Any commentary or
            # thinking appended to the session cancels all pending acknowledgements, including
            # those for other delegations. Defaults to 400 for Decisions sessions and 0
            # (request immediately) for other sessions. Omission in a session update preserves
            # the current value. Updates apply to subsequent delegations.
            sig { returns(T.nilable(Integer)) }
            attr_reader :acknowledgement_delay_ms

            sig { params(acknowledgement_delay_ms: Integer).void }
            attr_writer :acknowledgement_delay_ms

            sig { returns(T.nilable(OpenAI::Live::DecisionsDelegationUpdateConfig)) }
            attr_reader :decisions

            sig { params(decisions: OpenAI::Live::DecisionsDelegationUpdateConfig::OrHash).void }
            attr_writer :decisions

            sig do
              params(

                acknowledgement_delay_ms: Integer,

                decisions: OpenAI::Live::DecisionsDelegationUpdateConfig::OrHash,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Milliseconds to wait before requesting an automatic spoken acknowledgement for a
              # delegation. The model may still speak before this delay. Any commentary or
              # thinking appended to the session cancels all pending acknowledgements, including
              # those for other delegations. Defaults to 400 for Decisions sessions and 0
              # (request immediately) for other sessions. Omission in a session update preserves
              # the current value. Updates apply to subsequent delegations.
              acknowledgement_delay_ms: nil,

              decisions: nil,

              type: :decisions
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  acknowledgement_delay_ms: Integer,
                  decisions: OpenAI::Live::DecisionsDelegationUpdateConfig
                }
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::SessionUpdateConfig::Delegation::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
