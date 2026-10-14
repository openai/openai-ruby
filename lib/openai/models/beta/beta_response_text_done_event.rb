# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the text content is finalized.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the text content is finalized.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute logprobs
        #   The log probabilities of the tokens in the delta.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseTextDoneEvent::Logprob>]
        required :logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseTextDoneEvent::Logprob] }

        # @!attribute output_index
        #   The index of the output item that the text content is finalized.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute text
        #   The text content that is finalized.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `response.output_text.done`.
        #
        #   @return [Symbol, :"response.output_text.done"]
        required :type, const: :"response.output_text.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseTextDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseTextDoneEvent::Agent }, nil?: true

        # @!method initialize(content_index:, item_id:, logprobs:, output_index:, sequence_number:, text:, agent: nil, type: :"response.output_text.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseTextDoneEvent} for more details.
        #
        #   Emitted when text content is finalized.
        #
        #   @param content_index [Integer] The index of the content part that the text content is finalized.
        #
        #   @param item_id [String] The ID of the output item that the text content is finalized.
        #
        #   @param logprobs [Array<OpenAI::Models::Beta::BetaResponseTextDoneEvent::Logprob>] The log probabilities of the tokens in the delta.
        #
        #   @param output_index [Integer] The index of the output item that the text content is finalized.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param text [String] The text content that is finalized.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseTextDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.output_text.done"] The type of the event. Always `response.output_text.done`.

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
          #   @return [Array<OpenAI::Models::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob>, nil]
          optional :top_logprobs,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob] }

          # @!method initialize(token:, logprob:, top_logprobs: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseTextDoneEvent::Logprob} for more details.
          #
          #   A logprob is the logarithmic probability that the model assigns to producing a
          #   particular token at a given position in the sequence. Less-negative (higher)
          #   logprob values indicate greater model confidence in that token choice.
          #
          #   @param token [String] A possible text token.
          #
          #   @param logprob [Float] The log probability of this token.
          #
          #   @param top_logprobs [Array<OpenAI::Models::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob>] The log probabilities of up to 20 of the most likely tokens.

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

        # @see OpenAI::Models::Beta::BetaResponseTextDoneEvent#agent
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

    BetaResponseTextDoneEvent = Beta::BetaResponseTextDoneEvent
  end
end
