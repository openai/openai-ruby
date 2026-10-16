# typed: strong

module OpenAI
  module Models

    module Live

      class MediaSessionConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::MediaSessionConfig,
            OpenAI::Internal::AnyHash
          )
        end

        # The Live model. Required in the session configuration for every transport; do
        # not pass it as a URL query parameter.
        sig { returns(T.any(String, OpenAI::Live::MediaSessionConfig::Model::OrSymbol)) }
        attr_accessor :model

        # Startup audio configuration. WebRTC and SIP negotiate their audio format on the
        # media transport.
        sig { returns(T.nilable(OpenAI::Live::MediaSessionConfig::Audio)) }
        attr_reader :audio

        sig { params(audio: OpenAI::Live::MediaSessionConfig::Audio::OrHash).void }
        attr_writer :audio

        # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
        # session. Trusted sideband connections are unaffected.
        sig { returns(T.nilable(OpenAI::Live::ClientConfig)) }
        attr_reader :client

        sig { params(client: OpenAI::Live::ClientConfig::OrHash).void }
        attr_writer :client

        # Who handles tasks delegated by the Live model. Omitted or null selects your
        # application; use `responses` or `decisions` to delegate to the corresponding
        # API.
        sig {
          returns(
            T.nilable(
              T.any(
                OpenAI::Live::ClientDelegation,
                OpenAI::Live::MediaSessionConfig::Delegation::Responses,
                OpenAI::Live::MediaSessionConfig::Delegation::Decisions
              )
            )
          )
        }
        attr_accessor :delegation

        # Ordered text-only history supplied before startup. Supports developer, user, and
        # assistant messages with one text part each; at most 128 messages and a
        # configured rendered-token limit (8,192 by default).
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

        # At most one Decisions trigger per transcript event type. Triggers run
        # independently of delegation. On update, omit triggers to keep the current
        # configuration, send a list to replace it, or send an empty list to disable
        # triggers.
        sig { returns(T.nilable(T::Array[OpenAI::Live::DecisionTrigger])) }
        attr_reader :triggers

        sig { params(triggers: T::Array[OpenAI::Live::DecisionTrigger::OrHash]).void }
        attr_writer :triggers

        # Startup configuration for a Live media session. Follow the
        # [Live prompting guide](https://developers.openai.com/api/docs/guides/live-prompting)
        # when writing frontend instructions and the backend prompt under
        # delegation.responses.instructions.
        sig do
          params(

            model: T.any(String, OpenAI::Live::MediaSessionConfig::Model::OrSymbol),

            audio: OpenAI::Live::MediaSessionConfig::Audio::OrHash,

            client: OpenAI::Live::ClientConfig::OrHash,

            delegation: T.nilable(
              T.any(
                OpenAI::Live::ClientDelegation::OrHash,
                OpenAI::Live::MediaSessionConfig::Delegation::Responses::OrHash,
                OpenAI::Live::MediaSessionConfig::Delegation::Decisions::OrHash
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

            triggers: T::Array[OpenAI::Live::DecisionTrigger::OrHash]
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The Live model. Required in the session configuration for every transport; do
          # not pass it as a URL query parameter.
          model:,

          # Startup audio configuration. WebRTC and SIP negotiate their audio format on the
          # media transport.
          audio: nil,

          # Startup-only capabilities for an untrusted frontend attached to a unified WebRTC
          # session. Trusted sideband connections are unaffected.
          client: nil,

          # Who handles tasks delegated by the Live model. Omitted or null selects your
          # application; use `responses` or `decisions` to delegate to the corresponding
          # API.
          delegation: nil,

          # Ordered text-only history supplied before startup. Supports developer, user, and
          # assistant messages with one text part each; at most 128 messages and a
          # configured rendered-token limit (8,192 by default).
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
              model: T.any(String, OpenAI::Live::MediaSessionConfig::Model::OrSymbol),
              audio: OpenAI::Live::MediaSessionConfig::Audio,
              client: OpenAI::Live::ClientConfig,
              delegation: T.nilable(
                T.any(
                  OpenAI::Live::ClientDelegation,
                  OpenAI::Live::MediaSessionConfig::Delegation::Responses,
                  OpenAI::Live::MediaSessionConfig::Delegation::Decisions
                )
              ),
              input: T::Array[
                T.any(
                  OpenAI::Live::InitialItem::Developer,
                  OpenAI::Live::InitialItem::User,
                  OpenAI::Live::InitialItem::Assistant
                )
              ],
              instructions: T.nilable(String),
              store: T::Boolean,
              triggers: T::Array[OpenAI::Live::DecisionTrigger]
            }
          )
        end
        def to_hash
        end

        # The Live model. Required in the session configuration for every transport; do
        # not pass it as a URL query parameter.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, OpenAI::Live::MediaSessionConfig::Model::TaggedSymbol) }

          sig { override.returns(T::Array[OpenAI::Live::MediaSessionConfig::Model::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::Live::MediaSessionConfig::Model)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_LIVE_1 = T.let(:"gpt-live-1", OpenAI::Live::MediaSessionConfig::Model::TaggedSymbol)

        end

        class Audio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::MediaSessionConfig::Audio,
              OpenAI::Internal::AnyHash
            )
          end

          # Settings for speech generated by the Live model. Choose the voice before
          # starting the session.
          sig { returns(T.nilable(OpenAI::Live::MediaSessionConfig::Audio::Output)) }
          attr_reader :output

          sig { params(output: OpenAI::Live::MediaSessionConfig::Audio::Output::OrHash).void }
          attr_writer :output

          # Startup audio configuration. WebRTC and SIP negotiate their audio format on the
          # media transport.
          sig do
            params(

              output: OpenAI::Live::MediaSessionConfig::Audio::Output::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Settings for speech generated by the Live model. Choose the voice before
            # starting the session.

            output: nil
          )
          end

          sig do
            override.returns(
              {output: OpenAI::Live::MediaSessionConfig::Audio::Output}
            )
          end
          def to_hash
          end

          class Output < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::MediaSessionConfig::Audio::Output,
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

            # Settings for speech generated by the Live model. Choose the voice before
            # starting the session.
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

              sig { override.returns(T::Array[OpenAI::Live::MediaSessionConfig::Audio::Output::Voice::Variants]) }
              def self.variants
              end

            end
          end
        end

        # Who handles tasks delegated by the Live model. Omitted or null selects your
        # application; use `responses` or `decisions` to delegate to the corresponding
        # API.
        module Delegation
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::ClientDelegation,
              OpenAI::Live::MediaSessionConfig::Delegation::Responses,
              OpenAI::Live::MediaSessionConfig::Delegation::Decisions
            )
          }

          class Responses < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::MediaSessionConfig::Delegation::Responses,
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

          class Decisions < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::MediaSessionConfig::Delegation::Decisions,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(OpenAI::Live::DecisionsDelegationConfig) }
            attr_reader :decisions

            sig { params(decisions: OpenAI::Live::DecisionsDelegationConfig::OrHash).void }
            attr_writer :decisions

            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(

                decisions: OpenAI::Live::DecisionsDelegationConfig::OrHash,

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              decisions:,

              type: :decisions
            )
            end

            sig do
              override.returns(
                {decisions: OpenAI::Live::DecisionsDelegationConfig, type: Symbol}
              )
            end
            def to_hash
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::MediaSessionConfig::Delegation::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
