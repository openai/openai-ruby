# typed: strong

module OpenAI
  module Models

    module Live

      class MediaSessionForkConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::MediaSessionForkConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        # session. Trusted sideband connections are unaffected.
        sig { returns(T.nilable(OpenAI::Live::ClientConfig)) }
        attr_reader :client

        sig { params(client: OpenAI::Live::ClientConfig::OrHash).void }
        attr_writer :client

        # Update the Responses backend for an existing Live session without changing
        # delegation ownership.
        sig { returns(T.nilable(OpenAI::Live::MediaSessionForkConfig::Delegation)) }
        attr_reader :delegation

        sig { params(delegation: OpenAI::Live::MediaSessionForkConfig::Delegation::OrHash).void }
        attr_writer :delegation

        # Whether to store the forked session. Omission inherits the stored session's
        # setting.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :store

        sig { params(store: T::Boolean).void }
        attr_writer :store

        # Optional overrides for a stored Live session. Omitted settings are inherited.
        # The model, voice, frontend instructions, and prior conversation come from the
        # stored session. WebRTC negotiates its audio format; audio.format is only
        # supported on WebSocket forks.
        sig do
          params(

            client: OpenAI::Live::ClientConfig::OrHash,

            delegation: OpenAI::Live::MediaSessionForkConfig::Delegation::OrHash,

            store: T::Boolean
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
          # session. Trusted sideband connections are unaffected.
          client: nil,

          # Update the Responses backend for an existing Live session without changing
          # delegation ownership.
          delegation: nil,

          # Whether to store the forked session. Omission inherits the stored session's
          # setting.

          store: nil
        )
        end

        sig do
          override.returns(
            {
              client: OpenAI::Live::ClientConfig,
              delegation: OpenAI::Live::MediaSessionForkConfig::Delegation,
              store: T::Boolean
            }
          )
        end
        def to_hash
        end

        class Delegation < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::MediaSessionForkConfig::Delegation,
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

      end

    end

  end
end
