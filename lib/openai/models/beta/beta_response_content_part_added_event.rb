# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseContentPartAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that was added.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the content part was added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the content part was added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute part
        #   The content part that was added.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Part::ReasoningText]
        required :part, union: -> { OpenAI::Beta::BetaResponseContentPartAddedEvent::Part }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.content_part.added`.
        #
        #   @return [Symbol, :"response.content_part.added"]
        required :type, const: :"response.content_part.added"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseContentPartAddedEvent::Agent }, nil?: true

        # @!method initialize(content_index:, item_id:, output_index:, part:, sequence_number:, agent: nil, type: :"response.content_part.added")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseContentPartAddedEvent} for more details.
        #
        #   Emitted when a new content part is added.
        #
        #   @param content_index [Integer] The index of the content part that was added.
        #
        #   @param item_id [String] The ID of the output item that the content part was added to.
        #
        #   @param output_index [Integer] The index of the output item that the content part was added to.
        #
        #   @param part [OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Part::ReasoningText] The content part that was added.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.content_part.added"] The type of the event. Always `response.content_part.added`.

        # The content part that was added.
        #
        # @see OpenAI::Models::Beta::BetaResponseContentPartAddedEvent#part
        module Part
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Beta::BetaResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Beta::BetaResponseOutputRefusal }

          # Reasoning text from the model.
          variant :reasoning_text, -> { OpenAI::Beta::BetaResponseContentPartAddedEvent::Part::ReasoningText }

          class ReasoningText < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The reasoning text from the model.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   The type of the reasoning text. Always `reasoning_text`.
            #
            #   @return [Symbol, :reasoning_text]
            required :type, const: :reasoning_text

            # @!method initialize(text:, type: :reasoning_text)
            #   Reasoning text from the model.
            #
            #   @param text [String] The reasoning text from the model.
            #
            #   @param type [Symbol, :reasoning_text] The type of the reasoning text. Always `reasoning_text`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Part::ReasoningText)]
        end

        # @see OpenAI::Models::Beta::BetaResponseContentPartAddedEvent#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that owns this multi-agent streaming event.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseContentPartAddedEvent = Beta::BetaResponseContentPartAddedEvent
  end
end
