# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the text delta was added to.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The text delta that was added.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the output item that the text delta was added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute logprobs
        #   The log probabilities of the tokens in the delta.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Logprob>]
        required :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob] }

        # @!attribute output_index
        #   The index of the output item that the text delta was added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_text.delta`.
        #
        #   @return [Symbol, :"response.output_text.delta"]
        required :type, const: :"response.output_text.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseTextDeltaEvent::Agent }, nil?: true

        # @!method initialize(content_index:, delta:, item_id:, logprobs:, output_index:, sequence_number:, agent: nil, type: :"response.output_text.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseTextDeltaEvent} for more details.
        #
        #   Emitted when there is an additional text delta.
        #
        #   @param content_index [Integer] The index of the content part that the text delta was added to.
        #
        #   @param delta [String] The text delta that was added.
        #
        #   @param item_id [String] The ID of the output item that the text delta was added to.
        #
        #   @param logprobs [Array<OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Logprob>] The log probabilities of the tokens in the delta.
        #
        #   @param output_index [Integer] The index of the output item that the text delta was added to.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.output_text.delta"] The type of the event. Always `response.output_text.delta`.

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute token
          #   A possible text token.
          #
          #   @return [String]
          required :token, String

          # @!attribute logprob
          #   The log probability of this token.
          #
          #   @return [Float]
          required :logprob, Float

          # @!attribute top_logprobs
          #   The log probabilities of up to 20 of the most likely tokens.
          #
          #   @return [Array<OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob>, nil]
          optional :top_logprobs,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob] }

          # @!method initialize(token:, logprob:, top_logprobs: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Logprob} for more details.
          #
          #   A logprob is the logarithmic probability that the model assigns to producing a
          #   particular token at a given position in the sequence. Less-negative (higher)
          #   logprob values indicate greater model confidence in that token choice.
          #
          #   @param token [String] A possible text token.
          #
          #   @param logprob [Float] The log probability of this token.
          #
          #   @param top_logprobs [Array<OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob>] The log probabilities of up to 20 of the most likely tokens.

          class TopLogprob < OpenAI::Internal::Type::BaseModel
            # @!attribute token
            #   A possible text token.
            #
            #   @return [String, nil]
            optional :token, String

            # @!attribute logprob
            #   The log probability of this token.
            #
            #   @return [Float, nil]
            optional :logprob, Float

            # @!method initialize(token: nil, logprob: nil)
            #   @param token [String] A possible text token.
            #
            #   @param logprob [Float] The log probability of this token.
          end
        end

        # @see OpenAI::Models::Beta::BetaResponseTextDeltaEvent#agent
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

    BetaResponseTextDeltaEvent = Beta::BetaResponseTextDeltaEvent
  end
end
