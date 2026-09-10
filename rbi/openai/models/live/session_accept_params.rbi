# typed: strong

module OpenAI
  module Models

    module Live

      class SessionAcceptParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionAcceptParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :session_id

        # Model and startup configuration for the Live session that answers the incoming
        # SIP call.
        sig { returns(OpenAI::Live::SessionAcceptParams::Session) }
        attr_reader :session

        sig { params(session: OpenAI::Live::SessionAcceptParams::Session::OrHash).void }
        attr_writer :session

        sig do
          params(

            session_id: String,

            session: OpenAI::Live::SessionAcceptParams::Session::OrHash,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          session_id:,

          # Model and startup configuration for the Live session that answers the incoming
          # SIP call.
          session:,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              session_id: String,
              session: OpenAI::Live::SessionAcceptParams::Session,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class Session < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::SessionAcceptParams::Session,
              OpenAI::Internal::AnyHash
            )
          end

          # The Live model to use for the accepted call.
          sig { returns(T.any(String, OpenAI::Live::SessionAcceptParams::Session::Model::OrSymbol)) }
          attr_accessor :model

          # The session type. Always `live`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Startup audio output configuration. SIP negotiates the media format;
          # audio.format is only accepted for primary WebSockets. Voice cannot change after
          # startup.
          sig { returns(T.nilable(OpenAI::Live::SessionAcceptParams::Session::Audio)) }
          attr_reader :audio

          sig { params(audio: OpenAI::Live::SessionAcceptParams::Session::Audio::OrHash).void }
          attr_writer :audio

          # Who handles tasks delegated by the Live model. Omitted or null selects your
          # application; use `responses` to let the API manage a Responses backend.
          sig {
            returns(
              T.nilable(
                T.any(OpenAI::Live::ClientDelegation, OpenAI::Live::SessionAcceptParams::Session::Delegation::Responses)
              )
            )
          }
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

          # Model and startup configuration for the Live session that answers the incoming
          # SIP call.
          sig do
            params(

              model: T.any(String, OpenAI::Live::SessionAcceptParams::Session::Model::OrSymbol),

              audio: OpenAI::Live::SessionAcceptParams::Session::Audio::OrHash,

              delegation: T.nilable(
                T.any(
                  OpenAI::Live::ClientDelegation::OrHash,
                  OpenAI::Live::SessionAcceptParams::Session::Delegation::Responses::OrHash
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

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The Live model to use for the accepted call.
            model:,

            # Startup audio output configuration. SIP negotiates the media format;
            # audio.format is only accepted for primary WebSockets. Voice cannot change after
            # startup.
            audio: nil,

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

            # The session type. Always `live`.

            type: :live
          )
          end

          sig do
            override.returns(
              {
                model: T.any(String, OpenAI::Live::SessionAcceptParams::Session::Model::OrSymbol),
                type: Symbol,
                audio: OpenAI::Live::SessionAcceptParams::Session::Audio,
                delegation: T.nilable(
                  T.any(
                    OpenAI::Live::ClientDelegation,
                    OpenAI::Live::SessionAcceptParams::Session::Delegation::Responses
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
                store: T::Boolean
              }
            )
          end
          def to_hash
          end

          # The Live model to use for the accepted call.
          module Model
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, OpenAI::Live::SessionAcceptParams::Session::Model::TaggedSymbol) }

            sig { override.returns(T::Array[OpenAI::Live::SessionAcceptParams::Session::Model::Variants]) }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Live::SessionAcceptParams::Session::Model)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            GPT_LIVE_1 = T.let(:"gpt-live-1", OpenAI::Live::SessionAcceptParams::Session::Model::TaggedSymbol)

          end

          class Audio < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::SessionAcceptParams::Session::Audio,
                OpenAI::Internal::AnyHash
              )
            end

            # Settings for speech generated by the Live model. Choose the voice before
            # starting the session.
            sig { returns(T.nilable(OpenAI::Live::SessionAcceptParams::Session::Audio::Output)) }
            attr_reader :output

            sig { params(output: OpenAI::Live::SessionAcceptParams::Session::Audio::Output::OrHash).void }
            attr_writer :output

            # Startup audio output configuration. SIP negotiates the media format;
            # audio.format is only accepted for primary WebSockets. Voice cannot change after
            # startup.
            sig do
              params(

                output: OpenAI::Live::SessionAcceptParams::Session::Audio::Output::OrHash
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
                {output: OpenAI::Live::SessionAcceptParams::Session::Audio::Output}
              )
            end
            def to_hash
            end

            class Output < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::SessionAcceptParams::Session::Audio::Output,
                  OpenAI::Internal::AnyHash
                )
              end

              # The voice used for Live speech, as a built-in voice name or a custom voice
              # object containing its ID. Defaults to `marin` and cannot change after startup.
              sig {
                returns(T.nilable(T.any(String, OpenAI::Live::BuiltInVoice::OrSymbol, OpenAI::Live::CustomVoice)))
              }
              attr_reader :voice

              sig {
                params(voice: T.any(String, OpenAI::Live::BuiltInVoice::OrSymbol, OpenAI::Live::CustomVoice::OrHash))
                  .void
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

                sig {
                  override.returns(T::Array[OpenAI::Live::SessionAcceptParams::Session::Audio::Output::Voice::Variants])
                }
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
              T.any(OpenAI::Live::ClientDelegation, OpenAI::Live::SessionAcceptParams::Session::Delegation::Responses)
            }

            class Responses < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::SessionAcceptParams::Session::Delegation::Responses,
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

            sig { override.returns(T::Array[OpenAI::Live::SessionAcceptParams::Session::Delegation::Variants]) }
            def self.variants
            end

          end
        end

      end

    end

  end
end
