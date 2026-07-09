# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseImageGenCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The unique identifier of the image generation item being processed.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.image_generation_call.completed'.
        #
        #   @return [Symbol, :"response.image_generation_call.completed"]
        required :type, const: :"response.image_generation_call.completed"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseImageGenCallCompletedEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, type: :"response.image_generation_call.completed")
        #   Emitted when an image generation tool call has completed and the final image is
        #   available.
        #
        #   @param item_id [String] The unique identifier of the image generation item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.image_generation_call.completed"] The type of the event. Always 'response.image_generation_call.completed'.

        # @see OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent#agent
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

    BetaResponseImageGenCallCompletedEvent = Beta::BetaResponseImageGenCallCompletedEvent
  end
end
