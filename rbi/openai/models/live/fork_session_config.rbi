# typed: strong

module OpenAI
  module Models

    module Live

      class ForkSessionConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ForkSessionConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # Audio format for a WebSocket fork. WebRTC forks negotiate their audio format and
        # must omit this field.
        sig { returns(T.nilable(OpenAI::Live::ForkSessionConfig::Audio)) }
        attr_reader :audio

        sig { params(audio: OpenAI::Live::ForkSessionConfig::Audio::OrHash).void }
        attr_writer :audio

        # Frontend data-channel permissions for a WebRTC fork. Omitted permissions inherit
        # the stored values. Not supported for WebSocket forks.
        sig { returns(T.nilable(OpenAI::Live::ClientConfig)) }
        attr_reader :client

        sig { params(client: OpenAI::Live::ClientConfig::OrHash).void }
        attr_writer :client

        # Overrides for the stored session’s Responses backend. Only supported when the
        # stored session already uses Responses delegation; the delegation type cannot
        # change.
        sig { returns(T.nilable(OpenAI::Live::ForkSessionConfig::Delegation)) }
        attr_reader :delegation

        sig { params(delegation: OpenAI::Live::ForkSessionConfig::Delegation::OrHash).void }
        attr_writer :delegation

        # Whether to store the forked session. Omission inherits the stored session's
        # setting.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :store

        sig { params(store: T::Boolean).void }
        attr_writer :store

        # Overrides for a stored session after connecting to the fork WebSocket. An empty
        # object inherits the stored configuration; do not supply a new model.
        # audio.format applies only to the new WebSocket connection. client overrides are
        # only supported for WebRTC forks.
        sig do
          params(

            audio: OpenAI::Live::ForkSessionConfig::Audio::OrHash,

            client: OpenAI::Live::ClientConfig::OrHash,

            delegation: OpenAI::Live::ForkSessionConfig::Delegation::OrHash,

            store: T::Boolean
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Audio format for a WebSocket fork. WebRTC forks negotiate their audio format and
          # must omit this field.
          audio: nil,

          # Frontend data-channel permissions for a WebRTC fork. Omitted permissions inherit
          # the stored values. Not supported for WebSocket forks.
          client: nil,

          # Overrides for the stored session’s Responses backend. Only supported when the
          # stored session already uses Responses delegation; the delegation type cannot
          # change.
          delegation: nil,

          # Whether to store the forked session. Omission inherits the stored session's
          # setting.

          store: nil
        )
        end

        sig do
          override.returns(
            {
              audio: OpenAI::Live::ForkSessionConfig::Audio,
              client: OpenAI::Live::ClientConfig,
              delegation: OpenAI::Live::ForkSessionConfig::Delegation,
              store: T::Boolean
            }
          )
        end
        def to_hash
        end

        class Audio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ForkSessionConfig::Audio,
              OpenAI::Internal::AnyHash
            )
          end

          # Audio encoding and sample rate for audio sent and received over a Live WebSocket
          # connection. WebRTC and SIP negotiate their media format separately.
          sig {
            returns(
              T.nilable(
                T.any(
                  OpenAI::Live::AudioFormat::AudioPCM,
                  OpenAI::Live::AudioFormat::AudioPCMU,
                  OpenAI::Live::AudioFormat::AudioPCMA
                )
              )
            )
          }
          attr_reader :format_

          sig {
            params(
              format_: T.any(
                OpenAI::Live::AudioFormat::AudioPCM::OrHash,
                OpenAI::Live::AudioFormat::AudioPCMU::OrHash,
                OpenAI::Live::AudioFormat::AudioPCMA::OrHash
              )
            )
              .void
          }
          attr_writer :format_

          # Audio format for a WebSocket fork. WebRTC forks negotiate their audio format and
          # must omit this field.
          sig do
            params(

              format_: T.any(
                OpenAI::Live::AudioFormat::AudioPCM::OrHash,
                OpenAI::Live::AudioFormat::AudioPCMU::OrHash,
                OpenAI::Live::AudioFormat::AudioPCMA::OrHash
              )
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Audio encoding and sample rate for audio sent and received over a Live WebSocket
            # connection. WebRTC and SIP negotiate their media format separately.

            format_: nil
          )
          end

          sig do
            override.returns(
              {
                format_: T.any(
                  OpenAI::Live::AudioFormat::AudioPCM,
                  OpenAI::Live::AudioFormat::AudioPCMU,
                  OpenAI::Live::AudioFormat::AudioPCMA
                )
              }
            )
          end
          def to_hash
          end

        end

        class Delegation < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::ForkSessionConfig::Delegation,
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

          # Overrides for the stored session’s Responses backend. Only supported when the
          # stored session already uses Responses delegation; the delegation type cannot
          # change.
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
