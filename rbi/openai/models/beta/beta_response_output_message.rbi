# typed: strong

module OpenAI
  module Models
    BetaResponseOutputMessage = Beta::BetaResponseOutputMessage

    module Beta
      class BetaResponseOutputMessage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseOutputMessage,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the output message.
        sig { returns(String) }
        attr_accessor :id

        # The content of the output message.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Beta::BetaResponseOutputText,
                OpenAI::Beta::BetaResponseOutputRefusal
              )
            ]
          )
        end
        attr_accessor :content

        # The role of the output message. Always `assistant`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        sig do
          returns(OpenAI::Beta::BetaResponseOutputMessage::Status::OrSymbol)
        end
        attr_accessor :status

        # The type of the output message. Always `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that produced this item.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseOutputMessage::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseOutputMessage::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Labels an `assistant` message as intermediate commentary (`commentary`) or the
        # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        # sending follow-up requests, preserve and resend phase on all assistant messages
        # — dropping it can degrade performance. Not used for user messages.
        sig do
          returns(
            T.nilable(OpenAI::Beta::BetaResponseOutputMessage::Phase::OrSymbol)
          )
        end
        attr_accessor :phase

        # An output message from the model.
        sig do
          params(
            id: String,
            content:
              T::Array[
                T.any(
                  OpenAI::Beta::BetaResponseOutputText::OrHash,
                  OpenAI::Beta::BetaResponseOutputRefusal::OrHash
                )
              ],
            status: OpenAI::Beta::BetaResponseOutputMessage::Status::OrSymbol,
            agent:
              T.nilable(OpenAI::Beta::BetaResponseOutputMessage::Agent::OrHash),
            phase:
              T.nilable(
                OpenAI::Beta::BetaResponseOutputMessage::Phase::OrSymbol
              ),
            role: Symbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the output message.
          id:,
          # The content of the output message.
          content:,
          # The status of the message input. One of `in_progress`, `completed`, or
          # `incomplete`. Populated when input items are returned via API.
          status:,
          # The agent that produced this item.
          agent: nil,
          # Labels an `assistant` message as intermediate commentary (`commentary`) or the
          # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
          # sending follow-up requests, preserve and resend phase on all assistant messages
          # — dropping it can degrade performance. Not used for user messages.
          phase: nil,
          # The role of the output message. Always `assistant`.
          role: :assistant,
          # The type of the output message. Always `message`.
          type: :message
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaResponseOutputText,
                    OpenAI::Beta::BetaResponseOutputRefusal
                  )
                ],
              role: Symbol,
              status: OpenAI::Beta::BetaResponseOutputMessage::Status::OrSymbol,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseOutputMessage::Agent),
              phase:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputMessage::Phase::OrSymbol
                )
            }
          )
        end
        def to_hash
        end

        # A text output from the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputText,
                OpenAI::Beta::BetaResponseOutputRefusal
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseOutputMessage::Content::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaResponseOutputMessage::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Beta::BetaResponseOutputMessage::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Beta::BetaResponseOutputMessage::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Beta::BetaResponseOutputMessage::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseOutputMessage::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputMessage::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that produced this item.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end

        # Labels an `assistant` message as intermediate commentary (`commentary`) or the
        # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        # sending follow-up requests, preserve and resend phase on all assistant messages
        # — dropping it can degrade performance. Not used for user messages.
        module Phase
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaResponseOutputMessage::Phase)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMMENTARY =
            T.let(
              :commentary,
              OpenAI::Beta::BetaResponseOutputMessage::Phase::TaggedSymbol
            )
          FINAL_ANSWER =
            T.let(
              :final_answer,
              OpenAI::Beta::BetaResponseOutputMessage::Phase::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseOutputMessage::Phase::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
