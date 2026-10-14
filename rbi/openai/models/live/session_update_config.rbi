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
            T.nilable(T.any(OpenAI::Live::ClientDelegation, OpenAI::Live::SessionUpdateConfig::Delegation::Responses))
          )
        }
        attr_accessor :delegation

        # Changes to an active Live session. Only delegation backend settings can be
        # updated after startup.
        sig do
          params(

            delegation: T.nilable(
              T.any(
                OpenAI::Live::ClientDelegation::OrHash,
                OpenAI::Live::SessionUpdateConfig::Delegation::Responses::OrHash
              )
            )
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Delegation settings to update. The delegation type must match the current
          # session; omitted settings retain their values.

          delegation: nil
        )
        end

        sig do
          override.returns(
            {
              delegation: T.nilable(
                T.any(OpenAI::Live::ClientDelegation, OpenAI::Live::SessionUpdateConfig::Delegation::Responses)
              )
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
            T.any(OpenAI::Live::ClientDelegation, OpenAI::Live::SessionUpdateConfig::Delegation::Responses)
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

                responses: OpenAI::Live::ResponsesDelegationUpdateConfig::OrHash,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Responses backend settings to update. Omitted settings keep their existing
              # values.
              responses: nil,

              # The delegation owner. Always `responses` for tasks handled by the Responses API.

              type: :responses
            )
            end

            sig do
              override.returns(
                {type: Symbol, responses: OpenAI::Live::ResponsesDelegationUpdateConfig}
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
