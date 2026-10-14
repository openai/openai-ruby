# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseOutputMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the output message.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The content of the output message.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal>]
        required :content,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseOutputMessage::Content] }

        # @!attribute role
        #   The role of the output message. Always `assistant`.
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute status
        #   The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseOutputMessage::Status]
        required :status, enum: -> { OpenAI::Beta::BetaResponseOutputMessage::Status }

        # @!attribute type
        #   The type of the output message. Always `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseOutputMessage::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseOutputMessage::Agent }, nil?: true

        # @!attribute phase
        #   Labels an `assistant` message as intermediate commentary (`commentary`) or the
        #   final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        #   sending follow-up requests, preserve and resend phase on all assistant messages
        #   — dropping it can degrade performance. Not used for user messages.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseOutputMessage::Phase, nil]
        optional :phase, enum: -> { OpenAI::Beta::BetaResponseOutputMessage::Phase }, nil?: true

        # @!method initialize(id:, content:, status:, agent: nil, phase: nil, role: :assistant, type: :message)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseOutputMessage} for more details.
        #
        #   An output message from the model.
        #
        #   @param id [String] The unique ID of the output message.
        #
        #   @param content [Array<OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal>] The content of the output message.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseOutputMessage::Status] The status of the message input. One of `in_progress`, `completed`, or
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseOutputMessage::Agent, nil] The agent that produced this item.
        #
        #   @param phase [Symbol, OpenAI::Models::Beta::BetaResponseOutputMessage::Phase, nil] Labels an `assistant` message as intermediate commentary (`commentary`) or the f
        #
        #   @param role [Symbol, :assistant] The role of the output message. Always `assistant`.
        #
        #   @param type [Symbol, :message] The type of the output message. Always `message`.

        # A text output from the model.
        module Content
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Beta::BetaResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Beta::BetaResponseOutputRefusal }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal)]
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        #
        # @see OpenAI::Models::Beta::BetaResponseOutputMessage#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseOutputMessage#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end

        # Labels an `assistant` message as intermediate commentary (`commentary`) or the
        # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        # sending follow-up requests, preserve and resend phase on all assistant messages
        # — dropping it can degrade performance. Not used for user messages.
        #
        # @see OpenAI::Models::Beta::BetaResponseOutputMessage#phase
        module Phase
          extend OpenAI::Internal::Type::Enum

          COMMENTARY = :commentary
          FINAL_ANSWER = :final_answer

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    BetaResponseOutputMessage = Beta::BetaResponseOutputMessage
  end
end
