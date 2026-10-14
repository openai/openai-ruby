# typed: strong

module OpenAI
  module Models

    module Live

      class SessionResource < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionResource,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live session. Use this ID for sideband connections,
        # forking, and recording download.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp, in seconds, at which the Live session expires.
        sig { returns(Integer) }
        attr_accessor :expires_at

        # The Live model. Required in the session configuration for every transport; do
        # not pass it as a URL query parameter.
        sig { returns(OpenAI::Live::SessionResource::Model::Variants) }
        attr_accessor :model

        # The status of the session snapshot. Always `active`, including the final
        # snapshot in session.closed; use the event type to determine that the session has
        # closed.
        sig { returns(Symbol) }
        attr_accessor :status

        # Startup audio configuration. Only primary WebSockets accept audio.format; WebRTC
        # and SIP negotiate their media format. Voice and format are immutable after
        # startup.
        sig { returns(T.nilable(OpenAI::Live::SessionResource::Audio)) }
        attr_reader :audio

        sig { params(audio: OpenAI::Live::SessionResource::Audio::OrHash).void }
        attr_writer :audio

        # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        # session. Trusted sideband connections are unaffected.
        sig { returns(T.nilable(OpenAI::Live::ClientConfig)) }
        attr_reader :client

        sig { params(client: OpenAI::Live::ClientConfig::OrHash).void }
        attr_writer :client

        # Who handles tasks delegated by the Live model. Omitted or null selects your
        # application; use `responses` to let the API manage a Responses backend.
        sig { returns(T.nilable(OpenAI::Live::SessionResource::Delegation::Variants)) }
        attr_accessor :delegation

        # Ordered text-only history supplied before startup. Supports developer, user, and
        # assistant messages with one text part each; at most 128 messages and 8,192
        # rendered tokens in total.
        sig {
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Live::InitialItem::Developer,
                  OpenAI::Live::InitialItem::User,
                  OpenAI::Live::InitialItem::Assistant
                )
              ]
            )
          )
        }
        attr_reader :input

        sig {
          params(
            input: T::Array[
              T.any(
                OpenAI::Live::InitialItem::Developer::OrHash,
                OpenAI::Live::InitialItem::User::OrHash,
                OpenAI::Live::InitialItem::Assistant::OrHash
              )
            ]
          )
            .void
        }
        attr_writer :input

        # Frontend instructions for voice, conversation, interruptions, and when to
        # delegate. Start with the
        # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting);
        # put business rules and tool workflows in a separate
        # [backend prompt](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
        # Limited to 16,384 client-supplied tokens. Omitted or blank instructions use
        # server defaults. Immutable after startup.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Whether to store the session for later forking and recording download. Defaults
        # to false for new sessions.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :store

        sig { params(store: T::Boolean).void }
        attr_writer :store

        # The resolved Live session configuration and server-assigned session metadata.
        sig do
          params(

            id: String,

            expires_at: Integer,

            model: T.any(String, OpenAI::Live::SessionResource::Model::OrSymbol),

            audio: OpenAI::Live::SessionResource::Audio::OrHash,

            client: OpenAI::Live::ClientConfig::OrHash,

            delegation: T.nilable(
              T.any(
                OpenAI::Live::ClientDelegation::OrHash,
                OpenAI::Live::SessionResource::Delegation::Responses::OrHash
              )
            ),

            input: T::Array[
              T.any(
                OpenAI::Live::InitialItem::Developer::OrHash,
                OpenAI::Live::InitialItem::User::OrHash,
                OpenAI::Live::InitialItem::Assistant::OrHash
              )
            ],

            instructions: T.nilable(String),

            store: T::Boolean,

            status: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live session. Use this ID for sideband connections,
          # forking, and recording download.
          id:,

          # The Unix timestamp, in seconds, at which the Live session expires.
          expires_at:,

          # The Live model. Required in the session configuration for every transport; do
          # not pass it as a URL query parameter.
          model:,

          # Startup audio configuration. Only primary WebSockets accept audio.format; WebRTC
          # and SIP negotiate their media format. Voice and format are immutable after
          # startup.
          audio: nil,

          # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
          # session. Trusted sideband connections are unaffected.
          client: nil,

          # Who handles tasks delegated by the Live model. Omitted or null selects your
          # application; use `responses` to let the API manage a Responses backend.
          delegation: nil,

          # Ordered text-only history supplied before startup. Supports developer, user, and
          # assistant messages with one text part each; at most 128 messages and 8,192
          # rendered tokens in total.
          input: nil,

          # Frontend instructions for voice, conversation, interruptions, and when to
          # delegate. Start with the
          # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting);
          # put business rules and tool workflows in a separate
          # [backend prompt](https://developers.openai.com/api/docs/guides/live-delegation#start-with-your-existing-backend-prompt).
          # Limited to 16,384 client-supplied tokens. Omitted or blank instructions use
          # server defaults. Immutable after startup.
          instructions: nil,

          # Whether to store the session for later forking and recording download. Defaults
          # to false for new sessions.
          store: nil,

          # The status of the session snapshot. Always `active`, including the final
          # snapshot in session.closed; use the event type to determine that the session has
          # closed.

          status: :active
        )
        end

        sig do
          override.returns(
            {
              id: String,
              expires_at: Integer,
              model: OpenAI::Live::SessionResource::Model::Variants,
              status: Symbol,
              audio: OpenAI::Live::SessionResource::Audio,
              client: OpenAI::Live::ClientConfig,
              delegation: T.nilable(OpenAI::Live::SessionResource::Delegation::Variants),
              input: T::Array[
                T.any(
                  OpenAI::Live::InitialItem::Developer,
                  OpenAI::Live::InitialItem::User,
                  OpenAI::Live::InitialItem::Assistant
                )
              ],
              instructions: T.nilable(String),
              store: T::Boolean
            }
          )
        end
        def to_hash
        end

        # The Live model. Required in the session configuration for every transport; do
        # not pass it as a URL query parameter.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, OpenAI::Live::SessionResource::Model::TaggedSymbol) }

          sig { override.returns(T::Array[OpenAI::Live::SessionResource::Model::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::Live::SessionResource::Model)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_LIVE_1 = T.let(:"gpt-live-1", OpenAI::Live::SessionResource::Model::TaggedSymbol)

        end

        class Audio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::SessionResource::Audio,
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

          # The voice used for speech generated by the Live model.
          sig { returns(T.nilable(OpenAI::Live::SessionResource::Audio::Output)) }
          attr_reader :output

          sig { params(output: OpenAI::Live::SessionResource::Audio::Output::OrHash).void }
          attr_writer :output

          # Startup audio configuration. Only primary WebSockets accept audio.format; WebRTC
          # and SIP negotiate their media format. Voice and format are immutable after
          # startup.
          sig do
            params(

              format_: T.any(
                OpenAI::Live::AudioFormat::AudioPCM::OrHash,
                OpenAI::Live::AudioFormat::AudioPCMU::OrHash,
                OpenAI::Live::AudioFormat::AudioPCMA::OrHash
              ),

              output: OpenAI::Live::SessionResource::Audio::Output::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Audio encoding and sample rate for audio sent and received over a Live WebSocket
            # connection. WebRTC and SIP negotiate their media format separately.
            format_: nil,

            # The voice used for speech generated by the Live model.

            output: nil
          )
          end

          sig do
            override.returns(
              {
                format_: T.any(
                  OpenAI::Live::AudioFormat::AudioPCM,
                  OpenAI::Live::AudioFormat::AudioPCMU,
                  OpenAI::Live::AudioFormat::AudioPCMA
                ),
                output: OpenAI::Live::SessionResource::Audio::Output
              }
            )
          end
          def to_hash
          end

          class Output < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::SessionResource::Audio::Output,
                OpenAI::Internal::AnyHash
              )
            end

            # The voice used for Live speech, as a built-in voice name or a custom voice
            # object containing its ID. Defaults to `marin` and cannot change after startup.
            sig { returns(T.nilable(T.any(String, OpenAI::Live::BuiltInVoice::OrSymbol, OpenAI::Live::CustomVoice))) }
            attr_reader :voice

            sig {
              params(voice: T.any(String, OpenAI::Live::BuiltInVoice::OrSymbol, OpenAI::Live::CustomVoice::OrHash)).void
            }
            attr_writer :voice

            # The voice used for speech generated by the Live model.
            sig do
              params(

                voice: T.any(String, OpenAI::Live::BuiltInVoice::OrSymbol, OpenAI::Live::CustomVoice::OrHash)
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The voice used for Live speech, as a built-in voice name or a custom voice
              # object containing its ID. Defaults to `marin` and cannot change after startup.

              voice: nil
            )
            end

            sig do
              override.returns(
                {voice: T.any(String, OpenAI::Live::BuiltInVoice::OrSymbol, OpenAI::Live::CustomVoice)}
              )
            end
            def to_hash
            end

            # The voice used for Live speech, as a built-in voice name or a custom voice
            # object containing its ID. Defaults to `marin` and cannot change after startup.
            module Voice
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(String, OpenAI::Live::BuiltInVoice::TaggedSymbol, OpenAI::Live::CustomVoice)
              }

              sig { override.returns(T::Array[OpenAI::Live::SessionResource::Audio::Output::Voice::Variants]) }
              def self.variants
              end

            end
          end
        end

        # Who handles tasks delegated by the Live model. Omitted or null selects your
        # application; use `responses` to let the API manage a Responses backend.
        module Delegation
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(OpenAI::Live::ClientDelegation, OpenAI::Live::SessionResource::Delegation::Responses)
          }

          class Responses < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::SessionResource::Delegation::Responses,
                OpenAI::Internal::AnyHash
              )
            end

            # Backend model, prompt, and tools used when the Live session delegates a task to
            # Responses.
            sig { returns(OpenAI::Live::ResponsesDelegationConfig) }
            attr_reader :responses

            sig { params(responses: OpenAI::Live::ResponsesDelegationConfig::OrHash).void }
            attr_writer :responses

            # The delegation owner. Always `responses` for tasks handled by the Responses API.
            sig { returns(Symbol) }
            attr_accessor :type

            # Delegate tasks to a Responses model managed by the Live session.
            sig do
              params(

                responses: OpenAI::Live::ResponsesDelegationConfig::OrHash,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Backend model, prompt, and tools used when the Live session delegates a task to
              # Responses.
              responses:,

              # The delegation owner. Always `responses` for tasks handled by the Responses API.

              type: :responses
            )
            end

            sig do
              override.returns(
                {responses: OpenAI::Live::ResponsesDelegationConfig, type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::SessionResource::Delegation::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
