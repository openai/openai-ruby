# typed: strong

module OpenAI
  module Models
    BetaResponseContentPartDoneEvent = Beta::BetaResponseContentPartDoneEvent

    module Beta
      class BetaResponseContentPartDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseContentPartDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part that is done.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the content part was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the content part was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The content part that is done.
        sig do
          returns(
            OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::Variants
          )
        end
        attr_accessor :part

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.content_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent)
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a content part is done.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            part:
              T.any(
                OpenAI::Beta::BetaResponseOutputText::OrHash,
                OpenAI::Beta::BetaResponseOutputRefusal::OrHash,
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::ReasoningText::OrHash
              ),
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that is done.
          content_index:,
          # The ID of the output item that the content part was added to.
          item_id:,
          # The index of the output item that the content part was added to.
          output_index:,
          # The content part that is done.
          part:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.content_part.done`.
          type: :"response.content_part.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::Variants,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent)
            }
          )
        end
        def to_hash
        end

        # The content part that is done.
        module Part
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputText,
                OpenAI::Beta::BetaResponseOutputRefusal,
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::ReasoningText
              )
            end

          class ReasoningText < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::ReasoningText,
                  OpenAI::Internal::AnyHash
                )
              end

            # The reasoning text from the model.
            sig { returns(String) }
            attr_accessor :text

            # The type of the reasoning text. Always `reasoning_text`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Reasoning text from the model.
            sig { params(text: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The reasoning text from the model.
              text:,
              # The type of the reasoning text. Always `reasoning_text`.
              type: :reasoning_text
            )
            end

            sig { override.returns({ text: String, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
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
      end
    end
  end
end
