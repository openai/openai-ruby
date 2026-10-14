# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseErrorEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The error code.
        #
        #   @return [String, nil]
        required :code, String, nil?: true

        # @!attribute message
        #   The error message.
        #
        #   @return [String]
        required :message, String

        # @!attribute param
        #   The error parameter.
        #
        #   @return [String, nil]
        required :param, String, nil?: true

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `error`.
        #
        #   @return [Symbol, :error]
        required :type, const: :error

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseErrorEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseErrorEvent::Agent }, nil?: true

        # @!method initialize(code:, message:, param:, sequence_number:, agent: nil, type: :error)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseErrorEvent} for more details.
        #
        #   Emitted when an error occurs.
        #
        #   @param code [String, nil] The error code.
        #
        #   @param message [String] The error message.
        #
        #   @param param [String, nil] The error parameter.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseErrorEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :error] The type of the event. Always `error`.

        # @see OpenAI::Models::Beta::BetaResponseErrorEvent#agent
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

    BetaResponseErrorEvent = Beta::BetaResponseErrorEvent
  end
end
