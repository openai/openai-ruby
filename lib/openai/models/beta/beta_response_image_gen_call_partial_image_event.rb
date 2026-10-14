# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseImageGenCallPartialImageEvent < OpenAI::Internal::Type::BaseModel
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

        # @!attribute partial_image_b64
        #   Base64-encoded partial image data, suitable for rendering as an image.
        #
        #   @return [String]
        required :partial_image_b64, String

        # @!attribute partial_image_index
        #   0-based index for the partial image (backend is 1-based, but this is 0-based for
        #   the user).
        #
        #   @return [Integer]
        required :partial_image_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the image generation item being processed.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.image_generation_call.partial_image'.
        #
        #   @return [Symbol, :"response.image_generation_call.partial_image"]
        required :type, const: :"response.image_generation_call.partial_image"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent }, nil?: true

        # @!method initialize(item_id:, output_index:, partial_image_b64:, partial_image_index:, sequence_number:, agent: nil, type: :"response.image_generation_call.partial_image")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent} for more
        #   details.
        #
        #   Emitted when a partial image is available during image generation streaming.
        #
        #   @param item_id [String] The unique identifier of the image generation item being processed.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param partial_image_b64 [String] Base64-encoded partial image data, suitable for rendering as an image.
        #
        #   @param partial_image_index [Integer] 0-based index for the partial image (backend is 1-based, but this is 0-based for
        #
        #   @param sequence_number [Integer] The sequence number of the image generation item being processed.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.image_generation_call.partial_image"] The type of the event. Always 'response.image_generation_call.partial_image'.

        # @see OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent#agent
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

    BetaResponseImageGenCallPartialImageEvent = Beta::BetaResponseImageGenCallPartialImageEvent
  end
end
